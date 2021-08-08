---
title: "Thuật toán Depth First Search"
slug: "graph-dfs-algorithm"
date: 2021-06-26T21:10:21+07:00
draft: false
categories:
- programming
tags:
- "data structures"
- "algorithms"
keywords:
- "graph"
- "java"
- "depth first search"
- "dfs"
thumbnailImage: /thumbnails/graph.png
thumbnailImagePosition: left
---

Cấu trúc **Graph** (đồ thị) gồm tập các đỉnh kết nối với nhau qua các cạnh. **Depth First Search** (DFS) là một trong những thuật toán có thể dùng để duyệt qua đồ thị.

<!--more-->

<!--toc-->

# 1. Ý tưởng

Ý tưởng như sau:

- Từ một đỉnh, ta đi qua sâu vào từng nhánh. Khi đã duyệt hết nhánh của đỉnh, lùi lại để duyệt đỉnh tiếp theo.
- Thuật toán dừng khi đi qua hết tất cả các đỉnh có thể đi qua.

# 2. Hiện thực

Hai cách hiện thực dưới đây được dùng cho cấu trúc Graph ở bài viết [Tổng quan về Đồ thị]({{< ref "/post/graph-overview" >}}).

## 2.1. Đệ quy

Hiện thực theo phương pháp đệ quy khá đơn giản và dễ hiểu. Ta cần dùng một mảng `marked` để kiểm tra xem một đỉnh đã được duyệt qua chưa. 

Đầu vào cần một `Graph` và đỉnh gốc `v`. Các bước như sau:

- Đánh dấu điểm gốc `v` đã duyệt qua.
- Lấy danh sách các đỉnh kề của `v`. Với mỗi đỉnh `i`:
    - Nếu `i` chưa được duyệt qua thì chọn `i` làm đỉnh gốc mới và lặp lại thủ tục trên.

Code tham khảo:

{{< tabbed-codeblock DepthFirstSearch>}}
    <!-- tab java -->
public class DepthFirstSearch {
    private boolean[] marked;
    public DepthFirstSearch(Graph g, int v) {
        // init vertex marked with default value false
        marked = new boolean[g.V()];
        dfs(g, v);
    }
    private void dfs(Graph g, int v) {
        marked[v] = true;
        for (int i : g.adj(v)) {
            if (!marked[v])
                dfs(g, i);
        }
    }
    public boolean marked(int v) { return marked[v]; }
}
    <!-- endtab -->
{{< /tabbed-codeblock >}}

## 2.2. Khử đệ quy

Với phương pháp không dùng đệ quy, cách hiện thực hơi phức tạp hơn chút. Lúc này phải dùng một `Stack` để xét các đỉnh chưa duyệt.

Đầu vào là một `Graph` và đỉnh gốc `v`. Các bước như sau:

- Thêm đỉnh gốc vào `stack`.
- Lặp lại với điều kiện `stack` không rỗng:
    - Lấy đỉnh ở đầu `stack` làm *đỉnh đang xét*.
    - Nếu *đỉnh đang xét* đã được duyệt thì bỏ qua. (<span style="color:red">*</span>)
    - Đánh dấu *đỉnh đang xét* là đỉnh đã duyệt.
    - Lấy danh sách các đỉnh kề của *đỉnh đang xét*. Với mỗi đỉnh `i`:
        - Nếu `i` chưa được duyệt qua thì đẩy `i` vào `stack`.

Code tham khảo:

{{< tabbed-codeblock DepthFirstSearch>}}
    <!-- tab java -->
private void dfs(Graph g, int v) {
    Stack<Integer> stack = new Stack<>();
    stack.push(v);
    int currentVertex;

    while (!stack.isEmpty()) {
        currentVertex = stack.pop();
        if (marked[currentVertex]) continue;

        marked[currentVertex] = true;
        for (Integer i : g.adj(currentVertex))
            if (!marked[i])
                stack.push(i);
    }
}
    <!-- endtab -->
{{< /tabbed-codeblock >}}

{{< alert info >}}
- (<span style="color:red">*</span>) Nếu không làm bước này, sẽ xảy ra trường hợp một đỉnh chưa được duyệt được thêm vào `stack` nhiều lần và kết quả là sẽ được duyệt qua nhiều lần.
- Kết quả duyệt của phương pháp khử đệ quy có thể khác với phương pháp đệ quy do cấu trúc Stack hoạt động theo cơ chế LIFO. Nghĩa là thêm các đỉnh kề vào thì sẽ lấy ra theo thứ tự ngược lại. Tuy nhiên, nó vẫn tuân theo nguyên lý của DFS là duyệt sâu nhất có thể nên vẫn hợp lệ.
{{< /alert >}}

# 3. Áp dụng

**Bài toán**: *Cho đồ thị `g` và đỉnh gốc `s`. Trả lời câu hỏi, có đường đi nào từ đỉnh gốc `s` tới một đỉnh `w` nào đó không. Nếu có, hãy tìm đường đi đó.*

Chúng ta sẽ dùng thuật toán DFS để duyệt qua các đỉnh. Trong quá trình duyệt đó, lưu lại đỉnh gần nhất tới đỉnh `a` nào đó sử dụng `edgeTo[]`.
Nếu các đỉnh được duyệt qua trong `marked[]`, chứng tỏ có đường đi đến đỉnh đó và có thể truy hồi lại đường đi dùng `edgeTo[]`.

Code tham khảo:

{{< tabbed-codeblock DepthFirstPaths>}}
    <!-- tab java -->
public class DepthFirstPaths {
    private boolean[] marked;
    private int[] edgeTo;
    private int s;
    public DepthFirstPaths(Graph g, int s) {
        marked = new boolean[g.V()];
        edgeTo = new int[g.V()];
        this.s = s;
        dfs(g, s);
    }
    private void dfs(Graph g, int v) {
        marked[v] = true;
        for (Integer i : g.adj(v))
            if (!marked[i]) {
                edgeTo[i] = v;
                dfs(g, i);
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
}
    <!-- endtab -->
{{< /tabbed-codeblock >}}

Cùng thử nghiệm với đồ thị sau đây:

{{< image classes="fancybox center" thumbnail-width="60%" src="/images/post/graph-overview/1.svg" title="Đồ thị 1">}}

Viết hàm `main` để test:

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

    DepthFirstPaths path = new DepthFirstPaths(g, 0);
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
[0, 1, 4, 2]
[0, 3]
[0, 1, 4]
[0, 1, 4, 2, 5]
```

Và đường đi mà thuật toán cho kết quả là:

{{< image classes="fancybox center" thumbnail-width="60%" src="/images/post/graph-dfs-algorithm/1.svg" title="Đường đi cho Đồ thị 1">}}

Có gì đó sai sai đúng không :laughing:

Thật ra DFS là thuật toán tìm kiếm mù và do cách duyệt vét cạn này, nó sẽ bị ảnh hưởng bởi thứ tự thêm cạnh vào đồ thị. Thử đặt dòng `g.addEdge(0, 2);` lên trên dòng `g.addEdge(0, 1);` rồi chạy lại. Bạn sẽ thấy sự khác biệt.

# 4. Đánh giá

Thuật toán sẽ duyệt qua tất cả các đỉnh nếu đồ thị liên thông. Tuy vậy, nó là thuật toán tìm kiếm mù, mang tính chất vét cạn và sẽ kém hiệu quả nếu tập đỉnh quá lớn.

## References

- [Algorithms, 4th Edition by Robert Sedgewick and Kevin Wayne](https://algs4.cs.princeton.edu/home/)


