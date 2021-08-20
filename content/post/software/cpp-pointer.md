---
title: "Những kiến thức căn bản về con trỏ trong C/C++"
slug: "cpp-pointer"
date: 2015-03-05T22:28:00+07:00
draft: false
categories:
- "Lập trình"
- "Cấu trúc dữ liệu và Giải thuật"
tags:
- "c/c++"
keywords:
- "con trỏ"
- "pointer"
thumbnailImage: /thumbnails/heap.png
thumbnailImagePosition: left
---

Con trỏ là một khái niệm hơi khó đối với các bạn mới làm quen với lập trình C/C++. Bài viết này sẽ tóm tắt những điều cơ bản cần biết về con trỏ.

<!--more-->

**1**. Con trỏ khác với biến bình thường ở chỗ nó **lưu giữ địa chỉ của một biến khác** thay vì lưu trữ giá trị (hay còn gọi là trỏ đến biến khác), để dễ hình dung bạn có thể coi con trỏ là một mặt nạ tượng trưng cho biến mà nó trỏ đến.

**2**. Vì nó chỉ lưu giữ địa chỉ thay vì nội dung nên kích thước mọi biến con trỏ trong Windows là **4 bytes**, trong Linux là 2 bytes.

**3**. Cách khai báo: 

```cpp
<kiểu dữ liệu> *<tên biến>
```

Ví dụ:

```cpp
int *p; //p là con trỏ
int* p; //p là con trỏ
int* p, q; //p là con trỏ, q không phải là con trỏ
int *p, *q; //cả p và q là con trỏ
```

**4**. Con trỏ cũng có 1 địa chỉ riêng. Toán tử `*` lấy nội dung tại vùng nhớ mà con trỏ trỏ đến. Toán tử `&` lấy địa chỉ của một biến (kể cả con trỏ).

Với khai báo sau thì: 

```cpp
int *p; 
```

- `p` là con trỏ
- `*p` là giá trị tại vùng nhớ mà `p` trỏ đến
- `&p` là địa chỉ của con trỏ `p`

**5**. Con trỏ trỏ đến địa chỉ của 1 biến: 

```cpp
<tên con trỏ> = &<tên biến>
```

Con trỏ trỏ đến con trỏ khác: 

```cpp
<con trỏ 1> = <con trỏ 2>
```

**6**. Mã đặc tả của con trỏ và địa chỉ là `%p`, dùng để in địa chỉ lên màn hình hoặc định dạng giá trị trong chuỗi.

Ví dụ:

```cpp
int x = 5;
int *p = &x;
printf("%p", &x); //xuất địa chỉ của x
printf("%p", p); //xuất giá trị của con trỏ p, tức là địa chỉ của x
printf("%p", &p); //xuất địa chỉ của con trỏ p
```

**7**. Con trỏ chưa trỏ đến một vùng nhớ (tức vừa được khởi tạo mà chưa được gán địa chỉ)  thì không thể thay đổi giá trị.

**8**. Các phép toán trên con trỏ: `+`, `-`, `++`, `--`, `+=`, `-=` và phép so sánh. Những phép toán tăng giảm này giúp truy xuất hoặc nhảy cóc đến những vùng nhớ kế cận.

**9**. Tính khoảng cách giữa 2 con trỏ bằng: `<con trỏ 1> - <con trỏ 2>`. Kết quả trả về một số nguyên

**10**. Có thể khai báo những con trỏ cấp cao hơn.

Ví dụ:

```cpp
int **p; //con trỏ cấp 2
int ***p; //con trỏ cấp 3
```

**11**. Con trỏ còn có kiểu `void` trong khi biến không có kiểu này.

Con trỏ `void` chưa biết trước kiểu dữ liệu nên có thể trỏ đến bất kỳ biến kiểu nào.

Ví dụ:

```cpp
void *p;
```

**12**. Mảng `n` chiều thì dùng con trỏ `n` cấp.

Ví dụ: mảng 1 chiều thì dùng con trỏ cấp 1, mảng 2 chiều thì dùng con trỏ cấp 2.

**13**. Con trỏ có thể dùng để cấp phát động cho mảng.

Mảng động có thể thêm bớt phần tử nên đỡ tốn dữ liệu hơn mảng tĩnh.

Xem thêm: [Cấp phát động trong C/C++]({{< ref "/post/software/cpp-matrix-allocation" >}})

**14**. Tên mảng 1 chiều là một con trỏ trỏ đến ô đầu tiên trong mảng.

**15**. Có nhiều cách viết để tham chiếu tới các phần tử trong mảng:

```cpp
 a <=> &a[0]
*a <=> a[0]
*(a+i) <=> a[i] <=> i[a]
a+i <=> &a[i] <=> &i[a]
```

**16**. Con trỏ hằng là con trỏ trỏ đến vùng dữ liệu có giá trị hằng nên không thể thay đổi giá trị của hằng. Tuy nhiên có thể thực hiện tăng giảm địa chỉ để trỏ đến nơi khác.

Khai báo: 

```cpp
const int *p;
```

**17**. Hằng con trỏ là con trỏ chỉ trỏ vào 1 ô nhớ nhất định, không thể tăng giảm hay trỏ đi nơi khác.

Khai báo: 

```cpp
int* const p;
```

**18**. Một hàm cũng có địa chỉ. Con trỏ trỏ đến hàm gọi là con trỏ hàm.

Khai báo: 

```cpp
<kiểu trả về> (*<tên con trỏ>)(<các kiểu tham số>);
```

Ví dụ:

```cpp
bool (*p)(int);
int (*q)(int, int);
```

Con trỏ hàm chỉ có thể trỏ đến các hàm có kiểu trả về và các kiểu tham số cũng như số lượng phù hợp.
Cách trỏ đến hàm:

```cpp
<tên con trỏ> = <tên hàm>
<tên con trỏ> = &<tên hàm>
```

Sau khi trỏ có thể thay thế tên hàm bằng tên con trỏ.

Ví dụ:

```cpp
bool IsPositive(int n)
{
   return n > 0;
}

int Max(int a, int b)
{
   return a > b ? a : b;
}

int main()
{
   bool (*p)(int);
   p = Max; //Lỗi, không phù hợp để trỏ
   p = &Max; //Lỗi, không phù hợp để trỏ
   p = IsPositive //OK
   p = &IsPositive //OK
   //Lúc này có thể thay tên hàm bằng tên con trỏ
   //IsPositive(5) <=> p(5)
}
```