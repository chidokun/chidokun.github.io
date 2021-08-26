---
title: "Tổng quan về Đồ thị"
slug: "graph-overview"
date: 2021-06-22T21:51:01+07:00
draft: false
categories:
- "Lập trình"
- "Cấu trúc dữ liệu"
tags:
- "graph"
keywords:
- "graph"
- "java"
thumbnailImage: /thumbnails/graph.png
thumbnailImagePosition: left
---

Cấu trúc **Graph** (đồ thị) có rất nhiều ứng dụng trong thực tiễn. Bài viết này sẽ note lại tổng quan những điểm chính về việc implement cấu trúc dữ liệu này.

<!--more-->

<!--toc-->

# 1. Đồ thị

Theo định nghĩa, *Đồ thị là một tập hữu hạn các đỉnh và các cạnh kết nối các đỉnh*. Chúng ta sẽ không đi quá sâu về lý thuyết đồ thị mà chỉ điểm lại những nét chính trong cách cài đặt cấu trúc dữ liệu `Graph`.

Ví dụ về một *đồ thị vô hướng* như bên dưới:

{{< image classes="fancybox center" thumbnail-width="60%" src="/images/post/graph-overview/1.svg" title="Đồ thị 1: Đồ thị vô hướng">}}

Trong một số trường hợp, chúng ta sẽ cần dùng tên đỉnh. Tuy nhiên, tên đỉnh không quá quan trọng nên chúng ta sẽ đặt tên đỉnh là các số nguyên từ $0$ đến $V-1$. Một `Graph` sẽ có `V` đỉnh và `E` cạnh. Việc định nghĩa thành các phương thức của đối tượng sẽ giúp việc viết các giải thuật đơn giản hơn.

Định nghĩa API cho `Graph`:

```
       public class Graph
--------------------------------------------
                    Graph(int V)
                int V()
                int E()
               void addEdge(int v, int w)
  Iterable<Integer> adj(int v)
```

Các phương thức cơ bản nhất:

- **Graph**(int V): Hàm khởi tạo với tham số đầu vào là số lượng đỉnh.
- **V**(): Trả về số lượng đỉnh.
- **E**(): Trả về số lượng cạnh.
- **addEdge**(int v, int w): Thêm một cạnh vào đồ thị, truyền 2 đỉnh `v` và `w`.
- **adj**(int v): Lấy danh sách các đỉnh kề của đỉnh `v`.

# 2. Biểu diễn đồ thị

Có 2 cách biểu diễn phổ biến nhất là dùng **ma trận kề** (*adjacency matrix*) và **danh sách kề** (*adjacency list*).

## 2.1. Adjacency matrix

Khi biểu diễn graph bằng adjacency matrix, ta dùng một ma trận vuông $n \\times n$ với $n$ là số đỉnh của graph. Mỗi dòng thể hiện một đỉnh, mỗi cột biểu diễn vị trí mà ở đó đỉnh có kết nối tới. 

Ví dụ với **Đồ thị 1** trên, ma trận kề sẽ là:

{{< image classes="fancybox center" thumbnail-width="40%" src="/images/post/graph-overview/2.svg" title="Ma trận kề cho Đồ thị 1">}}

Cách implement tham khảo:

{{< tabbed-codeblock Graph>}}
    <!-- tab java -->
public class Graph {
    private final int V;
    private int E;
    private int[][] adj;

    public Graph(int V) {
        this.V = V;
        this.E = 0;
        this.adj = new int[V][V];
        for (int i = 0; i < V; i++)
            for (int j = 0; j < V; j++)
                adj[i][j] = 0;
    }
    public int V() { return V; }
    public int E() { return E; }
    public void addEdge(int v, int w) {
        adj[v][w] = 1;
        adj[w][v] = 1;
        E++;
    }
    public Iterable<Integer> adj(int v) {
        List<Integer> ls = new ArrayList<>();
        for (int i = 0; i < V; i++)
            if (this.adj[v][i] == 1)
                ls.add(i);
        return ls;
    }
}
    <!-- endtab -->
{{< /tabbed-codeblock >}}

Cách biểu diễn này có nhiều ưu điểm như:

- Tác vụ thêm cạnh nhanh do chỉ cần bật giá trị trong ma trận thành 1.
- Kiểm tra 2 đỉnh có kết nối nhau chỉ tốn $O(1)$.

Tuy nhiên, nó cũng có một số hạn chế:

- Do phải lưu trữ bằng một ma trận $n \\times n$, nếu đồ thị có hàng triệu điểm thì rất tốn chi phí để duyệt cũng như lưu trữ.
- Không thể biểu diễn cạnh song song có trọng số.


## 2.2. Adjacency list

Với adjacency list, chúng ta sẽ lưu một mảng các đỉnh, mỗi đỉnh chứa một danh sách các đỉnh khác mà nó kết nối tới.

{{< image classes="fancybox center" thumbnail-width="40%" src="/images/post/graph-overview/3.svg" title="Danh sách kề cho Đồ thị 1">}}

{{< tabbed-codeblock Graph>}}
    <!-- tab java -->
public class Graph {
    private final int V;
    private int E;
    private List<Integer>[] adj;

    public Graph(int V) {
        this.V = V;
        this.E = 0;
        this.adj = (List<Integer>[]) new List[V];
        for (int v = 0; v < V; v++) {
            this.adj[v] = new ArrayList<>();
        }
    }
    public int V() { return V; }
    public int E() { return E; }
    public void addEdge(int v, int w) {
        adj[v].add(w);
        adj[w].add(v);
        E++;
    }
    public Iterable<Integer> adj(int v) { return adj[v]; }
}
    <!-- endtab -->
{{< /tabbed-codeblock >}}

Ưu điểm của danh sách kề:

- Không như ma trận kề, danh sách kề không tốn dung lượng lưu trữ cho những cạnh không tồn tại. Vì vậy, nó có thể biểu diễn và lưu trữ hàng triệu đỉnh.
- Biểu diễn được cạnh song song.

Nhược điểm chủ yếu là:

- Việc remove cạnh sẽ tốn chi phí để duyệt danh sách.
- Chi phí kiểm tra 2 cạnh có kết nối nhau không sẽ lớn hơn ma trận kề do phải duyệt danh sách.

# 3. Mở rộng

Cấu trúc ở trên khá đơn giản, để giải quyết yêu cầu phức tạp hơn cần mở rộng nó, dưới đây là một số gợi ý mở rộng cấu trúc đồ thị.

## 3.1. Trọng số

Mỗi cạnh thường có một trọng số biểu thị cho chi phí từ một đỉnh sang đỉnh khác. Ma trận kề có thể biểu diễn dễ dàng trọng số. Giá trị trong ma trận kề sẽ biểu thị trọng số. Giá trị $\\infty$ biểu thị 2 đỉnh không kết nối với nhau.


{{< image classes="fancybox center" thumbnail-width="90%" src="/images/post/graph-overview/4.svg" title="Đồ thị có trọng số biểu diễn bằng ma trận kề">}}


Dưới đây là cách implement tham khảo cho `WeightedGraph` sử dụng ma trận trọng số.

{{< tabbed-codeblock WeightedGraph>}}
    <!-- tab java -->
public class WeightedGraph {
    private final int V;
    private int E;
    private double[][] adj;

    public WeightedGraph(int V) {
        this.V = V;
        this.E = 0;
        this.adj = new double[V][V];
        for (int i = 0; i < V; i++)
            for (int j = 0; j < V; j++)
                adj[i][j] = i == j ? 0 : Double.POSITIVE_INFINITY;
    }
    public void addEdge(int v, int w, double weight) {
        adj[v][w] = weight;
        adj[w][v] = weight;
        E++;
    }

    // các method còn lại tương tự
}
    <!-- endtab -->
{{< /tabbed-codeblock >}}


Để biểu diễn bằng danh sách kề, trước hết chúng ta cần tạo class `Edge` biểu diễn một cạnh. Class `Edge` implement `Comparable<Edge>` giúp thuận tiện cho các thao tác sort, so sánh.

Các method của `Edge`:

- **weight**(): Trả về trọng số của cạnh hiện tại.
- **either**(): Trả về đỉnh đầu trong cạnh.
- **other**(int v): Trả về cạnh còn lại trong đồ thị vô hướng, nếu là đồ thị có hướng thì trả về đỉnh cuối và không cần tham số đầu vào nữa.

{{< tabbed-codeblock Edge>}}
    <!-- tab java -->
public class Edge implements Comparable<Edge> {
    private final int v;
    private final int w;
    private final double weight;
    public Edge(int v, int w, double weight) {
        this.v = v;
        this.w = w;
        this.weight = weight;
    }
    public double weight() {  return weight;  }
    public int either() { return v; }
    public int other(int vertex) {
        if      (vertex == v) return w;
        else if (vertex == w) return v;
        else throw new RuntimeException("Inconsistent edge");
    }
    public int compareTo(Edge that) {
        double result = this.weight() - that.weight();
        if      (result < 0) return -1;
        else if (result > 0) return +1;
        else                 return  0;
    }
}
    <!-- endtab -->
{{< /tabbed-codeblock >}}

Danh sách kề lúc này sẽ là một danh sách các cạnh `Edge`.

{{< tabbed-codeblock Edge>}}
    <!-- tab java -->
public class EdgeWeightedGraph {
    private final int V;
    private int E;
    private List<Edge>[] adj;

    public EdgeWeightedGraph(int V) {
        this.V = V;
        this.E = 0;
        this.adj = (List<Edge>[]) new List[V];
        for (int v = 0; v < V; v++) {
            this.adj[v] = new ArrayList<>();
        }
    }
    public int V() { return V; }
    public int E() { return E; }
    public void addEdge(Edge e) {
        int v = e.either(), w = e.other(v);
        adj[v].add(e);
        adj[w].add(e);
        E++;
    }
    public Iterable<Edge> adj(int v) { return adj[v]; }
}
    <!-- endtab -->
{{< /tabbed-codeblock >}}


## 3.2. Đồ thị có hướng

Đồ thị có hướng là dạng đồ thị có tập đỉnh được nối với các cạnh có hướng. Cả ma trận kề và danh sách kề đều biểu diễn được đồ thị có hướng.

Ví dụ đồ thị sau:

{{< image classes="fancybox center" thumbnail-width="100%" src="/images/post/graph-overview/5.svg" title="Đồ thị có hướng biểu diễn bằng ma trận kề và danh sách kề">}}


## 3.3. Vòng khuyên

Một vòng khuyên (self-loop) là một cạnh nối 1 đỉnh với chính nó.

Ví dụ về vòng khuyên:

{{< image classes="fancybox center" thumbnail-width="100%" src="/images/post/graph-overview/6.svg" title="Đồ thị vô hướng có vòng khuyên biểu diễn bằng ma trận kề và danh sách kề">}}


## 3.4. Cạnh song song

Cạnh song song (parallel edges) xuất hiện khi có nhiều hơn 1 cạnh nối cùng một cặp đỉnh. Đồ thị biểu diễn bằng danh sách kề có thể biểu diễn cạnh song song. Ma trận kề cũng có thể biểu diễn cạnh song song khi giá trị trong ma trận biểu thị số lượng cạnh nối. Tuy nhiên, không thể dùng ma trận trọng số để vừa biểu diễn cạnh song song, vừa biểu diễn trọng số.

Ví dụ:

{{< image classes="fancybox center" thumbnail-width="100%" src="/images/post/graph-overview/7.svg" title="Đồ thị vô hướng có vòng khuyên và cạnh song song biểu diễn bằng ma trận kề và danh sách kề">}}

# References

- [Graph (discrete mathematics)](https://en.wikipedia.org/wiki/Graph_(discrete_mathematics))
- [Algorithms, 4th Edition by Robert Sedgewick and Kevin Wayne](https://algs4.cs.princeton.edu/home/)


