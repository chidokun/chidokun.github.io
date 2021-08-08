---
title: "Huffman Decoding: Quá trình giải nén"
slug: "huffman-coding-p3"
date: 2021-07-04T17:45:23+07:00
draft: false
categories:
- programming
tags:
- "algorithms"
keywords:
- "java"
- "huffman coding"
- "huffman"
thumbnailImage: /thumbnails/huffman.png
thumbnailImagePosition: left
---

Ở bài viết [Cài đặt thuật toán Huffman Coding]({{< ref "/post/huffman-coding-p2" >}}), chúng ta đã tìm hiểu cách cài đặt thuật toán Huffman Coding để mã hóa (nén) chuỗi dữ liệu thành chuỗi nhị phân. Trong bài viết này, chúng ta sẽ tiếp tục tìm hiểu quá trình giải nén dữ liệu từ cây Huffman và cài đặt phương thức `decode(String encoded)` cho class `HuffmanCoding`.

<!--more-->

<!--toc-->

# 1. Thuật toán giải mã

Để giải mã chuỗi nhị phân đã mã hóa, chúng ta cần có cây Huffman (cây nhị phân mã hóa chứa giá trị mã hóa của từng ký tự). Sau đó, duyệt tuần tự qua chuỗi bit mã hóa theo các bước sau:

- *1.1*. Duyệt qua từng bit của chuỗi bit mã hóa từ nút gốc đến khi gặp nút lá.
- *1.2*. Nếu bit hiện tại là bit 0, chuyển qua nhánh trái.
- *1.3*. Nếu bit hiện tại là bit 1, chuyển qua nhánh phải.
- *1.4*. Khi gặp nút lá, ta thêm ký tự ở nút lá vào chuỗi kết quả. Sau đó trở lại nút gốc cho bit tiếp theo.


# 2. Cài đặt thuật toán

Trở lại với class `HuffmanCoding` trong bài viết [Cài đặt thuật toán Huffman Coding]({{< ref "/post/huffman-coding-p2" >}}), chúng ta sẽ cài đặt phương thức `decode(String encoded)` của class này.

Thuật toán có thể được cài đặt như sau:

```java
public String decode(String encoded) {
    Node node = this.root;
    StringBuilder result = new StringBuilder();
    for (char c : encoded.toCharArray()) {
        node = c == '0' ? node.getLeft() : node.getRight();
        if (node.isLeaf()) {
            result.append(node.getCharacter());
            node = root;
        }
    }
    return result.toString();
}
```

Test lại với hàm `main`:

```java
public static void main(String[] args) {
    String str = "Hellooo!";
    System.out.println("Source: " + str);

    HuffmanCoding h = new HuffmanCoding().process(str);
    String encoded = h.encode();
    System.out.println("Encoded: " + encoded);
    System.out.println("Decoded: " + h.decode(encoded));
}
```

Kết quả là:

```
Source: Hellooo!
Encoded: 110111110100001110
Decoded: Hellooo!
```

## References

- [Huffman Encoding and Data Compression](https://web.stanford.edu/class/archive/cs/cs106x/cs106x.1192/resources/minibrowser2/huffman-encoding-supplement.pdf)
- [Huffman Decoding](https://www.geeksforgeeks.org/huffman-decoding/)


