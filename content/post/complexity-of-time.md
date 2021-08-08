---
title: "Độ phức tạp thời gian của thuật toán"
slug: "complexity-of-time"
date: 2021-07-17T21:33:22+07:00
draft: false
categories:
- programming
tags:
- "algorithms"
keywords:
- "algorithm"
- "java"
- "độ phức tạp"
- "độ phức tạp thời gian"
thumbnailImage: /thumbnails/o-n-2.png
thumbnailImagePosition: left
---

Bàn về độ phức tạp thời gian, mình vẫn thường hay nghe các bạn nói *"Một vòng `for` là $O(N)$, hai vòng `for` lồng nhau là $O(N^2)$"*. Thực ra không hẳn là như thế, nó còn phụ thuộc vào số bước thực hiện mỗi lần lặp. Mình cũng sẽ không bàn về phương pháp khoa học để đánh giá thuật toán mà thay vào đó nói về cách để mường tượng xác định độ phức tạp của thuật toán.

<!--more-->

<p style="text-align:center"><img style="display:inline-block" src="https://media.giphy.com/media/3oEjI5VtIhHvK37WYo/giphy.gif" width="400" /></p>

<!--toc-->

# 1. Chút lý thuyết

Thời gian chạy của chương trình có thể được xác định từ hai yếu tố chính:

- Thời gian thực hiện từng lệnh. Trong đó, những phép toán thường được đánh giá như phép so sánh và phép gán.
- Tần suất thực hiện của các lệnh đó. Thường được đánh giá phụ thuộc độ lớn của dữ liệu.

## 1.1. Big-O Notation

Big-O Notation đại diện cho tỷ suất tăng của một hàm phụ thuộc biến đầu vào. 

Cho một hàm $T(n)$, $T(n)$ có độ phức tạp $f(n)$ nếu tồn tại các hằng số $C$, $k$ sao cho $T(n) \\leq Cf(n)\\ \\forall n \\geq k$. Ký hiệu là $O(f(n))$.

## 1.2. Một số quy tắc

- <b>*Quy tắc cộng*</b>: Nếu chương trình $P$ có hai đoạn chương trình $P_1$ và $P_2$ **nối tiếp nhau**. $P_1$ có độ phức tạp $O(f(n))$, $P_2$ có độ phức tạp $O(g(n))$ thì độ phức tạp của $P$ là $O(max(f(n),g(n)))$.

- <b>*Quy tắc cộng*</b>: Nếu chương trình $P$ có hai đoạn chương trình $P_1$ và $P_2$ **lồng nhau**. $P_1$ có độ phức tạp $O(f(n))$, $P_2$ có độ phức tạp $O(g(n))$ thì độ phức tạp của $P$ là $O(f(n) \\times g(n))$.

- <b>*Một số quy tắc khác*</b>:

    - Lệnh gán, READ, WRITE có độ phức tạp $O(1)$.
    - Độ phức tạp của một chuỗi tuần tự các lệnh được xác định bằng qui tắc cộng. Như vậy độ phức tạp của chuỗi lệnh này chính là độ phức tạp lớn nhất của một đoạn lệnh trong chuỗi lệnh đó.
    - Độ phức tạp của cấu trúc IF là độ phức tạp lớn nhất của đoạn lệnh thực hiện lệnh sau THEN hoặc sau ELSE và thời gian kiểm tra điều kiện. Thường thời gian kiểm tra điều kiện là $O(1)$.
    - Thời gian thực hiện vòng lặp là tổng thời gian tất cả các lần lặp của thân vòng lặp. Nếu thời gian thực hiện thân vòng lặp không đổi thì thời gian thực hiện vòng lặp là tích của số lần lặp với thời gian thực hiện thân vòng lặp.

# 2. Xác định độ phức tạp

Phần này chủ yếu để giúp bạn dự đoán nhanh độ phức tạp phổ biến mà không cần phải sử dụng các phương pháp chứng minh khoa học rườm rà.

{{< image classes="fancybox center" thumbnail-width="60%" src="https://adrianmejia.com/images/time-complexity-examples.png" >}}


## 2.1. Constant

Một chương trình có độ phức tạp hằng số $O(1)$ nếu nó chỉ chạy đúng một số lượng thao tác, cho dù có tăng kích thước đầu vào. Vì vậy, nó không phụ thuộc vào số lượng phần tử đầu vào $N$.

Một ví dụ cụ thể là bảng băm, mỗi thao tác lấy dữ liệu đều tốn một số lượng thao tác như nhau, cho dù có tăng số lượng key trong bảng băm. Những thao tác gán hay phép tính cộng trừ nhân chia đều có độ phức tạp $O(1)$.

## 2.2. Logarithmic

Chương trình có độ phức tạp logarit $O(logN)$ sẽ chậm hơn độ phức tạp hằng số khi tăng kích thước đầu vào. *Trong vòng lặp nếu sau mỗi bước lặp thì thao tác còn lại giảm đi thì các bạn có thể ngầm dự đoán nó có độ phức tạp logarit*.

Binary Search là một thuật toán điển hình, sau mỗi bước lặp, kích thước mảng để xét giảm đi một nửa nên có độ phức tạp $O(log_2 N)$. Nếu thuật toán bạn đang viết giảm đi gấp 3 sau mỗi bước lặp thì có thể xem nó có độ phức tạp $O(log_3 N)$.

Cơ số của hàm $log$ không quan trọng, việc thay đổi cơ số chỉ tương đương với việc nhân với một hằng số. Nên việc giảm đi một nửa hay giảm đi gấp 3 thì cũng xem là $O(log N)$.

## 2.3. Linear

Độ phức tạp tuyến tính $O(N)$ ám chỉ rằng nếu tăng gấp đôi kích thước đầu vào thì thời gian chạy cũng tăng gấp đôi, nghĩa là tăng tuyến tính theo kích thước của $N$. Thông thường sẽ là một vòng `for` duyệt hết $N$ phần tử. 

Nếu chương trình bạn đang viết chỉ duyệt nửa mảng nhưng mà khi $N$ tăng gấp đôi mà số lần lặp cũng tăng gấp đôi thì nó cũng có độ phức tạp $O(N)$ nhé.

## 2.4. Linearithmic

Độ phức tạp $O(NlogN)$ biểu thị thời gian chạy cho kích thước $N$ là $NlogN$. Nghĩa là nhiều hơn $O(N)$ nhưng nhỏ hơn $O(N^2)$.

Chẳng hạn, một chương trình bạn đang viết có 2 vòng `for` lồng nhau. Vòng `for` ngoài duyệt đến $N$, vòng `for` bên trong sau mỗi lần lặp thì giảm đi, thì có thể xem là $O(NlogN)$.

Nhiều thuật toán thuộc nhóm chia để trị cũng có độ phức tạp $O(NlogN)$ như Merge sort hay Quick sort.

## 2.5. Quadratic

$O(N^2)$ biểu thị thời gian chạy là $N^2$ cho dữ liệu kích thước $N$. Thông thường chúng ta viết 2 vòng `for` lồng nhau mà đều duyệt đến $N$ thì có thể coi là $O(N^2)$ như một số thuật toán sort: Bubble sort, Selection sort, ...

Nếu duyệt mảng $N$ phần tử, các thuật toán có độ phức tạp $O(N^2)$ thì thường là phải xét tất cả các cặp dữ liệu trong mảng này.

## 2.6. Cubic

Tương tự $O(N^2)$, thuật toán có độ phức tạp $O(N^3)$ thường được viết như 3 vòng `for` lồng nhau và kiểm tra tất cả các cặp 3 phần tử.

# 3. Kết luận

Trên đây là một số chia sẻ cũng như kinh nghiệm của mình trong việc xác định độ phức tạp thuật toán. Mình cũng sẽ update thêm nếu mình biết thêm cách nhận biết mới. Hi vọng giúp ích được cho các bạn.

# References

- [Algorithms, 4th Edition by Robert Sedgewick and Kevin Wayne](https://algs4.cs.princeton.edu/home/)


