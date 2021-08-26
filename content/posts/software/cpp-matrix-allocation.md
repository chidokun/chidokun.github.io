---
title: "Cấp phát động cho mảng hai chiều trong C++"
slug: "cpp-matrix-allocation"
date: 2015-01-27T15:18:00+07:00
draft: false
categories:
- "Lập trình"
- "Computer Science"
tags:
- "c/c++"
keywords:
- "mảng động"
- "mảng hai chiều"
- "cấp phát động"
thumbnailImage: /thumbnails/heap.png
thumbnailImagePosition: left
---

Mảng 2 chiều khá quen thuộc với chúng ta. Mình sẽ giới thiệu một vài cách cấp phát động mảng 2 chiều để các bạn lựa chọn cho phù hợp. Ở đây mình minh họa bằng C++, đối với các ngôn ngữ khác thì ý tưởng cũng tương tự vậy thôi. Lưu ý là C++ sẽ không tự động thu hồi tài nguyên động đã cấp phát cho dù có thoát khỏi chương trình, vì thế bắt buộc phải có thao tác giải phóng mảng 2 chiều.

<!--more-->

# Cách 1: Dùng con trỏ cấp 2

*Ý tưởng*: Để cấp phát động cho mảng 2 chiều, ta cấp phát bộ nhớ của từng chiều theo cú pháp của mảng một chiều. Tức là tạo m [mảng 1 chiều]({{< ref "/posts/software/cpp-dynamic-allocation" >}}), mỗi mảng có n phần tử.

Để làm điều này ta dùng 1 con trỏ cấp 2, cấp phát cho nó m con trỏ cấp 1, mỗi con trỏ cấp 1 ta lại cấp phát n phần tử.

Ví dụ:

```cpp
int **a = new int*[m];
for(int i = 0; i<m; i++)
   a[i] = new int[n];
```

Với ví dụ trên, ta được một mảng động hai chiều các số nguyên có kích thước m x n.

Lưu ý là ta dùng một con trỏ cấp 2 cấp phát cho một mảng các phần tử có kiểu `int*` chứ không phải kiểu `int` thông thường. Kiểu `int*` chính là con trỏ cấp 1.

Để giải phóng bộ nhớ động, ta cũng phải giải phóng theo từng cột và từng hàng.

Ví dụ:

```cpp
for(int i = 0; i<m; i++)
   delete []a[i];
delete []a;
```

Cách này phức tạp nhưng bạn sẽ có 1 mảng 2 chiều đúng nghĩa và có thể lấy phần tử bằng cách gọi `a[i][j]` thông thường như mảng tĩnh.

# Cách 2: Dùng mảng 1 chiều để biểu diễn mảng 2 chiều

*Ý tưởng*: Cấp phát mảng 1 chiều có kích thước m x n và truy cập nó như một mảng 2 chiều với các chỉ số thông qua công thức liên hệ.

Phần tử `a[i][j]` tương ứng với phần tử `a[i*n + j]` trong mảng.

Ví dụ:

```cpp
int *a = new int[m*n]; //cấp phát xong
//khởi tạo bằng 0
for(int i = 0; i < m; i++)
   for(int j = 0; j < n; j++)
      a[i*n+j] = 0;
```

Việc giải phóng vô cùng đơn giản, chỉ cần 1 lệnh `delete`.

```cpp
delete []a;
```

Với cách này bạn sẽ phải truy cập mảng 2 chiều thông qua công thức liên hệ, tuy nhiên, cách này sẽ hữu ích với những trường hợp như cộng 2 ma trận cùng loại, v.v...