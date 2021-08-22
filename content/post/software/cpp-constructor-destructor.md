---
title: "Khi nào cần định nghĩa constructor, copy constructor và destructor trong C++?"
slug: "cpp-constructor-destructor"
date: 2015-04-15T13:12:00+07:00
draft: false
categories:
- "Lập trình"
- "Computer Science"
tags:
- "c/c++"
keywords:
- "constructor"
- "desctructor"
- "copy constructor"
- "c/c++"
- "hàm dựng"
- "hàm hủy"
- "hàm khởi tạo"
thumbnailImage: /thumbnails/heap.png
thumbnailImagePosition: left
---

Hàm dựng (constructor) và hàm hủy (destructor) là 2 yếu tố quan trọng luôn có trong một lớp (class) trong lập trình hướng đối tượng. Nếu người dùng không định nghĩa thì trình biên dịch sẽ tự động thêm vào hàm dựng và hàm hủy mặc định. Tuy nhiên, đôi khi chúng ta cần phải định nghĩa lại hàm dựng và hàm hủy để đảm bảo an toàn và hợp logic hơn.

<!--more-->

# Hàm dựng (constructor)

*Hàm dựng* là hàm được tự động gọi khi đối tượng được tạo lập. Có 3 loại: mặc định (không tham số), có tham số và hàm dựng sao chép (copy constructor).

*{{< hl-text primary >}}Trong hầu hết các trường hợp, bạn nên định nghĩa hàm dựng để khởi tạo giá trị ban đầu cho các biến thành viên.{{< /hl-text >}}*

Nếu khai báo đối tượng mà không cung cấp đối số thì hàm dựng mặc định sẽ được gọi, nếu có đối số thì hàm dựng có tham số sẽ được gọi. Vì vậy, hàm dựng có tham số thường được dùng để khởi động đối tượng với giá trị tùy người dùng thay vì giá trị được định nghĩa trong hàm dựng mặc định. Ngoài ra, còn được dùng để chuyển kiểu ngầm định khi gọi với toán tử.

*Hàm dựng sao chép* dùng để tạo nên đối tượng mới giống hệt đối tượng cũ và thường được dùng trong phép gán. Tất nhiên trình biên dịch sẽ tự thêm copy constructor mặc định khi không khai báo. Nguyên tắc của copy constructor là copy giá trị theo từng cặp biến thành viên.

Vấn đề chỉ xuất hiện khi lớp có thành viên là con trỏ và có cấp phát tài nguyên động như mảng. Trong trường hợp này, nếu không định nghĩa lại copy constructor thì mặc định chỉ sao chép giá trị của các biến thành viên mà không sao chép mảng động. Cụ thể hơn, với biến thành viên là con trỏ, giá trị (tức địa chỉ của mảng động) sẽ được bê nguyên xi qua con trỏ của đối tượng kia và hiển nhiên 2 con trỏ đang trỏ đến cùng một vùng nhớ. Khi hủy 2 đối tượng thì vùng nhớ sẽ bị thu hồi 2 lần và điều này gây ra lỗi. Hơn nữa, việc 2 đối tượng khác nhau cùng dùng chung vùng nhớ cũng sẽ không hợp logic. Vậy, bạn nên định nghĩa lại copy constructor khi lớp có thành viên là con trỏ và có cấp phát tài nguyên động.

*Nguyên tắc định nghĩa lại*:

1. Gán các biến thành viên tĩnh cho nhau.
2. Cấp phát lại vùng nhớ động cho con trỏ.
3. Sao chép lại mảng động.


Ví dụ: Cho lớp `DSSinhVien` có 2 thành viên là `num` (số thành viên) và một con trỏ kiểu `SinhVien`.

```cpp
class DSSinhVien
{
private:
   SinhVien *list;
   int num;
public:
   //các phương thức
};
```

Có thể viết lại copy constructor theo nguyên tắc trên như sau:

```cpp
DSSinhVien::DSSinhVien(const DSSinhVien& dssv)
{
   this->num = dssv.num; //gán thành viên tĩnh cho nhau
   this->list = new SinhVien[num]; //cấp phát lại cho con trỏ
   for(int i = 0; i < num; i++)
      list[i] = dssv.list[i]; //sao chép lại mảng động
}
```

# Hàm hủy (destructor)

*Hàm hủy* được gọi trước khi đối tượng được thu hồi, tác dụng chính của nó dùng để dọn dẹp và thu hồi tài nguyên động đã cấp phát. Đối với lớp chỉ có các biến thành viên tĩnh, ta không thể thu hồi lại bằng tay được nên không cần định nghĩa destructor.

Trong ngôn ngữ C/C++, tài nguyên động sẽ không được tự động giải phóng. Điều này sẽ gây lỗi rò rỉ bộ nhớ (memory leak) nếu cấp phát quá nhiều. Vì thế, ta cần định nghĩa destructor để giải phóng vùng nhớ đã cấp phát nếu trong lớp có thành viên con trỏ và có cấp phát tài nguyên động.

Với ví dụ trên ta có thể định nghĩa hàm hủy như sau:

```cpp
DSSinhVien::~DSSinhVien()
{
   if (list != NULL)
      delete []list;
}
```