---
title: "Biến tham chiếu khác biến con trỏ như thế nào trong C/C++?"
slug: "cpp-reference-variable"
date: 2015-03-20T23:22:00+07:00
draft: false
categories:
- "Lập trình"
- "Computer Science"
tags:
- "c/c++"
keywords:
- "con trỏ"
- "biến tham chiếu"
- "pointer"
thumbnailImage: /thumbnails/heap.png
thumbnailImagePosition: left
---

Cả tham chiếu (reference) và con trỏ (pointer) đều thuộc kiểu địa chỉ trong C++ và thường được dùng để truy cập gián tiếp đến các đối tượng khác. Tuy nhiên chúng cũng có sự khác nhau cơ bản các bạn có thể tham khảo dưới đây.

<!--more-->

**1**. Khai báo biến con trỏ: 

```cpp
<kiểu dữ liệu> *<tên biến>;
```

Khai báo biến tham chiếu: 

```cpp
<kiểu dữ liệu> &<tên biến> = <tên đối tượng>;
```

**2**. Dấu `&` trong khai báo tham chiếu khác với toán tử lấy địa chỉ `&`. Cũng như dấu `*` khai báo con trỏ khác với toán tử lấy giá trị `*`. Chúng chỉ báo hiệu đây là biến tham chiếu hay là biến con trỏ thôi.

**3**. Con trỏ có thể khởi tạo mà không cần gán địa chỉ, ta có một con trỏ không xác định. Tham chiếu bắt buộc phải gán bằng một đối tượng khác, có thể là một biến. Vì vậy dùng con trỏ có thể dễ gây nhầm lẫn và nguy hiểm hơn tham chiếu.

```cpp
int *p; //hợp lệ
int a = 5; //hợp lệ
int &b; //không hợp lệ
int &c = a; //OK, lúc này c và a là một.
```

**4**. Con trỏ là một biến riêng biệt lưu giữ địa chỉ của đối tượng khác nên truy cập gián tiếp thông qua địa chỉ. Tham chiếu được xem như một cái tên khác của đối tượng vì nó dùng chung địa chỉ với đối tượng được tham chiếu.

**5**. Kích thước một biến con trỏ là cố định. Kích thước biến tham chiếu phụ thuộc kiểu dữ liệu của đối tượng.

```cpp
sizeof(double) // 8 bytes
sizeof(double*) // 4 bytes
sizeof(double&) // 8 bytes
```

**6**. Con trỏ có thể được chỉ định để truy cập đến các đối tượng khác nhau bằng cách thay đổi giá trị địa chỉ mà con trỏ lưu giữ. Tuy nhiên, tham chiếu chỉ truy cập được duy nhất một đối tượng đã được khởi tạo cho nó. Vì vậy con trỏ linh hoạt hơn tham chiếu.

**7**. Có thể khai báo mảng các con trỏ nhưng không được khai báo mảng các tham chiếu.

**8**. Tham chiếu thường được dùng làm các tham số truyền vào hàm khi muốn giá trị của tham số thay đổi sau khi ra khỏi hàm.

Tham chiếu cũng được dùng để tiết kiệm bộ nhớ khi truyền đối tượng vào hàm. Hệ thống sẽ tạo biến tham chiếu thay vì tạo bản copy đối tượng. Tuy nhiên, đối tượng có thể bị thay đổi. Có thể dùng hằng tham chiếu để ngăn điều này.

```cpp
int sum(int a); // a sẽ không thay đổi khi ra khỏi hàm
int swap(int &a, int &b); // thay đổi trong hàm vẫn lưu lại với a, b
int addition(const int& a); //a sẽ không thay đổi
```

Tất nhiên cũng có thể dùng con trỏ cho những trường hợp này.

**9**. Con trỏ dùng để cấp phát động nhưng không thể thực hiện việc này với tham chiếu.

**10**. Biến tham chiếu không thể tham chiếu đến con trỏ nhưng con trỏ có thể trỏ đến biến tham chiếu.