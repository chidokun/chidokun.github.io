---
title: "Thuật toán Prim: Tìm cây khung nhỏ nhất"
slug: "prim-algorithm"
date: 2021-07-22T22:00:25+07:00
draft: false
categories:
- "Lập trình"
- "Giải thuật"
tags:
- "prim"
- "graph"
keywords:
- "graph"
- "java"
- "prim"
- "spanning tree"
- "cây khung"
thumbnailImage: /thumbnails/graph.png
thumbnailImagePosition: left
---

Hôm nay mình xin chia sẻ một số ghi chú về *Thuật toán Prim* dùng để giải bài toán tìm cây khung nhỏ nhất (**Minimum Spanning Tree**) cho đồ thị vô hướng có trọng số. Prim cũng là một trong những thuật toán cổ điển để giải bài toán này.


<!--more-->

<!--toc-->

# 1. Ý tưởng

*Cây khung* (spanning tree) của một đồ thị là một đồ thị con liên thông không có chu trình đi qua tất cả các đỉnh. Một đồ thị sẽ có nhiều cây khung và bài toán của chúng ta là phải tìm ra cây khung nhỏ nhất.

Ý tưởng cơ bản của thuật toán Prim như sau:

- <u>*Bước 1*</u>: Chọn một đỉnh `v` bất kỳ làm đỉnh bắt đầu và đưa đỉnh `v` vào cây khung.
- <u>*Bước 2*</u>: Thêm tất cả các cạnh nối với `v` vào danh sách cạnh đang xét .
- <u>*Bước 3*</u>: Xét các cạnh trong danh sách đến khi hết:
    - <u>*Bước 3.1*</u>: Lấy ra cạnh có trọng số nhỏ nhất nối từ `v1` đến một đỉnh `v2` chưa nằm trong cây khung. Đưa cạnh này và đỉnh `v2` vào cây khung.
    - <u>*Bước 3.2*</u>: Đưa các cạnh nối từ đỉnh `v2` đến các đỉnh chưa nằm trong cây khung vào danh sách cạnh đang xét.

# 2. Ví dụ

Để giải thích rõ hơn các bước thực hiện của thuật toán, mình xin chạy thuật toán với đồ thị $G$ bên dưới:

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/prim-algorithm/1.svg" title="Đồ thị $G$">}}

Chọn đỉnh $0$ làm đỉnh bắt đầu, đưa đỉnh này vào cây khung (màu xanh). Đưa các cạnh 0-1, 0-2, 0-3 vào danh sách cạnh đang xét (màu cam). Ta thấy cạnh 0-2 là cạnh có trọng số nhỏ nhất.

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/prim-algorithm/2.svg" >}}

Đưa cạnh 0-2 và đỉnh $2$ vào cây khung. Đưa các cạnh 2-4 và 2-5 vào danh sách đang xét. Lúc này ta thấy cạnh 2-4 có trọng số nhỏ nhất.

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/prim-algorithm/3.svg">}}

Đưa cạnh 2-4 và đỉnh $4$ vào cây khung. Đưa các cạnh 4-1 và 4-6 vào danh sách đang xét. Lúc này ta thấy cạnh 4-1 có trọng số nhỏ nhất.

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/prim-algorithm/4.svg">}}

Đưa cạnh 4-1 và đỉnh $1$ vào cây khung. Các đỉnh nối từ $1$ là $0$ và $4$ đều đã nằm trong cây khung nên chúng ta sẽ không đưa các cạnh nối các đỉnh này vào danh sách đang xét. Lúc này, ta xét các cạnh còn lại và thấy cạnh 2-5 có trọng số nhỏ nhất.

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/prim-algorithm/5.svg">}}

Đưa cạnh 2-5 và đỉnh $5$ vào cây khung. Tiếp tục đưa ba cạnh 5-3, 5-6 và 5-7 vào danh sách đang xét. Cạnh 5-6 lúc này có trọng số nhỏ nhất.

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/prim-algorithm/6.svg">}}

Đưa cạnh 5-6 và đỉnh $6$ vào cây khung. Tiếp tục đưa cạnh 6-7 và 6-8 vào danh sách đang xét, không đưa cạnh 6-4 vì đỉnh $4$ đã nằm trong cây khung. Cạnh 6-8 lúc này có trọng số nhỏ nhất.

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/prim-algorithm/7.svg">}}

Đưa cạnh 6-8 và đỉnh $8$ vào cây khung. Đưa cạnh 8-7 vào danh sách đang xét. Lúc này danh sách có cạnh 6-7 có trọng số nhỏ nhất.

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/prim-algorithm/8.svg">}}

Đưa cạnh 6-7 và đỉnh $7$ vào cây khung. Không có cạnh nào được đưa tiếp vào danh sách đang xét vì các đỉnh kề của $7$ đều đã nằm trong cây khung. Lúc này cạnh 5-7 và 8-7 đều có trọng số nhỏ nhất. Tuy nhiên, cả 3 đỉnh $5$, $7$, $8$ đều đã nằm trong cây khung nên sẽ bị loại bỏ. Vậy cạnh 0-3 là cạnh có trọng số nhỏ nhất.

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/prim-algorithm/9.svg">}}

Các cạnh còn lại được lấy ra nhưng các đỉnh đều đã nằm trong cây khung nên sẽ bị loại bỏ.

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/prim-algorithm/10.svg">}}

Thuật toán kết thúc và chúng ta tìm được cây khung có trọng số nhỏ nhất.

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/prim-algorithm/11.svg" >}}

# 3. Kết luận

Trên đây mình đã trình bày cụ thể thuật toán Prim và các bước thực hiện thông qua ví dụ. Vì bài viết đã khá dài nên mình sẽ trình bày cách cài đặt thuật toán này trong bài viết sau.

## References

- [Algorithms, 4th Edition by Robert Sedgewick and Kevin Wayne](https://algs4.cs.princeton.edu/home/)


