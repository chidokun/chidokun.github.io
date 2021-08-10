---
title: "Cách khởi tạo số ngẫu nhiên trong C/C++"
slug: "prime-number"
date: 2015-01-17T15:07:00+07:00
draft: false
categories:
- "Lập trình"
- "Cấu trúc dữ liệu và Giải thuật"
tags:
- "random"
keywords:
- "số ngẫu nhiên"
- "random number"
thumbnailImage: /thumbnails/heap.png
thumbnailImagePosition: left
---

Khởi tạo số ngẫu nhiên thường được dùng để giảm bớt công đoạn nhập số cho mảng một chiều, ma trận,... Để khởi tạo số ngẫu nhiên ta cần biết đến hàm `srand()` và `rand()` trong `stdlib.h`. Trong C++ 2 hàm này có sẵn trong `iostream`.

<!--more-->

# Hàm srand

Cú pháp: 

```c++
void srand (unsigned int seed);
```

Dùng để khởi tạo một số ngẫu nhiên theo một số `seed`. Số ngẫu nhiên được tạo là pseudo-random, tức là số ngẫu nhiên giả, có thể đoán được số kế tiếp. Mỗi một số `seed` sẽ cho ra một bộ số random khác nhau.

Để cho mỗi số `seed` khác nhau người ta thường dùng kèm với `unsigned int time(NULL)` trong thư viện `time.h`, hàm `time(NULL)` trả về số giây đã trôi qua kể từ ngày 1/1/1970.

Hàm `srand()` thường được gọi trước khi gọi hàm `rand()`.

# Hàm rand

Cú pháp: 

```c++
int rand(void);
```

Trả về một số nguyên random giả trong khoảng từ `0` đến `RAND_MAX`. Hằng `RAND_MAX` được định nghĩa trong `stdlib.h` đảm bảo ít nhất bằng `32767`.

Nếu chỉ dùng hàm `rand()` thì sẽ cho ra những số random giống nhau mỗi lần chạy, vì vậy người ta thường khai báo `srand(time(NULL))` trước để kết quả random mỗi lần mỗi khác nhau.

Để lấy số ngẫu nhiên từ `0` đến `n`, ta sử dụng `rand()%(n+1)`.

Để lấy số ngẫu nhiên từ `a` đến `b`, ta sử dụng `a + rand()%(b-a+1)`.

Ví dụ code C:

```c++
#include<stdio.h>
#include<stdlib.h>
#include<time.h>

int main()
{
   int a, b;
   srand(time(NULL));
   printf("a = %d\n", rand()%100); //Ngẫu nhiên từ 0 đến 99
   printf("b = %d\n", 50+rand()%51); // 50 đến 100
   return 0;
}
```

# Bonus thêm một số hàm hay dùng

Hàm Random từ 0 đến n:

```cpp
int Random(int n)
{
   return rand()%(n+1);
}
```

Hàm Random từ a đến b:

```cpp
int Random(int a, int b)
{
   return a + rand()%(b-a+1);
}
```

Hàm Random số thực từ 0 đến n:

```cpp
float Random(float n)
{
   return n*rand()/RAND_MAX;
}
```

Hàm Random số thực từ a đến b:

```cpp
float Random(float a, float b)
{
   return a + (b - a)*rand()/RAND_MAX;
}
```

Hàm Random cho mảng một chiều:

```cpp
void Random(int *a, int n)
{
   for(int i = 0; i < n; i++)
      a[i] = rand();
}
```