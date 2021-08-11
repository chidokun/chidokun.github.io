---
title: "Cấp phát động trong C/C++"
slug: "cpp-dynamic-allocation"
date: 2015-01-20T01:10:00+07:00
draft: false
categories:
- "Lập trình"
- "Cấu trúc dữ liệu và Giải thuật"
tags:
- "c/c++"
keywords:
- "cấp phát động"
- "c/c++"
thumbnailImage: /thumbnails/heap.png
thumbnailImagePosition: left
---

Bộ nhớ động có lợi hơn bộ nhớ tĩnh rất nhiều, có thể cấp phát thêm hoặc thu hồi lại bộ nhớ. Do đó, bộ nhớ động rất linh hoạt và tiết kiệm hơn so với sử dụng bộ nhớ tĩnh. Một mảng động chứa các phần tử được cấp phát bộ nhớ động, do đó có thể thêm phần tử, xoá phần tử,... nên quản lý bộ nhớ hiệu quả hơn.

<!--more-->

Ngôn ngữ C cung cấp cho chúng ta 4 hàm: `malloc`, `calloc`, `realloc` để cấp phát và `free` để thu hồi. C++ cung cấp 2 toán tử: `new` để cấp phát và `delete` để thu hồi. Do C/C++ không có chế độ thu hồi tự động nên khi ta cấp phát động thì ta phải chủ động thu hồi bộ nhớ động.

Trong C, bốn hàm `malloc`, `calloc`, `realloc` và `free` nằm trong thư viện `stdlib.h` hoặc `alloc.h`, trước khi sử dụng các bạn phải khai báo thư viện này.

# Hàm malloc

*Cú pháp*: 

```cpp
void* malloc(size_t size);
```

*Ý nghĩa*: Cấp phát vùng nhớ động có kích thức `size` byte.

Để đảm bảo cấp phát đủ bộ nhớ cho một mảng, ta thường sử dụng `malloc(n*sizeof(data_type))` với `n` là số phần tử. Toán tử `sizeof(kiểu_dữ_liệu)` trả về kích thước của kiểu dữ liệu (do kích cỡ một kiểu dữ liệu không cố định ở những kiến trúc máy tính khác nhau).

Với một mảng có kiểu dữ liệu xác định nên ta phải ép kiểu để phù hợp với kiểu dữ liệu của mảng.

Hàm `malloc` chỉ cấp phát mà không khởi tạo giá trị ban đầu cho các biến.

Ví dụ code C:

```cpp
//cấp phát mảng động kiểu int với 5 phần tử
int *p = (int*)malloc(5*sizeof(int));

//cấp phát chuỗi động có 11 phần tử
char *str = (char*)malloc(11*sizeof(char));
```

# Hàm calloc

*Cú pháp*:
```cpp
void* calloc(size_t num, size_t size);
```

*Ý nghĩa*: Cấp phát mảng động có `num` phần tử có kích thước `size` byte.

Tương tự hàm malloc, ta cũng cần ép kiểu cho phù hợp với kiểu dữ liệu mảng. Sau khi cấp phát, các phần tử sẽ được gán giá trị 0.

Ví dụ code C:

```cpp
int *p = (int*)calloc(5, sizeof(int));
char *str = (char*)calloc(11, sizeof(char));
```

# Hàm realloc

*Cú pháp*: 

```cpp
void* realloc(void *ptr, size_t size);
```

*Ý nghĩa*: Thay đổi kích thước vùng nhớ được trỏ bởi con trỏ `ptr` với kích thước mới là `size` byte.

Ví dụ:

```cpp
int *p = (int*)malloc(5*sizeof(int));
int *q = (int*)realloc(p, 10*sizeof(int));
```

# Hàm free

*Cú pháp*: 

```cpp
void free(void *p);
```

*Ý nghĩa*: Giải phóng vùng nhớ trỏ bởi con trỏ p.

Phải luôn nhớ giải phóng bộ nhớ động khi không dùng đến nữa.

Ví dụ:

```cpp
int *a = (int*)malloc(512);
free(a);
```

# Toán tử new và detete trong C++

Để cấp phát động một biến có thể dùng như sau:

```cpp
//Cấp phát một chuỗi chưa biết số lượng phần tử
char *str = new char(); 
```

Cấp phát cho một mảng n phần tử có thể dùng như sau:

```cpp
int *a = new int[n];
```

Thu hồi một biến:

```cpp
delete a; //thu hồi vùng nhớ của con trỏ a
```

Thu hồi một mảng:

```cpp
delete []a; //thu hồi mảng a
```