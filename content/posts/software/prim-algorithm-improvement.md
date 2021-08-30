---
title: "Thuật toán Prim: Cải tiến dùng Index Priority Queue"
slug: "prim-algorithm-improvement"
date: 2021-08-15T18:13:28+07:00
draft: false
categories:
- "Lập trình"
- "Giải thuật"
tags:
- "prim"
- "graph"
- "java"
keywords:
- "graph"
- "java"
- "prim"
- "spanning tree"
- "cây khung"
thumbnailImage: /thumbnails/graph.png
thumbnailImagePosition: left
---

Ở phần trước [Thuật toán Prim: Cài đặt thuật toán]({{< ref "/posts/software/prim-algorithm-implement" >}}) chúng ta đã tìm hiểu qua cách cài đặt thuật toán Prim dựa vào Priority Queue. Tuy nhiên, có một nhược điểm là phải duyệt các cạnh không hợp lệ trong queue. Do vậy, trong bài này chúng ta sẽ tối ưu cách cài đặt thuật toán Prim ở bài trước bằng cách sử dụng Index Priority Queue.

<!--more-->

{{< toc >}}

# 1. Ý tưởng

Ở phiên bản trước, chúng ta lấy ra cạnh nhỏ nhất bằng Min Priority Queue. Tất cả các cạnh được đẩy vào Priority Queue để rồi sau đó sẽ phải xử lý những cạnh thừa. Trong bước tối ưu này, Index Priority Queue sẽ chỉ chứa cạnh tối ưu nhất ở đỉnh đích, nếu có cạnh nào tối ưu hơn cạnh đó thì cập nhật trực tiếp vào queue. Do đó sẽ không phải xử lý cạnh thừa nữa.

Các bước của thuật toán như sau:

- <u>*Bước 1*</u>: Chọn một đỉnh `v` bất kỳ làm đỉnh bắt đầu và đưa đỉnh `v` vào cây khung.
- <u>*Bước 2*</u>: Thêm tất cả các cạnh nối với `v` vào danh sách cạnh đang xét .
- <u>*Bước 3*</u>: Xét các cạnh trong danh sách đến khi hết:
    - <u>*Bước 3.1*</u>: Lấy ra cạnh có trọng số nhỏ nhất nối từ `v1` đến một đỉnh `v2` chưa nằm trong cây khung. Đưa cạnh này và đỉnh `v2` vào cây khung.
    - <u>*Bước 3.2*</u>: *Trong các đỉnh kề của `v2`, nếu có đỉnh nào đã nằm trong danh sách đang xét mà có trọng số nhỏ hơn thì thay thế cạnh tương ứng đỉnh đó trong danh sách đang xét bằng cạnh này. Nếu chưa nằm trong cây khung thì đưa vào danh sách cạnh đang xét.*

Ở bước lấy ra cạnh có trọng số nhỏ nhất trong số các cạnh đang xét, chúng ta sử dụng Index Min-PriorityQueue để lấy ra cạnh có trọng số nhỏ nhất và thay thế cạnh ở bước 3.2.

# 2. Từng bước chạy thuật toán

Cùng chạy thuật toán với đồ thị $G$ bên dưới:

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/prim-algorithm/1.svg" title="Đồ thị $G$">}}

Chọn đỉnh $0$ làm đỉnh bắt đầu, đưa đỉnh này vào cây khung (màu xanh). Đưa các cạnh 0-1, 0-2, 0-3 vào danh sách cạnh đang xét (màu cam). Ta thấy cạnh 0-2 là cạnh có trọng số nhỏ nhất.

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/software/prim-algorithm-improvement/1.svg" >}}

Đưa cạnh 0-2 và đỉnh $2$ vào cây khung. Đưa các cạnh 2-4 và 2-5 vào danh sách đang xét. Lúc này ta thấy cạnh 2-4 có trọng số nhỏ nhất.

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/software/prim-algorithm-improvement/2.svg">}}

Đưa cạnh 2-4 và đỉnh $4$ vào cây khung. Đưa các cạnh 4-1 và 4-6 vào danh sách đang xét. Cạnh 4-1 có trọng số nhỏ hơn cạnh 0-1 nên sẽ thay thế cạnh này. Lúc này ta thấy cạnh 4-1 có trọng số nhỏ nhất.

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/software/prim-algorithm-improvement/3.svg">}}

Đưa cạnh 4-1 và đỉnh $1$ vào cây khung. Các đỉnh nối từ $1$ là $0$ và $4$ đều đã nằm trong cây khung nên chúng ta sẽ không đưa các cạnh nối các đỉnh này vào danh sách đang xét. Lúc này, ta xét các cạnh còn lại và thấy cạnh 2-5 có trọng số nhỏ nhất.

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/software/prim-algorithm-improvement/4.svg">}}

Đưa cạnh 2-5 và đỉnh $5$ vào cây khung. Tiếp tục xét ba cạnh 5-3, 5-6 và 5-7. Cạnh 5-3 có trọng số lớn hơn cạnh 0-3 trong danh sách đang xét nên sẽ không được đưa vào. Cạnh 5-6 có trọng số nhỏ hơn cạnh 4-6 trong danh sách nên sẽ thay thế cho cạnh này. Cạnh 5-7 có đỉnh $7$ chưa có trong danh sách nên sẽ được đưa vào danh sách đang xét. Trong danh sách đang xét lúc này, cạnh 5-6 có trọng số nhỏ nhất.

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/software/prim-algorithm-improvement/5.svg">}}

Đưa cạnh 5-6 và đỉnh $6$ vào cây khung. Tiếp tục xét cạnh 6-4, 6-7 và 6-8, không đưa cạnh 6-4 vì đỉnh $4$ đã nằm trong cây khung. Cạnh 6-7 có trọng số nhỏ hơn cạnh 5-7 trong danh sách đang xét nên sẽ thay thế cho cạnh này. Cạnh 6-8 với đỉnh $8$ chưa nằm trong danh sách đang xét nên sẽ được đưa vào danh sách đang xét. Cạnh 6-8 lúc này có trọng số nhỏ nhất.

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/software/prim-algorithm-improvement/6.svg">}}

Đưa cạnh 6-8 và đỉnh $8$ vào cây khung. Cạnh 8-7 có trọng số lớn hơn cạnh 6-7 nên sẽ không được đưa vào danh sách đang xét. Lúc này danh sách có cạnh 6-7 có trọng số nhỏ nhất.

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/software/prim-algorithm-improvement/7.svg">}}

Đưa cạnh 6-7 và đỉnh $7$ vào cây khung. Không có cạnh nào được đưa tiếp vào danh sách đang xét vì các đỉnh kề của $7$ đều đã nằm trong cây khung. Chỉ còn cạnh 0-3 là cạnh có trọng số nhỏ nhất.

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/software/prim-algorithm-improvement/8.svg">}}

Đưa cạnh 0-3 vào cây khung. Các đỉnh kề của đỉnh $3$ đều nằm trong cây khung.

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/software/prim-algorithm-improvement/9.svg">}}

Danh sách lúc này rỗng. Thuật toán kết thúc.

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/prim-algorithm/11.svg" >}}


# 3. Cài đặt thuật toán.

Để hiện thực thuật toán Prim, chúng ta sẽ sử dụng cấu trúc đồ thị vô hướng có trọng số `EdgeWeightedGraph` ở bài viết [Tổng quan về đồ thị]({{< ref "/posts/software/graph-overview" >}}). Interface `PrimMST` ở bài viết [Thuật toán Prim: Cài đặt thuật toán]({{< ref "/posts/software/prim-algorithm-implement" >}}) và cấu trúc `IndexPQ` ở bài viết [Index Priority Queue]({{< ref "/posts/software/index-priority-queue" >}}).

Trước hết chúng ta tạo class `EagerPrimMST` hiện thực interface `PrimMST` và cài đặt một hàm constructor nhận `EdgeWeightedGraph` làm tham số đầu vào.

```java
public class EagerPrimMST implements PrimMST {
    public EagerPrimMST(EdgeWeightedGraph G) {
        // to be implemented
    }

    @Override
    public Iterable<Edge> edges() {
        // to be implemented
    }

    @Override
    public double weight() {
        // to be implemented
    }
}
```

Bên trong `EagerPrimMST` là các field sử dụng để tìm cây khung nhỏ nhất.

```java
private boolean[] marked;
private Edge[] edgeTo;
private double[] distTo;
private IndexPQ<Double> pq;
```

- <b>*marked*</b>: Mảng boolean đánh dấu một đỉnh đã được đưa vào cây khung hay chưa.
- <b>*edgeTo*</b>: Tham chiếu của cạnh tối ưu nhất đến một đỉnh.
- <b>*distTo*</b>: Khoảng cách tối ưu nhất đến một đỉnh.
- <b>*pq*</b>: Danh sách các cạnh dùng để xét sau mỗi bước chạy thuật toán. Sử dụng `IndexPQ` cho thao tác lấy ra cạnh nhỏ nhất và thay thế cạnh.

Thuật toán được hiện thực ở contructor như sau:

```java
public EagerPrimMST(EdgeWeightedGraph G) {
    // initialization
    edgeTo = new Edge[G.V()];
    distTo = new double[G.V()];
    marked = new boolean[G.V()];
    for (int v = 0; v < G.V(); v++)
        distTo[v] = Double.POSITIVE_INFINITY;
    pq = new IndexPQ<Double>(G.V(), Comparator.naturalOrder());

    // init pq with 0 to start at vertex 0
    distTo[0] = 0.0;
    pq.insert(0, 0.0);              
    while (!pq.isEmpty())
        visit(G, pq.removePeek());
}

private void visit(EdgeWeightedGraph G, int v) { 
    marked[v] = true;
    for (Edge e : G.adj(v)) {
        int w = e.other(v);
        if (marked[w]) continue;
        if (e.weight() < distTo[w]) {  // Edge e is new best connection from tree to w.
            edgeTo[w] = e;
            distTo[w] = e.weight();
            if (pq.contains(w))
                pq.change(w, distTo[w]);
            else
                pq.insert(w, distTo[w]);
        }
    }
}
```

Cài đặt các phương thức còn lại.

```java
@Override
public Iterable<Edge> edges() {
    ArrayList<Edge> mst = new ArrayList<>();
    for (int i = 1; i < edgeTo.length; i++) {
        mst.add(edgeTo[i]);
    }
    return mst;
}

@Override
public double weight() {
    return Arrays.stream(distTo).sum();
}
```

Khởi tạo đồ thị $G$ và test với hàm `main`.

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

    PrimMST prim = new EagerPrimMST(g);
    System.out.println("Edges: ");
    for (Edge e : prim.edges())
        System.out.printf("%d-%d: %f\n", e.either(), e.other(e.either()), e.weight());
    System.out.println("Weight: " + prim.weight());
}
```

Và kết quả:

```
Edges: 
1-4: 1.000000
0-2: 2.000000
0-3: 2.100000
2-4: 0.600000
2-5: 1.500000
5-6: 1.900000
6-7: 1.800000
6-8: 1.700000
Weight: 12.6
```

## References

- [Algorithms, 4th Edition by Robert Sedgewick and Kevin Wayne](https://algs4.cs.princeton.edu/home/)