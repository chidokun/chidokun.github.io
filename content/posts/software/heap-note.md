---
title: "Heap và một số ghi chú"
slug: "heap-note"
date: 2021-07-11T12:46:28+07:00
draft: false
categories:
- "Lập trình"
- "Cấu trúc dữ liệu"
tags:
- "java"
keywords:
- "heap"
- "java"
thumbnailImage: /thumbnails/heap.png
thumbnailImagePosition: left
---

*Heap* được ứng dụng khá nhiều trong các cấu trúc dữ liệu và giải thuật. Nếu bạn đã nghe qua Heap sort thì chắc chắn sẽ làm quen với khái niệm này. Ngoài ra, *Heap* cũng còn được ứng dụng trong Prority Queue - một cấu trúc dữ liệu hoạt động theo cơ chế vào trước ra trước. Bài viết này sẽ note một số ý chính về *Heap*.

<!--more-->

<!--toc-->

# 1. Giới thiệu

*Binary Heap* là một *cây nhị phân đầy đủ* mà mỗi nút gốc đều *lớn hơn* (hoặc *nhỏ hơn*) hai nút con của nó. *Heap* có nút gốc lớn hơn hai nút con còn gọi là *Max Heap* (ngược lại là *Min Heap*).

Ngoài ra cũng có thể dùng cây tam phân làm Heap thì lúc này nó sẽ được gọi là *Ternary Heap*. Bài viết này chủ yếu đề cập đến *Binary Heap* và sẽ gọi là *Heap* cho ngắn gọn.

*Heap* có thể được biểu diễn bằng một mảng một chiều và lúc này, nút gốc có chỉ số `i` sẽ có 2 nút con ở chỉ số `2i+1` và `2i+2` ($0 \\leq i \\leq \\frac{n}{2}-1$).

Ví dụ: Một heap được biểu diễn dưới dạng mảng một chiều.

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/heap-note/1.svg" title="Một heap được biểu diễn dưới dạng mảng một chiều và cây tương ứng">}}

# 2. Hiệu chỉnh Heap

*Hiệu chỉnh Heap* là quá trình điều chỉnh các phần tử để thỏa tính chất của *Heap*. Nếu một Heap được biểu diễn bằng mảng một chiều thì phần tử đầu tiên luôn là phần tử lớn nhất (Max Heap) hoặc nhỏ nhất (Min Heap).

## 2.1. Bottom-up

Chiến lược hiệu chỉnh Bottom-up được thực hiện khi nút đang xét có giá trị lớn hơn nút cha của nó. Lúc này chúng ta sẽ tráo nút hiện tại với nút cha. Lúc này nút cha của nút đang xét sẽ lớn hơn 2 nút con hiện tại. Tuy nhiên, nút cha này vẫn có thể lớn hơn nút ông nội của nó. Vì vậy chúng ta cần thực hiện xuyên suốt ngược lên trên.

Nút `i` sẽ có nút cha là `(i-1)/2` (nếu `i` bắt đầu từ `0`).

Các bước thực hiện:

- *1.* Ở nút `i` hiện tại, nếu nút hiện tại lớn hơn nút cha của nó (không thỏa Heap):
    - Tráo giá trị nút `i` và nút cha của nó.
- *2.* Di chuyển lên nút cha và lặp lại bước 1.
- *3.* Dừng lại khi đã đến nút gốc.

Cách cài đặt tham khảo sử dụng Java:

{{< tabbed-codeblock Heap>}}
    <!-- tab java -->
public void swim(int[] a, int i) {
    while (i > 0 && a[(i-1)/2] < a[i]) {
        swap(a, (i-1)/2, i);
        i = (i-1)/2;
    }
}

public void swap(int[] a, int i, int j) {
    int t = a[i];
    a[i] = a[j];
    a[j] = t;
}
    <!-- endtab -->
{{< /tabbed-codeblock >}}

Chiến lược này được ứng dụng trong trường hợp khi thêm một phần tử vào cuối mảng. Lúc này chúng ta xét phần tử cuối mảng và thực hiện hiệu chỉnh Heap ngược lên trên.

## 2.2. Top-down

Tương tự, chiến lược hiệu chỉnh Top-down được thực hiện khi nút đang xét có giá trị lớn hơn một hoặc cả hai nút con của nó. Lúc này chúng ta sẽ tráo nút hiện tại với nút lớn nhất trong 2 nút con. Tuy nhiên, nút con này vẫn có thể nhỏ hơn nút con của nó. Vì vậy chúng ta cần thực hiện xuyên suốt xuống dưới.

Các bước thực hiện:

- *1.* Ở nút `i` hiện tại, tìm nút có giá trị lớn nhất `l` trong 2 nút con của nút `i`.
- *2.* Nếu nút con `l` có giá trị lớn hơn nút cha `i` hiện tại (không thỏa Heap):
    - Tráo giá trị nút cha `i` và nút con `l`.
- *3.* Do đã tráo nút `l` nên nhánh `l` bị ảnh hưởng, ta di chuyển xuống nút `l` và lặp lại bước 1 và 2.
- *4.* Dừng lại khi đã hết nút con.

Cách cài đặt tham khảo sử dụng Java:

{{< tabbed-codeblock Heap>}}
    <!-- tab java -->
private void sink(int[] a, int n, int i) {
    while (2*i + 1 <= n-1) {
        // Find the largest element among children of `i`
        int largest = 2*i + 1;
        if (largest < n-1 && a[largest] < a[largest+1])
            largest++;

        // It's ok if root is larger than largest child
        if (a[i] >= a[largest])
            break;

        // Else swap parent and largest child
        swap(a, i, largest);

        // Heapify the affected subtree
        i = largest;
    }
}

public void sinkRecursively(int []a, int n, int i) {
    int largest = 2*i + 1;
    if (largest < n-1 && a[largest] < a[largest+1])
        largest++;
    if (largest >= n || a[i] >= a[largest])
        return;
    swap(a, i, largest);
    sinkRecursively(a, n, largest);
}
    <!-- endtab -->
{{< /tabbed-codeblock >}}

Chiến lược này được ứng dụng trong trường hợp khi loại bỏ phần tử ở đầu mảng (tức phần tử lớn nhất/nhỏ nhất). Lúc này chúng ta sẽ tráo với phần tử cuối mảng rồi thực hiện hiệu chỉnh Heap.


## References

- [Algorithms, 4th Edition by Robert Sedgewick and Kevin Wayne](https://algs4.cs.princeton.edu/home/)


