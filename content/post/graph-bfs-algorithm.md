---
title: "Thuật toán Breath First Search"
slug: "graph-bfs-algorithm"
date: 2021-06-27T20:03:25+07:00
draft: false
categories:
- "Lập trình"
- "Cấu trúc dữ liệu và Giải thuật"
tags:
- "data structures"
- "algorithms"
keywords:
- "graph"
- "java"
- "breath first search"
- "bfs"
thumbnailImage: /thumbnails/graph.png
thumbnailImagePosition: left
---

**Breath First Search** (BFS) cùng với **Depth First Search** là những thuật toán cơ bản dùng để duyệt qua đồ thị. Trong bài viết này, chúng ta sẽ cùng làm rõ ý tưởng cũng như cách hiện thực thuật toán này.

<!--more-->

<!--toc-->

# 1. Ý tưởng

Ý tưởng cơ bản như sau:

- Từ một đỉnh, ta tìm các đỉnh kề rồi duyệt qua các đỉnh này.
- Tiếp tục tìm các đỉnh kề của đỉnh vừa xét rồi duyệt tiếp đến khi đi qua hết tất cả các đỉnh có thể đi.


# 2. Hiện thực

Cách hiện thực thuật toán BFS cũng tương tự như DFS ở bài viết [Thuật toán Depth First Search]({{< ref "/post/graph-dfs-algorithm" >}}). Ta cần dùng một mảng `marked` để kiểm tra xem một đỉnh đã được duyệt qua chưa. Ở đây, chúng ta dùng một `queue` để lưu các đỉnh chưa xét đỉnh kề.

Đầu vào cần một `Graph` và đỉnh gốc `s`. Thực hiện các bước như sau:

- Đánh dấu điểm gốc `s` đã duyệt qua.
- Thêm `s` vào `queue` (*vì `s` chưa xét các đỉnh kề*)
- Nếu vẫn còn đỉnh để xét thì:
    - Lấy đỉnh từ `queue` để xét các đỉnh kề của nó.
    - Lần lượt duyệt các đỉnh kề nếu nó chưa được duyệt qua. Trong quá trình duyệt qua, thêm đỉnh vào `queue` để chuẩn bị cho việc xét đỉnh kề của đỉnh đó.


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

# 3. Áp dụng

Ta trở lại với bài toán trước ở bài viết [Thuật toán Depth First Search]({{< ref "/post/graph-dfs-algorithm" >}}).

> **Bài toán**: *Cho đồ thị `g` và đỉnh gốc `s`. Trả lời câu hỏi, có đường đi nào từ đỉnh gốc `s` tới một đỉnh `w` nào đó không. Nếu có, hãy tìm đường đi đó.*

Về ý tưởng thì tương tự, nhưng sẽ đổi lời giải bằng thuật toán BFS để xem kết quả nhé.

Code tham khảo:

{{< tabbed-codeblock BreathFirstPaths>}}
    <!-- tab java -->
public class BreathFirstPaths {
    private boolean[] marked;
    private int[] edgeTo;
    private int s;
    public BreathFirstPaths(Graph g, int s) {
        marked = new boolean[g.V()];
        edgeTo = new int[g.V()];
        this.s = s;
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
                    edgeTo[i] = curr;
                    marked[i] = true;
                    queue.add(i);
                }
        }
    }
    public boolean hasPathTo(int w) { return marked[w]; }
    public Iterable<Integer> pathTo(int w) {
        if (!hasPathTo(w)) return null;
        LinkedList<Integer> path = new LinkedList<>();
        for (int i = w; i != s; i = edgeTo[i])
            path.addFirst(i);
        path.addFirst(s);
        return path;
    }
    <!-- endtab -->
{{< /tabbed-codeblock >}}

Thử nghiệm với đồ thị sau đây:

{{< image classes="fancybox center" thumbnail-width="60%" src="/images/post/graph-overview/1.svg" title="Đồ thị 1">}}

Hàm `main` để test:

{{< tabbed-codeblock DepthFirstPaths>}}
    <!-- tab java -->
public static void main(String[] args) {
    Graph g = new Graph(6);
    g.addEdge(0, 1);
    g.addEdge(0, 2);
    g.addEdge(0, 3);
    g.addEdge(1, 4);
    g.addEdge(2, 4);
    g.addEdge(2, 5);

    BreathFirstPaths path = new BreathFirstPaths(g, 0);
    for (int i = 0; i < 6; i++) {
        Iterable<Integer> rs = path.pathTo(i);
        System.out.println(rs);
    }
}
    <!-- endtab -->
{{< /tabbed-codeblock >}}

Kết quả là:

```
[0]
[0, 1]
[0, 2]
[0, 3]
[0, 1, 4]
[0, 2, 5]
```

Và đường đi mà thuật toán cho kết quả là:

{{< image classes="fancybox center" thumbnail-width="60%" src="/images/post/graph-bfs-algorithm/1.svg" title="Đường đi cho Đồ thị 1">}}

Có thể thấy, thuật toán BFS luôn cho đường đi ngắn nhất từ đỉnh gốc tới các đỉnh khác trong đồ thị vô hướng không có trọng số. *"Ngắn"* ở đây là qua ít đỉnh nhất nhé các bạn :laughing:.

# 4. Đánh giá

Thuật toán sẽ duyệt qua tất cả các đỉnh nếu đồ thị liên thông. Giống như DFS, BFS cũng là thuật toán tìm kiếm mù, mang tính chất vét cạn.

## References

- [Algorithms, 4th Edition by Robert Sedgewick and Kevin Wayne](https://algs4.cs.princeton.edu/home/)


