---
title: "Index Priority Queue: Cải tiến Priority Queue"
slug: "index-priority-queue"
date: 2021-07-29T20:17:38+07:00
draft: false
categories:
- "Lập trình"
- "Cấu trúc dữ liệu và Giải thuật"
tags:
- "data structures"
keywords:
- "queue"
- "java"
- "priority queue"
- "index priority queue"
- "indexed priority queue"
thumbnailImage: /thumbnails/priority-queue.png
thumbnailImagePosition: left
---

Ở bài viết [Priority Queue và những cách cài đặt]({{< ref "/post/software/priority-queue" >}}), mình đã giới thiệu qua cấu trúc Priority Queue, những đặc trưng và cách cài đặt. Tuy nhiên trong một số trường hợp, chúng ta sẽ có nhu cầu cập nhật hoặc xóa phần tử khỏi Queue thông qua một index. Trong bài viết này chúng ta sẽ cùng cải tiến Priority Queue để có thể thực hiện các chức năng trên.

<!--more-->

<!--toc-->

# 1. Ý tưởng và API

Index Priority Queue cũng là một Priority Queue nhưng hỗ trợ thêm tính năng tham chiếu đến một phần tử trong queue thông qua index. 

Các phương thức giao tiếp với bên ngoài của `IndexPriorityQueue` có thể được định nghĩa dưới dạng interface như sau:

```java
public interface IndexPriorityQueue<T extends Comparable<T>> {
    void insert(int i, T item);
    void change(int i, T item);
    boolean contains(int i);
    void delete(int i);
    T peek();
    int peekIndex();
    int removePeek();
    boolean isEmpty();
    int size();
}
```

Các phương thức cơ bản như sau:

- *insert(int i, T item)*: Thêm mới phần tử thuộc kiểu `T` có index là `i`.
- *change(int i, T item)*: Thay đổi bằng một phần tử kiểu `T` khác ở index `i` .
- *contains(int i)*: Kiểm tra index `i` có tồn tại trong queue hay không.
- *delete(int i)*: Xóa index `i` ra khỏi queue.
- *peek()*: Lấy ra phần tử ưu tiên nhất.
- *peekIndex()*: Lấy ra index của phần tử ưu tiên nhất.
- *removePeek()*: Xóa phần tử ưu tiên nhất và trả về index của nó.
- *isEmpty()*: Kiểm tra queue có rỗng hay không.
- *size()*: Lấy kích thước queue.

Công việc của chúng ta là cài đặt cấu trúc dữ liệu Index Priority Queue dựa trên cách cài đặt Priority Queue ở bài viết trước.

# 2. Cài đặt

Tương tự Priority Queue, Index Priority Queue sẽ được cài đặt dựa trên Heap. Nếu chưa biết Heap là gì, các bạn có thể xem lại bài viết [Heap và một số ghi chú]({{< ref "/post/software/heap-note" >}}).

Để lưu trữ các phần tử dựa trên index, mình sử dụng mảng `keys` với chỉ số mảng chính là index. Lúc này không thể dựng Heap trên `keys`, ta cần có một mảng `pq` với giá trị là index của phần tử trong `keys`. Nghĩa là, Heap của chúng ta sẽ nằm trên `pq`, khi lấy ra phần tử ưu tiên nhất trong `pq` thì giá trị của nó chính là index của phần tử ưu tiên nhất, tra cứu trong mảng `keys` sẽ được phần tử cần tìm. 

Ngoài ra, khi thực hiện một số thao tác như xóa phần tử có index `i` thì phải tìm ra vị trí của index `i` trong `pq`. Để làm điều này đơn giản hơn, ta có thể lưu một mảng `qp` với chỉ số là index và giá trị là vị trí của index `i` trong `pq`. Nói cách khác, mảng `qp` chính là tham chiếu ngược của `pq`.

## 2.1. Các thao tác cơ bản

Ở phần này, chúng ta sẽ cài đặt các thao tác đơn giản trước để có thể cài đặt các thao tác khó hơn.

Trước hết cài đặt class `IndexPQ` là một implementation của `IndexPriorityQueue`.

```java
public class IndexPQ<T extends Comparable<T>> implements IndexPriorityQueue<T> {
    private int size;
    private int maxSize;
    private T[] keys;
    private int[] pq;
    private int[] qp;
}
```

Mảng `qp` tham chiếu từ index đến vị trí trong `pq` nên còn có thể dùng để kiểm tra index có tồn tại trong queue hay không. Giá trị `-1` được dùng để biểu thị không tồn tại index `i` trong queue. Do vậy, constructor sẽ khởi tạo các mảng cần dùng và giá trị -1 cho mảng `qp`.

```java
public IndexPQ(int maxSize) {
    if (maxSize < 0)
        throw new IllegalArgumentException();
    this.maxSize = maxSize;
    this.size = 0;
    this.keys = (T[]) new Comparable[maxSize];
    this.pq = new int[maxSize];
    this.qp = new int[maxSize];
    Arrays.fill(qp, -1);
}
```

Phương thức `contains()` sẽ kiểm tra trong mảng `qp` để biết được index đã có trong queue hay chưa.

```java
@Override
public boolean contains(int i) {
    return qp[i] != -1;
}
```

Kiểm tra mảng rỗng và lấy kích thước cũng khá đơn giản.

```java
@Override
public boolean isEmpty() {
    return size == 0;
}

@Override
public int size() {
    return size;
}
```

Để lấy phần tử ưu tiên nhất, trước hết phải lấy được index của phần tử này trong `pq` rồi sao đó tham chiếu vào `keys` để lấy ra phần tử này.

```java
public T peek() {
    if (size == 0)
        throw new NoSuchElementException("Priority queue underflow");
    return keys[pq[0]];
}

public int peekIndex() {
    if (size == 0)
        throw new NoSuchElementException("Priority queue underflow");
    return pq[0];
}
```

Ngoài ra, để thao tác trên Heap chúng ta cần cài đặt các hàm utility để hiệu chỉnh Heap theo cơ chế Bottom-Up và Top-Down. Việc hiệu chỉnh Heap sẽ thực hiện trên cả `pq` và `qp`. Tham khảo bài viết [Heap và một số ghi chú]({{< ref "/post/software/heap-note" >}}) để hiểu thêm về các hàm này. Định nghĩa *ưu tiên* ở đây là *lớn hơn thì ưu tiên hơn*.

```java
private void swim(int i) {
    while (i > 0 && keys[(i - 1) / 2].compareTo(keys[i]) < 0) {
        swap((i - 1) / 2, i);
        i = (i - 1) / 2;
    }
}

private void swap(int i, int j) {
    int t = pq[i];
    pq[i] = pq[j];
    pq[j] = t;
    qp[pq[i]] = i;
    qp[pq[j]] = j;
}

private void sink(int i) {
    while (2*i + 1 <= size - 1) {
        int largest = 2*i + 1;
        if (largest < size - 1 && keys[largest].compareTo(keys[largest + 1]) < 0)
        largest++;
        if (keys[i].compareTo(keys[largest]) >= 0)
        break;
        swap(i, largest);
        i = largest;
    }
}
```

## 2.2. Insert và Change

*Thao tác insert* sẽ thêm một phần tử với index `i` vào `keys`, đồng thời thêm `i` cuối mảng `pq`. Do đó có thể vi phạm tính chất của Heap nên cần được hiệu chỉnh theo chiến lược Bottom-Up.

```java
@Override
public void insert(int i, T item) {
    if (contains(i))
        throw new IllegalArgumentException("index already in priority queue");
    this.size++;
    this.keys[i] = item;
    this.pq[size - 1] = i;
    this.qp[i] = size - 1;
    swim(size - 1);
}
```

*Thao tác change* không xóa đi hay thêm vào một phần tử mới nhưng nó thay thế một phần tử này bằng một phần tử khác có độ ưu tiên khác biệt. Do đó, nó có thể vi phạm tính chất của Heap nên cần được hiệu chỉnh lại. Phần tử được thay thế có thể nằm ở giữa của mảng Heap nên cần phải được hiệu chỉnh theo cả hai chiến lược Bottom-Up và Top-Down.

```java
@Override
public void change(int i, T item) {
    if (!contains(i))
        throw new NoSuchElementException("index is not in the priority queue");
    keys[i] = item;
    swim(qp[i]);
    sink(qp[i]);
}
```

## 2.3. Thao tác xóa

Để thực hiện thao tác xóa một phần tử có index `i`, trước hết lấy vị trí của nó trong `pq` bằng cách sử dụng `qp`. Sau khi có vị trí trong `pq`, ta tráo phần tử đó với phần tử cuối của `pq` rồi loại bỏ phần tử này. Tại vị trí tráo sẽ vi phạm tính chất của Heap. Do index `i` có thể nằm giữa Heap nên cần hiệu chỉnh theo cả hai chiến lược Bottom-Up và Top-Down.

```java
@Override
public void delete(int i) {
    if (!contains(i))
        throw new NoSuchElementException("index is not in the priority queue");
    int index = qp[i];
    swap(index, size--);
    swim(index);
    sink(index);
    keys[i] = null;
    qp[i] = -1;
}
```

Thao tác xóa phần tử ưu tiên nhất cũng tương tự thao tác xóa ở trên, nhưng vị trí tráo là đầu mảng nên ta chỉ cần hiệu chỉnh theo chiến lược Top-down.

```java
@Override
int removePeek() {
    if (size == 0)
        throw new NoSuchElementException("Priority queue underflow");
    int peek = pq[0];
    swap(0, size);
    this.size--;
    sink(0);
    qp[peek] = -1;               
    keys[peek] = null;         
    pq[size + 1] = -1;     
    return peek;
}
```

# 3. Tổng quát hóa phép so sánh

Tương tự như với Priority Queue trong bài viết [Priority Queue và những cách cài đặt]({{< ref "/post/software/priority-queue" >}}), chúng ta có thể tổng quát hóa phép so sánh nhằm xử lý cả hai trường hợp Max Priority Queue và Min Priority Queue.

```java
private Comparator<T> comparator;

public IndexPQ(int maxSize, Comparator<T> comparator) {
    // ...omit

    this.comparator = comparator;
}
```

*Lưu ý*: Khi dùng với `Comparator` chúng ta cần sửa lại hàm `swim()` và `sink()` bằng cách thay thế phép so sánh bằng hàm so sánh của `comparator`.

# 4. Độ phức tạp

Dưới đây là độ phức tạp của các thao tác trong Index Priority Queue.

|Thao tác|Độ phức tạp|
|---|---|
|insert|$O(\\log{N})$|
|change|$O(\\log{N})$|
|contains|$O(1)$|
|delete|$O(\\log{N})$|
|peek|$O(1)$|
|peekIndex|$O(1)$|
|removePeek|$O(\\log{N})$|
|isEmpty|$O(1)$|
|size|$O(1)$|

# References

- [Algorithms, 4th Edition by Robert Sedgewick and Kevin Wayne](https://algs4.cs.princeton.edu/home/)


