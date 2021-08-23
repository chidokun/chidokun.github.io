---
title: "Vấn đề cấp phát động trong hàm"
slug: "cpp-dynamic-allocation-inside-function"
date: 2015-05-07T23:16:00+07:00
draft: false
categories:
- "Lập trình"
- "Computer Science"
tags:
- "c/c++"
keywords:
- "cấp phát động"
- "c/c++"
thumbnailImage: /thumbnails/heap.png
thumbnailImagePosition: left
---

Ý tưởng của việc này là bạn có 1 con trỏ, bạn muốn cấp phát tài nguyên cho nó thông qua một hàm.

<!--more-->

Ở đây ta có ví dụ:

```cpp
int *a;
```

Ta đã có con trỏ `a`, *làm sao để giữ được giá trị của con trỏ sau khi cấp phát?*

Có thể thấy ta không thể truyền tham trị vào hàm, vì sau khi kết thúc hàm giá trị con trỏ không được lưu giữ.

Có 2 cách giải quyết cho trường hợp này

# Dùng tham chiếu

Ta sẽ truyền một biến tham chiếu của con trỏ vào hàm. Sau khi cấp phát, giá trị con trỏ vẫn được lưu giữ. Lưu ý biến tham chiếu đến con trỏ cấp 1 là `*&a`, con trỏ cấp 2 là `**&a`, tức dấu `&` luôn ở gần tên biến.

Ví dụ:

```cpp
void Alloc(int *&a, int n)
{
   a = new int[n];
}
```

# Dùng con trỏ cấp cao hơn

Trong ví dụ này ta sẽ truyền vào con trỏ cấp 2. Con trỏ cấp 2 trỏ đến con trỏ cấp 1. Vì vậy, nếu bạn muốn có mảng `n` chiều thì có thể truyền vào con trỏ cấp `n+1`.

Ví dụ:

```cpp
void Alloc(int **a, int n)
{
   *a = new int[n];
}
```

Ở đây `*a` là dữ liệu mà con trỏ cấp 2 đang trỏ tới, giá trị của `*a` bị thay đổi vẫn được lưu lại.