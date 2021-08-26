---
title: "Hướng dẫn làm menu đơn giản trong màn hình Console"
slug: "simple-console-menu"
date: 2015-03-19T11:53:00+07:00
draft: false
categories:
- "Lập trình"
- "Thực hành"
tags:
- "c/c++"
keywords:
- "console"
- "menu"
- "c/c++"
thumbnailImage: /thumbnails/heap.png
thumbnailImagePosition: left
---

Đúng như tiêu đề, menu này rất đơn giản cho phép người dùng lựa chọn tính năng của chương trình trong màn hình Console và có thể áp dụng vào những game cơ bản. Bạn chỉ cần có kiến thức về vòng lặp `do...while`, cấu trúc điều kiện `switch..case` để làm menu này. Cách làm sẽ được minh họa bằng C++.

<!--more-->

{{< image classes="fancybox center" thumbnail-width="70%" src="/images/post/software/simple-console-menu/1.png" title="Menu đơn giản trên console">}}

Đầu tiên, để menu hiện ra cho bạn lựa chọn khi chạy chương trình hoặc khi chạy hết một tính năng, ta sẽ sử dụng vòng lặp `do...while`, tất nhiên cũng phải có lựa chọn thoát chương trình nên dùng một biến kiểu `bool` làm điều kiện thoát vòng lặp (trong C bạn có thể dùng biến kiểu int cũng được).

```cpp
bool isExit = false; //thiết lập ban đầu là không thoát
do
{

} while (!isExit);
```

Cần phải in ra màn hình để hướng dẫn người dùng biết, đồng thời cũng phải có một biến lưu lại sự lựa chọn của người dùng.

```cpp
bool isExit = false;
int option; //biến lưu lại lựa chọn người dùng
do
{
   cout <<"Please select:" <<endl
        <<"1. Input students" <<endl
        <<"2. Output students" <<endl
        <<"3. Sort and output students" <<endl
        <<"4. Exit" <<endl
        <<"----------------------------"<<endl
        <<"Your choice: ";
   cin >> option; //lưu lựa chọn người dùng

} while (!isExit);
```

Tiếp theo là xử lý yêu cầu của người dùng. Để làm việc này ta dùng cấu trúc `switch..case` để rẽ nhánh thực hiện các lệnh phù hợp. Lệnh `switch..case` này vẫn nằm trong vòng lặp `do..while`. Trong ví dụ này, với lựa chọn 4, ta gán biến `isExit` thành `true` để thoát khỏi vòng lặp `do..while` cũng như thoát chương trình.

```cpp
switch (option)
{
case 1:
   //lệnh
   break;
case 2:
   //lệnh
   break;
case 3:
   //lệnh
   break;
case 4:
   isExit = true;
   break;
default:
   cout << "Your choice is not valid!" << endl;
}
```

Công việc cuối cùng là hoàn tất các lệnh xử lý cho mỗi trường hợp trong menu thôi. Rất đơn giản phải không nào!