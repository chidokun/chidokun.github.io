---
title: "Thuật toán Prim: Cài đặt thuật toán"
slug: "prim-algorithm-implement"
date: 2021-07-25T20:26:28+07:00
draft: false
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

Bài viết [Thuật toán Prim: Tìm cây khung nhỏ nhất]({{< ref "/post/software/prim-algorithm" >}}) đã giới thiệu đến các bạn ý tưởng của thuật toán này cũng như từng bước chạy thuật toán. Tiếp theo sẽ là phần hướng dẫn cài đặt *thuật toán Prim* cho đồ thị vô hướng có trọng số bằng ngôn ngữ Java. 

<!--more-->

<!--toc-->

# 1. Nhắc lại thuật toán

Chúng ta cùng nhắc lại ý tưởng cơ bản của thuật toán Prim:

- <u>*Bước 1*</u>: Chọn một đỉnh `v` bất kỳ làm đỉnh bắt đầu và đưa đỉnh `v` vào cây khung.
- <u>*Bước 2*</u>: Thêm tất cả các cạnh nối với `v` vào danh sách cạnh đang xét .
- <u>*Bước 3*</u>: Xét các cạnh trong danh sách đến khi hết:
    - <u>*Bước 3.1*</u>: Lấy ra cạnh có trọng số nhỏ nhất nối từ `v1` đến một đỉnh `v2` chưa nằm trong cây khung. Đưa cạnh này và đỉnh `v2` vào cây khung.
    - <u>*Bước 3.2*</u>: Đưa các cạnh nối từ đỉnh `v2` đến các đỉnh chưa nằm trong cây khung vào danh sách cạnh đang xét.

Ở bước lấy ra cạnh có trọng số nhỏ nhất trong số các cạnh đang xét, chúng ta sử dụng Min-PriorityQueue để lấy ra cạnh có trọng số nhỏ nhất.

# 2. Định nghĩa API

Để hiện thực thuật toán Prim, chúng ta có thể sử dụng cấu trúc `EdgeWeightedGraph` để lưu trữ đồ thị vô hướng có trọng số mà mình có giới thiệu qua ở bài viết [Tổng quan về đồ thị]({{< ref "/post/software/graph-overview" >}}). Chúng ta định nghĩa các phương thức như sau:

```
    public class LazyPrimMST
----------------------------------------------------
                 LazyPrimMST(EdgeWeightedGraph g)
  Iterable<Edge> edges()
          double weight()
```

Class `LayzyPrimMST` sẽ làm nhiệm vụ tìm cây khung nhỏ nhất cho đồ thị `g` với các phương thức:

- *<b>LazyPrimMST(EdgeWeightedGraph g)</b>*: Constructor nhận vào đồ thị vô hướng có trọng số `g` và thực hiện tìm cây khung nhỏ nhất.
- *<b>edges()</b>*: Trả về các cạnh của cây khung nhỏ nhất.
- *<b>weight()</b>*: Trả về trọng số của cây khung nhỏ nhất.

Lúc này chúng ta có thể viết hàm `main` để test với đồ thị $G$ trong bài viết trước.

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/prim-algorithm/1.svg" title="Đồ thị $G$">}}

```java
public static void main(String[] args) {
    EdgeWeightedGraph g = new EdgeWeightedGraph(9);
    g.addEdge(new Edge(0, 1, 2.5));
    g.addEdge(new Edge(0, 2, 2.0));
    g.addEdge(new Edge(0, 3, 2.1));
    g.addEdge(new Edge(1, 4, 1.0));
    g.addEdge(new Edge(2, 4, 0.6));
    g.addEdge(new Edge(2, 5, 1.5));
    g.addEdge(new Edge(3, 5, 2.5));
    g.addEdge(new Edge(4, 6, 2.3));
    g.addEdge(new Edge(5, 6, 1.9));
    g.addEdge(new Edge(5, 7, 2.0));
    g.addEdge(new Edge(6, 7, 1.8));
    g.addEdge(new Edge(6, 8, 1.7));
    g.addEdge(new Edge(7, 8, 2.0));

    LazyPrimMST prim = new LazyPrimMST(g);
    System.out.println("Edges: ");
    for (Edge e : prim.edges())
        System.out.printf("%d-%d: %f\n", e.either(), e.other(e.either()), e.weight());
    System.out.println("Weight: " + prim.weight());
}
```

# 3. Cài đặt thuật toán.

Bên trong class `LazyPrimMST`, chúng ta định nghĩa một số field hỗ trợ cho việc tìm cây khung nhỏ nhất.

```java
private boolean[] marked;
private LinkedList<Edge> mst;
private PriorityQueue<Edge> pq;
```

- <b>*marked*</b>: Mảng boolean đánh dấu một đỉnh đã được đưa vào cây khung hay chưa.
- <b>*mst*</b>: Danh sách các cạnh của cây khung.
- <b>*pq*</b>: Danh sách các cạnh dùng để xét sau mỗi bước chạy thuật toán. Sử dụng `PriorityQueue` để tiện lấy ra cạnh nhỏ nhất.

Thuật toán của chúng ta sẽ chạy trong constructor, ở đây chúng ta sẽ định nghĩa thêm hàm `visit(G, v)` làm nhiệm vụ đánh dấu đỉnh `v` đã được đưa vào cây khung và đưa các cạnh kề vào PriorityQueue.

Các bước thực hiện:

- *1.* "Viếng thăm" đỉnh $0$.
- *2.* Xét nếu queue vẫn có phần tử:
    - *2.1.* Lấy cạnh nhỏ nhất trong danh sách đang xét.
    - *2.2.* Nếu cả 2 đỉnh của cạnh này đều nằm trong cây khung thì bỏ qua.
    - *2.3.* Còn không thì đưa cạnh nhỏ nhất này vào cây khung.
    - *2.4.* "Viếng thăm" đỉnh chưa nằm trong cây khung.
    
```java
public LazyPrimMST(EdgeWeightedGraph g) {
    pq = new PriorityQueue<>(Edge::compareTo);
    marked = new boolean[g.V()];
    mst = new LinkedList<>();
    visit(g, 0);
    while (!pq.isEmpty()) {
        Edge e = pq.poll();
        int v = e.either(), w = e.other(v);
        if (marked[v] && marked[w]) continue;
        mst.add(e);
        if (!marked[v]) visit(g, v);
        if (!marked[w]) visit(g, w);
    }
}

private void visit(EdgeWeightedGraph G, int v) {
    marked[v] = true;
    for (Edge e : G.adj(v))
        if (!marked[e.other(v)]) pq.add(e);
} 
```

Cài đặt các phương thức còn lại của class `LazyPrimMST`:

```java
public Iterable<Edge> edges() {
    return mst;
}

public double weight() {
    return mst.stream().mapToDouble(Edge::weight).sum();
}
```

Sau khi hoàn tất, cùng test lại hàm `main` để xem kết quả:

```
Edges: 
0-2: 2.000000
2-4: 0.600000
1-4: 1.000000
2-5: 1.500000
5-6: 1.900000
6-8: 1.700000
6-7: 1.800000
0-3: 2.100000
Weight: 12.6
```

Vẫn đúng với kết quả chạy từng bước ở bài viết trước phải không nào!

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/prim-algorithm/11.svg" >}}

## References

- [Algorithms, 4th Edition by Robert Sedgewick and Kevin Wayne](https://algs4.cs.princeton.edu/home/)