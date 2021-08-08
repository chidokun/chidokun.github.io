---
title: "Cài đặt thuật toán Huffman Coding"
slug: "huffman-coding-p2"
date: 2021-07-04T01:00:25+07:00
draft: false
categories:
- "Lập trình"
- "Cấu trúc dữ liệu và Giải thuật"
tags:
- "algorithms"
keywords:
- "java"
- "huffman coding"
- "huffman"
thumbnailImage: /thumbnails/huffman.png
thumbnailImagePosition: left
---

Với những ý tưởng của thuật toán Huffman Coding ở bài viết [Thuật toán nén Huffman Coding]({{< ref "/post/huffman-coding-p1" >}}), trong bài viết này chúng ta cùng bàn về cách hiện thực thuật toán này với ngôn ngữ Java.

<!--more-->

<!--toc-->

# 1. Định nghĩa API

Nhắc lại 3 bước của thuật toán Huffman Coding:

- **Bước 1**: Đếm tần suất xuất hiện của các phần tử trong chuỗi đầu vào.
- **Bước 2**: Xây dựng cây Huffman (cây nhị phân mã hóa).
- **Bước 3**: Mã hóa chuỗi đầu vào dựa vào cây Huffman.

Để cài đặt thuật toán này, trước hết ta định nghĩa các API phục vụ cho việc giao tiếp của chương trình như sau:

```java
   public class HuffmanCoding
-----------------------------------------------------
  HuffmanCoding process(String str)
         String encode()
         String decode(String encoded)
```

Lớp `HuffmanCoding` định nghĩa các method cơ bản nhất cho việc tính toán và mã hóa. 

- *process(String str)*: thực hiện tính toán và xây dựng cây Huffman dựa trên chuỗi đầu vào `str`.
- *encode()*: mã hóa chuỗi đầu vào thành chuỗi mã hóa.
- *decode(String encoded)*: giải mã chuỗi mã hóa dựa vào cây Huffman, sẽ được trình bày trong các bài viết kế tiếp.

Từ định nghĩa trên, chúng ta có thể viết được hàm `main` để test cho chương trình như sau:

```java
public static void main(String[] args) {
    String str = "Hellooo!";
    System.out.println("Source: " + str);

    HuffmanCoding h = new HuffmanCoding().process(str);
    String encoded = h.encode();
    System.out.println("Encoded: " + encoded);
}
```

Chúng ta sẽ lần lượt cài đặt các các method vừa định nghĩa theo từng bước của thuật toán ở phần tiếp theo.

Ngoài ra, cần có một cấu trúc dữ liệu để lưu trữ cây Huffman.

```java
   public class Node
-----------------------------------------------------
                Node(int data, char character)
                Node(int data, Node left, Node right)
            int getData()
           char getCharacter()
           Node getLeft()
           Node getRight()
        boolean isLeaf()
```

Mỗi nút trong cây Huffman gồm ký tự `character` và trọng số `data` là tần suất xuất hiện của ký tự đó. Cây Huffman là cây nhị phân nên mỗi nút sẽ có nút con trái `left` và nút con phải `right`.

Cách cài đặt tham khảo cho `Node`.

{{< tabbed-codeblock Node>}}
    <!-- tab java -->
public class Node {
    private int data;
    private char character;
    private Node left;
    private Node right;

    public Node(int data, char character) {
        this.data = data;
        this.character = character;
        this.left = null;
        this.right = null;
    }

    public Node(int data, Node left, Node right) {
        this.data = data;
        this.character = '\0';
        this.left = left;
        this.right = right;
    }

    public int getData() { return data; }
    public char getCharacter() { return character; }
    public Node getLeft() { return left; }
    public Node getRight() { return right; }

    public boolean isLeaf() {
        return left == null && right == null && character != '\0';
    }
}
    <!-- endtab -->
{{< /tabbed-codeblock >}}


# 2. Cài đặt từng bước

Ở *Bước 1*, ta cần đếm tần suất xuất hiện các ký tự của chuỗi đầu vào. Dùng một `Map<Character, Integer>` để lưu trữ kết quả và cài đặt thành method private bên trong `HuffmanCoding`.

```java
private Map<Character, Integer> freqMap;

private void countFreq(String str) {
    this.freqMap = new HashMap<>();
    for (char c : str.toCharArray()) {
        int rs = this.freqMap.getOrDefault(c, 0);
        this.freqMap.put(c, rs + 1);
    }
}
```

Tiếp tục *Bước 2*, xây dựng cây Huffman, nhắc lại các bước xây dựng cây Huffman:

- *2.1*. Tạo danh sách chứa các nút lá bao gồm phần tử đầu vào và trọng số nút là tần suất xuất hiện của nó.
- *2.2*. Từ danh sách này, lấy ra 2 phần tử có tần suất xuất hiện ít nhất. Sau đó gắn 2 nút vừa lấy ra vào một nút gốc mới với trọng số là tổng của 2 trọng số ở nút vừa lấy ra để tạo thành một cây.
- *2.3*. Đẩy cây mới vào lại danh sách.
- *2.4*. Lặp lại bước 2 và 3 cho đến khi danh sách chỉ còn 1 nút gốc duy nhất của cây.
- *2.5*. Nút còn lại chính là nút gốc của cây Huffman.

Để xây dựng danh sách này chúng ta sẽ dùng `PriorityQueue` có sẵn của Java. `PriorityQueue` là một cấu trúc dữ liệu hoạt động theo cơ chế FIFO (First In First Out) theo trọng số priority. Ở đây, trọng số priority sẽ là trọng số của nút. 

```java
private Node buildTree(Map<Character, Integer> freqMap) {
    PriorityQueue<Node> q = new PriorityQueue<>(freqMap.size(), Comparator.comparingInt(Node::getData));
    for (Map.Entry<Character, Integer> i : freqMap.entrySet())
        q.add(new Node(i.getValue(), i.getKey()));

    Node root = null;
    while (q.size() > 1) {
        Node x = q.poll();
        Node y = q.poll();
        root = new Node(x.getData() + y.getData(), x, y);
        q.add(root);
    }
    return root;
}
```

Từ cây Huffman, ta có thể tạo ra một Map<Character, String> để lưu trữ giá trị mã hóa của từng ký tự. Chúng ta duyệt đệ quy đến nút lá, duyệt về bên trái sẽ thêm giá trị `0`, duyệt về phải sẽ thêm giá trị `1`. 

```java
private Map<Character, String> codeMap;

private void buildCode(Node node, String code) {
    if (node.isLeaf()) {
        codeMap.put(node.getCharacter(), code);
        return;
    }
    buildCode(node.getLeft(), code + "0");
    buildCode(node.getRight(), code + "1");
}
```

Sau khi đã có đủ các điều kiện liên quan, chúng ta sẽ cài đặt phương thức `process(String str)` của `HuffmanCoding`.

```java
private Node root = null;
private String str;

public HuffmanCoding process(String str) {
    this.str = str;
    countFreq(str);
    this.root = buildTree(freqMap);
    this.codeMap = new HashMap<>();
    buildCode(root, "");
    return this;
}
```

Sau khi đã có bảng Map của ký tự và giá trị mã hóa, ta dễ dàng cài đặt phương thức `encode()` để mã hóa chuỗi ban đầu bằng cách thay thế mỗi ký tự ban đầu thành giá trị mã hóa.

```java
public String encode() {
    if (this.codeMap == null || this.codeMap.isEmpty()) {
        return null;
    }
    StringBuilder builder = new StringBuilder();
    for (char c : str.toCharArray()) {
        builder.append(codeMap.get(c));
    }
    return builder.toString();
}
```

Sau khi đã cài đặt xong phương thức `encode()` là đã có thể test được hàm `main` phía trên rồi.

Kết quả:

```
Source: Hellooo!
Encoded: 110111110100001110
```

Source code của `HuffmanCoding`.

{{< tabbed-codeblock HuffmanCoding>}}
    <!-- tab java -->
public class HuffmanCoding {

    private Node root = null;
    private Map<Character, Integer> freqMap;
    private Map<Character, String> codeMap;
    private String str;

    public HuffmanCoding process(String str) {
        this.str = str;
        countFreq(str);
        this.root = buildTree(freqMap);
        this.codeMap = new HashMap<>();
        buildCode(root, "");
        return this;
    }

    public String encode() {
        if (this.codeMap == null || this.codeMap.isEmpty()) {
            return null;
        }
        StringBuilder builder = new StringBuilder();
        for (char c : str.toCharArray()) {
            builder.append(codeMap.get(c));
        }
        return builder.toString();
    }

    private Node buildTree(Map<Character, Integer> freqMap) {
        PriorityQueue<Node> q = new PriorityQueue<>(freqMap.size(), Comparator.comparingInt(Node::getData));
        for (Map.Entry<Character, Integer> i : freqMap.entrySet())
            q.add(new Node(i.getValue(), i.getKey()));

        Node root = null;
        while (q.size() > 1) {
            Node x = q.poll();
            Node y = q.poll();
            root = new Node(x.getData() + y.getData(), x, y);
            q.add(root);
        }
        return root;
    }

    private void buildCode(Node node, String code) {
        if (node.isLeaf()) {
            codeMap.put(node.getCharacter(), code);
            return;
        }
        buildCode(node.getLeft(), code + "0");
        buildCode(node.getRight(), code + "1");
    }

    private void countFreq(String str) {
        this.freqMap = new HashMap<>();
        for (char c : str.toCharArray()) {
            int rs = this.freqMap.getOrDefault(c, 0);
            this.freqMap.put(c, rs + 1);
        }
    }
}
    <!-- endtab -->
{{< /tabbed-codeblock >}}

Vẫn còn một phần giải nén nữa và sẽ được giới thiệu ở bài viết [Huffman Decoding: Quá trình giải nén]({{< ref "/post/huffman-coding-p3" >}})

## References

- [Huffman Encoding and Data Compression](https://web.stanford.edu/class/archive/cs/cs106x/cs106x.1192/resources/minibrowser2/huffman-encoding-supplement.pdf)


