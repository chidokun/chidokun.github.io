---
title: "Ghi chú một số thao tác trên Cây nhị phân"
slug: "prim-algorithm-implement"
date: 2021-07-22T20:04:25+07:00
draft: true
categories:
- "Lập trình"
- "Cấu trúc dữ liệu và Giải thuật"
tags:
- "algorithms"
keywords:
- "graph"
- "java"
- "prim"
- "spanning tree"
- "cây khung"
thumbnailImage: /thumbnails/graph.png
thumbnailImagePosition: left
---

Hôm nay sẽ là một số ghi chú về thuật toán Prim dùng để giải bài toán tìm cây khung nhỏ nhất (Minimum Spanning Tree) cho đồ thị vô hướng có trọng số. 

<!--more-->

{{< toc >}}

# 1. Ý tưởng

*Cây khung* (spanning tree) của một đồ thị là một đồ thị con liên thông không có chu trình đi qua tất cả các đỉnh. Một đồ thị sẽ có nhiều cây khung và bài toán của chúng ta là phải tìm ra cây khung nhỏ nhất.

Ý tưởng cơ bản của thuật toán Prim như sau:

- Bắt đầu từ một đỉnh bất kỳ


# 2. Ví dụ

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/prim-algorithm/1.svg" title="Ví dụ về việc xóa phần tử 15, tráo với phần tử cuối sau đó hiệu chỉnh theo chiến lược Top-down">}}

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/prim-algorithm/2.svg" title="Ví dụ về việc xóa phần tử 15, tráo với phần tử cuối sau đó hiệu chỉnh theo chiến lược Top-down">}}

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/prim-algorithm/3.svg" title="Ví dụ về việc xóa phần tử 15, tráo với phần tử cuối sau đó hiệu chỉnh theo chiến lược Top-down">}}

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/prim-algorithm/4.svg" title="Ví dụ về việc xóa phần tử 15, tráo với phần tử cuối sau đó hiệu chỉnh theo chiến lược Top-down">}}

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/prim-algorithm/5.svg" title="Ví dụ về việc xóa phần tử 15, tráo với phần tử cuối sau đó hiệu chỉnh theo chiến lược Top-down">}}

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/prim-algorithm/6.svg" title="Ví dụ về việc xóa phần tử 15, tráo với phần tử cuối sau đó hiệu chỉnh theo chiến lược Top-down">}}

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/prim-algorithm/7.svg" title="Ví dụ về việc xóa phần tử 15, tráo với phần tử cuối sau đó hiệu chỉnh theo chiến lược Top-down">}}

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/prim-algorithm/8.svg" title="Ví dụ về việc xóa phần tử 15, tráo với phần tử cuối sau đó hiệu chỉnh theo chiến lược Top-down">}}

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/prim-algorithm/9.svg" title="Ví dụ về việc xóa phần tử 15, tráo với phần tử cuối sau đó hiệu chỉnh theo chiến lược Top-down">}}

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/prim-algorithm/10.svg" title="Ví dụ về việc xóa phần tử 15, tráo với phần tử cuối sau đó hiệu chỉnh theo chiến lược Top-down">}}

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/prim-algorithm/11.svg" title="Ví dụ về việc xóa phần tử 15, tráo với phần tử cuối sau đó hiệu chỉnh theo chiến lược Top-down">}}

# 2. Hiện thực

Để hiện thực thuật toán Prim, chúng ta có thể sử dụng cấu trúc `EdgeWeightedGraph` để lưu trữ đồ thị vô hướng có trọng số mà mình có giới thiệu qua ở bài viết [Tổng quan về đồ thị]({{< ref "/posts/graph-overview" >}}). Chúng ta định nghĩa các phương thức như sau:






Code tham khảo:

{{< tabbed-codeblock BreathFirstSearch>}}
    <!-- tab java -->
public class BreathFirstSearch {
    private boolean[] marked;
    public BreathFirstSearch(Graph g, int s) {
        marked = new boolean[g.V()];
        bfs(g, s);
    }
    private void bfs(Graph g, int s) {
        LinkedList<Integer> queue = new LinkedList<>();
        marked[s] = true;
        queue.add(s);
        while (!queue.isEmpty()) {
            int curr = queue.poll();
            for (int i : g.adj(curr))
                if (!marked[i]) {
                    marked[i] = true;
                    queue.add(i);
                }
        }
    }
    public boolean marked(int v) { return marked[v]; }
}
    <!-- endtab -->
{{< /tabbed-codeblock >}}

# 3. Tối ưu hóa

## References

- [Algorithms, 4th Edition by Robert Sedgewick and Kevin Wayne](https://algs4.cs.princeton.edu/home/)


