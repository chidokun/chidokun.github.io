---
title: "Cách vẽ lại cây nhị phân tìm kiếm từ kết quả duyệt"
slug: "binary-tree-from-traversal"
date: 2015-06-13T14:01:00+07:00
draft: false
categories:
- "Lập trình"
- "Cấu trúc dữ liệu"
tags:
- "tree"
keywords:
- "binary tree"
- "cây nhị phân"
- "kết quả duyệt"
thumbnailImage: /thumbnails/heap.png
thumbnailImagePosition: left
---

Thường có 3 cách duyệt cơ bản là tiền thứ tự (NLR), trung thứ tự (LNR) và hậu thứ tự (LRN). Với kết quả duyệt kiểu NLR và LRN ta có thể vẽ lại cây ban đầu dễ dàng. Còn với LNR, ta không tìm được Node gốc nên không thể vẽ lại cây.

<!--more-->

# Nguyên tắc chung để vẽ lại cây

1. Tìm Node gốc.
2. Tìm đoạn lớn hơn Node gốc sẽ là nhánh phải, đoạn nhỏ hơn Node gốc sẽ là nhánh trái. *(Vì nguyên tắc của cây nhị phân tìm kiếm, Node gốc sẽ có khóa lớn hơn tất cả Node con nhánh bên trái và nhỏ hơn tất cả các Node ở nhánh phải)*
3. Với mỗi đoạn vừa tìm được, tìm Node gốc của từng đoạn và tiếp tục tìm đoạn lớn hơn và nhỏ hơn Node gốc.

Đó là nguyên tắc chung để vẽ lại cây. **{{< hl-text orange >}}Với cách duyệt NLR, ta luôn có Node gốc là Node đầu tiên của dãy kết quả, còn cách duyệt LRN là Node cuối cùng.{{< /hl-text >}}**

*<u>Ví dụ</u>*: Cho kết quả duyệt {{< hl-text primary >}}L{{< /hl-text >}}{{< hl-text green >}}R{{< /hl-text >}}{{< hl-text red >}}N{{< /hl-text >}}: {{< hl-text primary >}}5 3 7 9 8 11 6 {{< /hl-text >}}{{< hl-text green >}}20 19 37 25 21 15 {{< /hl-text >}}{{< hl-text red >}}12{{< /hl-text >}}

Nhìn vào kết quả duyệt ta dễ dàng thấy {{< hl-text red >}}12{{< /hl-text >}} sẽ là Node gốc. Đoạn 5 đến 6 sẽ là nhánh trái và 20 đến 15 sẽ là nhánh phải.

{{< image classes="fancybox center" thumbnail-width="100%" src="/images/post/software/binary-tree-from-traversal/1.png" >}}

Tiếp tục xét đoạn trái, ta thấy số 6 sẽ là Node gốc tiếp theo, tìm đoạn nhỏ hơn số 6 là [5,3] sẽ là nhánh trái, đoạn [7,11] sẽ là nhánh phải.

Cứ tiếp tục xét như thế đến hết ta sẽ vẽ được nhánh trái của cây.

{{< image classes="fancybox center" thumbnail-width="60%" src="/images/post/software/binary-tree-from-traversal/2.png" >}}

Giờ ta xét nhánh phải với nguyên tắc tương tự. 15 sẽ là Node gốc tiếp theo, vì không có số nào nhỏ hơn 15 ở đoạn phải nên những số còn lại hoàn toàn nằm ở nhánh phải của 15. Xét tiếp đoạn đó tương tự ta sẽ vẽ được nhánh phải.

{{< image classes="fancybox center" thumbnail-width="100%" src="/images/post/software/binary-tree-from-traversal/3.png" >}}

Các bạn hãy thử sức với các bài tập sau nhé!

*Vẽ lại cây nhị phân tìm kiếm từ kết quả duyệt*:

**NLR**: {{< hl-text primary >}}7 6 4 15 13 9 14 30 31{{< /hl-text >}}