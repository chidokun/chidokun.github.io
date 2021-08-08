---
title: "Thuật toán nén Huffman Coding"
slug: "huffman-coding-p1"
date: 2021-07-02T22:33:25+07:00
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

Nén dữ liệu là phương pháp loại bỏ những thông tin dư thừa trong việc biểu diễn dữ liệu. Nó có nhiều ứng dụng, đặc biệt là trong việc truyền tin vì giúp rút gọn thông tin gửi đi. Có nhiều thuật toán nén dữ liệu và *Huffman Coding* là một trong số đó. Bài viết này chủ yếu bàn về ý tưởng của thuật toán này.

<!--more-->

<!--toc-->

# 1. Nén dữ liệu

Hãy xem câu "*Hello*" được biểu diễn dưới dạng mã ASCII như thế nào nhé:

{{< image classes="fancybox center" thumbnail-width="100%" src="/images/post/huffman-coding-p1/1.svg" title="Câu \"Hello\" được biểu diễn dưới dạng mã ASCII">}}

Mỗi ký tự sử dụng 8 bit để biểu diễn nên tổng cộng sẽ dùng 64 bit.

*Bảng mã ASCII mở rộng* dùng 8 bit để biểu diễn 256 ký tự khác nhau. Trong khi đó thông điệp của chúng ta chỉ gồm 5 ký tự khác nhau, như vậy thực tế chỉ cần dùng 3 bit là đủ để phân biệt được 5 ký tự này.

Bây giờ ta sẽ liệt kê 5 ký tự phân biệt và gán cho nó một mã nhị phân 3 bit phân biệt. Lúc này ta vẫn có thể biểu diễn trọn vẹn thông điệp đã nén và dùng bảng giải mã này để khôi phục thông điệp ban đầu.

{{< image classes="fancybox center" thumbnail-width="100%" src="/images/post/huffman-coding-p1/2.svg" title="Thông điệp đã nén bằng 3-bit coding">}}

Như vậy, chỉ cần dùng $3 \\times 8 = 24$ bit để biểu diễn thông điệp trên. Mỗi ký tự đều dùng đúng một số lượng bit để biểu diễn, chúng ta gọi cách này là **<i>fixed-length encoding</i>**. Bảng các giá trị được mã hóa cũng là **<i>prefix code</i>**.

**Prefix code** có thể được định nghĩa khó hiểu như sau (theo *Wikipedia*):

> A prefix code is a type of code system distinguished by its possession of the "prefix property", which requires that there is no whole code word in the system that is a prefix (initial segment) of any other code word in the system. It is trivially true for fixed-length code, so only a point of consideration in variable-length code.

Chúng ta hiểu đơn giản như sau: *Prefix code là một tập các giá trị mã hóa mà không có phần tử nào được bắt đầu bằng một phần tử khác.*

Với *fix-length encoding* dùng cùng một số lượng bit để mã hóa, các giá trị mã hóa đều khác nhau. Do đó, nó là *prefix-code*. Tuy vậy, các giá trị mã hóa với số lượng bit khác nhau (**<i>variable-length encoding</i>**) cũng là *prefix code* nếu thỏa mãn tính chất trên.

Ví dụ: Tập A = { 0, 10, 110, 111 } là một *prefix code* vì không có phần tử nào bắt đầu bằng phần tử khác. Nhưng B = { 0, {{< hl-text green >}}10{{< /hl-text >}}, 110, {{< hl-text blue >}}101{{< /hl-text >}} } không phải *prefix code* vì có phần tử {{< hl-text blue >}}101{{< /hl-text >}} bắt đầu bằng phần tử {{< hl-text green >}}10{{< /hl-text >}}.

*Prefix code* có thể được biểu diễn thành cây nhị phân mã hóa. Mỗi ký tự cần mã hóa sẽ nằm ở nút lá. Giá trị mã hóa của ký tự đó thể hiện bằng đường đi từ nút gốc đến nút lá chứa ký tự đó. Nhánh bên trái thể hiện giá trị 0, nhánh bên phải thể hiện giá trị 1. 

Ví dụ cho chữ "*Hellooo!*" được mã hóa bằng 3-bit encoding:

{{< image classes="fancybox center" thumbnail-width="60%" src="/images/post/huffman-coding-p1/3.svg" title="Cây nhị phân mã hóa 3-bit encoding">}}

Ta lại nhận thấy rằng, có những phần tử xuất hiện rất nhiều lần, nếu gắn cho chúng một mã có độ dài thấp nhất, còn các phần tử xuất ít hơn có thể có mã dài hơn, thì vẫn có thể tiết kiệm được hơn nữa.

Giả sử ta chọn một *prefix code* như ví dụ bên dưới:

{{< image classes="fancybox center" thumbnail-width="100%" src="/images/post/huffman-coding-p1/4.svg" title="Câu \"Hello\" được biểu diễn dưới dạng mã ASCII">}}

Rõ ràng chỉ cần dùng 18 bit để biểu diễn thông điệp trên. Cách gán mã dựa trên tần suất xuất hiện cũng chính là ý tưởng của thuật toán Huffman coding.

{{< image classes="fancybox center" thumbnail-width="60%" src="/images/post/huffman-coding-p1/5.svg" title="Cây nhị phân mã hóa variable-length encoding">}}


# 2. Thuật toán Huffman Coding

Với ý tưởng trên, thuật toán Huffman coding gồm 3 bước:

- **Bước 1**: Đếm tần suất xuất hiện của các phần tử trong chuỗi đầu vào.
- **Bước 2**: Xây dựng cây Huffman (cây nhị phân mã hóa).
- **Bước 3**: Từ cây Huffman, ta có được các giá trị mã hóa. Lúc này, ta có thể xây dựng chuỗi mã hóa từ các giá trị này.

Quá trình xây dựng cây Huffman gồm các bước sau:

- *2.1*. Tạo danh sách chứa các nút lá bao gồm phần tử đầu vào và trọng số nút là tần suất xuất hiện của nó.
- *2.2*. Từ danh sách này, lấy ra 2 phần tử có tần suất xuất hiện ít nhất. Sau đó gắn 2 nút vừa lấy ra vào một nút gốc mới với trọng số là tổng của 2 trọng số ở nút vừa lấy ra để tạo thành một cây.
- *2.3*. Đẩy cây mới vào lại danh sách.
- *2.4*. Lặp lại bước 2 và 3 cho đến khi danh sách chỉ còn 1 nút gốc duy nhất của cây.
- *2.5*. Nút còn lại chính là nút gốc của cây Huffman.

Để dễ tiếp cận các bước thực hiện xây dựng cây Huffman, chúng ta sẽ dùng lại ví dụ ở phần trước.

**Bước 2.1**: Sau khi đếm tần suất xuất hiện các phần tử đầu vào. Chúng ta tạo danh sách các nút lá với trọng số là tần suất xuất hiện. Danh sách sẽ có 5 phần tử như bên dưới.

{{< image classes="fancybox center" thumbnail-width="60%" src="/images/post/huffman-coding-p1/6.svg" title="Danh sách ban đầu">}}

**Bước 2.2 và 2.3**: Chọn 2 nút có trọng số thấp nhất, tạo nút gốc mới có trọng số bằng tổng 2 trọng số nút con. Sau đó gắn 2 nút con vào nút gốc và đẩy lại vào danh sách. Danh sách cần được biểu diễn đặc biệt để có thể lấy ra các nút trọng số nhỏ nhất một cách tối ưu nhất.

{{< image classes="fancybox center" thumbnail-width="50%" src="/images/post/huffman-coding-p1/7.svg" title="Lần 1">}}

**Bước 2.4**: Lặp lại các bước 2.2 và 2.3.

{{< image classes="fancybox center" thumbnail-width="40%" src="/images/post/huffman-coding-p1/8.svg" title="Lần 2">}}

**Bước 2.4**: Lặp lại các bước 2.2 và 2.3.

{{< image classes="fancybox center" thumbnail-width="40%" src="/images/post/huffman-coding-p1/9.svg" title="Lần 3">}}

**Bước 2.5**: Chỉ còn lại 1 nút trong danh sách, nút này chính là cây Huffman

{{< image classes="fancybox center" thumbnail-width="40%" src="/images/post/huffman-coding-p1/10.svg" title="Cây còn lại trong danh sách">}}

Từ cây Huffman, ta có thể suy ra các giá trị mã hóa của từng phần tử bằng cách duyệt cây nhị phân mã hóa.

{{< image classes="fancybox center" thumbnail-width="60%" src="/images/post/huffman-coding-p1/5.svg" title="Cây nhị phân mã hóa">}}

Ở những bài viết [tiếp theo]({{< ref "/post/huffman-coding-p2" >}}), chúng ta sẽ cùng bàn về cách hiện thực ý tưởng này bằng ngôn ngữ lập trình Java.

## References

- [Huffman Encoding and Data Compression](https://web.stanford.edu/class/archive/cs/cs106x/cs106x.1192/resources/minibrowser2/huffman-encoding-supplement.pdf)
- [Prefix code](https://en.wikipedia.org/wiki/Prefix_code)


