---
title: "Thuật toán Kruskal: Tìm cây khung nhỏ nhất"
slug: "kruskal-algorithm"
date: 2021-08-22T22:06:25+07:00
draft: false
categories:
- "Lập trình"
- "Giải thuật"
tags:
- "kruskal"
- "graph"
keywords:
- "graph"
- "java"
- "kruskal"
- "spanning tree"
- "cây khung"
thumbnailImage: /thumbnails/graph.png
thumbnailImagePosition: left
---

Ngoài [thuật toán Prim]({{< ref "/posts/software/prim-algorithm-implement" >}}), *Thuật toán Kruskal* cũng là thuật toán cổ điển để giải bài toán tìm cây khung nhỏ nhất (**Minimum Spanning Tree**) cho đồ thị vô hướng có trọng số. Trong bài viết này chúng ta cùng xem ý tưởng cơ bản của *Thuật toán Kruskal*.


<!--more-->

{{< toc >}}

# 1. Ý tưởng

*Cây khung* (spanning tree) của một đồ thị là một đồ thị con liên thông không có chu trình đi qua tất cả các đỉnh. Một đồ thị sẽ có nhiều cây khung và bài toán của chúng ta là phải tìm ra cây khung nhỏ nhất.

Ý tưởng của *Thuật toán Kruskal* khá đơn giản: Sắp xếp các cạnh từ bé đến lớn theo trọng số. Lần lượt chọn các cạnh theo thứ tự từ bé đến lớn trong danh sách sao cho không tạo thành chu trình. Thuật toán sẽ dừng lại khi đã có đủ $V-1$ cạnh trong cây khung (với $V$ là số lượng đỉnh của đồ thị).

# 2. Ví dụ

Để minh họa cho thuật toán, mình sẽ dùng đồ thị $G$ và đi từng bước của thuật toán:

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/prim-algorithm/1.svg" title="Đồ thị $G$">}}

Trong danh sách các cạnh của $G$, ta lấy ra cạnh 2-4 nhỏ nhất.

{{< image classes="fancybox center" thumbnail-width="100%" src="/images/post/software/kruskal-algorithm/1.svg" >}}

Cạnh này không tạo chu trình nên có thể đưa vào cây khung và xét cạnh 1-4.

{{< image classes="fancybox center" thumbnail-width="100%" src="/images/post/software/kruskal-algorithm/2.svg" >}}

Đưa 1-4 vào cây khung, xét cạnh 2-5.

{{< image classes="fancybox center" thumbnail-width="100%" src="/images/post/software/kruskal-algorithm/3.svg" >}}

Đưa 2-5 vào cây khung, xét cạnh 6-8.

{{< image classes="fancybox center" thumbnail-width="100%" src="/images/post/software/kruskal-algorithm/4.svg" >}}

Đưa 6-8 vào cây khung, xét cạnh 6-7.

{{< image classes="fancybox center" thumbnail-width="100%" src="/images/post/software/kruskal-algorithm/5.svg" >}}

Đưa 6-7 vào cây khung, xét cạnh 5-6.

{{< image classes="fancybox center" thumbnail-width="100%" src="/images/post/software/kruskal-algorithm/6.svg" >}}

Đưa 5-6 vào cây khung, xét cạnh 0-2.

{{< image classes="fancybox center" thumbnail-width="100%" src="/images/post/software/kruskal-algorithm/7.svg" >}}

Đưa 0-2 vào cây khung, xét cạnh 5-7. Cạnh 5-7 tạo thành chu trình, vì vậy không được đưa vào cây khung. Ta xét tiếp cạnh 7-8, cũng không được đưa vào cây khung do tạo thành chu trình. Xét cạnh 0-3.

{{< image classes="fancybox center" thumbnail-width="100%" src="/images/post/software/kruskal-algorithm/8.svg" >}}

Đưa 0-3 vào cây khung. Thuật toán kết thúc vì đã đủ $V-1$ cạnh.

{{< image classes="fancybox center" thumbnail-width="100%" src="/images/post/software/kruskal-algorithm/9.svg" >}}


## References

- [Algorithms, 4th Edition by Robert Sedgewick and Kevin Wayne](https://algs4.cs.princeton.edu/home/)


