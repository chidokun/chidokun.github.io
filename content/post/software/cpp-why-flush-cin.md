---
title: "Tại sao cần xóa bộ đệm bàn phím trước khi nhập chuỗi trong C/C++?"
slug: "cpp-why-flush-cin"
date: 2015-05-09T22:59:00+07:00
draft: false
categories:
- "Lập trình"
- "Computer Science"
tags:
- "c/c++"
keywords:
- "bộ nhớ đệm"
- "c/c++"
- "nhập chuỗi"
thumbnailImage: /thumbnails/heap.png
thumbnailImagePosition: left
---

Thông thường, khi nhập một chuỗi trong màn hình console, ta phải có thao tác xóa bộ nhớ đệm bàn phím. Nếu không có thể thấy rằng kết quả nhập chuỗi bị sai hoặc trôi đi mất.

<!--more-->

Trong quá trình chạy chương trình ta sẽ phải nhập bằng bàn phím, mọi ký tự bạn gõ vào bàn phím (kể cả ký tự Enter `\n`) đều được đẩy vào bộ nhớ đệm trước khi được gán vào biến. Nếu trước đó bạn có nhập số bằng `scanf` hoặc `cin`, chúng chỉ nhận số chứ không nhận được ký tự Enter, và ký tự Enter vẫn còn trong bộ nhớ đệm. Đến khi nhập chuỗi, các hàm nhập chuỗi nhận được ký tự Enter thì dừng nhập luôn và chương trình vẫn chạy tiếp. Điều này khiến kết quả bị sai.

Bạn có thể sử dụng các hàm sau để thực hiện xóa bộ nhớ đệm.

# flushall()

Hàm này được định nghĩa trong `stdio.h`. Nó có tác dụng xóa bộ nhớ đệm tất cả các dòng nhập, xuất chuẩn và nhập xuất file.

# fflush(stdin)

Hàm `fflush()` trong thư viện `stdio.h` cũng có tác dụng tương tự `flushall()`. Tuy nhiên nó cho phép lựa chọn xóa bộ nhớ đệm cho stream nào. Ở đây ta truyền vào `stdin` để xóa bộ đệm cho dòng nhập chuẩn, tức là bàn phím.

# cin.ignore()

Đây là một phương thức của đối tượng cin trong C++. Phương thức này còn có những tham số khác nghĩa là bỏ qua hay loại bỏ một số lượng ký tự trong bộ đệm hoặc bỏ qua đến khi gặp ký tự nào đó. Nếu không có tham số thì mặc định là bỏ 1 ký tự trong bộ đệm. Dùng cách này hữu ích khi nhập dữ liệu chuyển từ số sang chữ.

Vậy nên dùng hàm nào? Hàm nào cũng được, `flushall` và `fflush(stdin)` có vẻ đơn giản hơn trong khi dùng `cin.ignore()` bạn phải cẩn thận, không lạm dụng để tránh sai ý muốn.