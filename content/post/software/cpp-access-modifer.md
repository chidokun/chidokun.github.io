---
title: "Các phạm vi truy xuất trong một lớp đối tượng C++"
slug: "cpp-access-modifer"
date: 2015-07-13T23:43:00+07:00
draft: false
categories:
- "Lập trình"
- "Computer Science"
tags:
- "c/c++"
keywords:
- "phạm vi truy cập"
- "c/c++"
- "hướng đối tượng"
thumbnailImage: /thumbnails/heap.png
thumbnailImagePosition: left
---

Khi xây dựng một class, chắc chắn bạn sẽ phải xác định phạm vi truy cập cho các thuộc tính và phương thức trong class đó. Mục đích của việc này nhằm quy định các thành phần nào có thể được truy cập, thay đổi từ bên ngoài, thành phần nào là riêng tư.

<!--more-->

Có thể hiểu phạm vi truy xuất này cũng giống như biến toàn cục và biến cục bộ. Biến toàn cục có thể được truy cập từ tất cả các hàm sau khai báo nó, còn biến cục bộ chỉ có thể được truy cập nội bộ trong hàm.

Trong C++, phạm vi truy cập được xác định qua 3 từ khóa: `public`, `private` và `protected`.

- `public`: Các thành phần mang thuộc tinh này đều có thể được truy cập từ bất kỳ hàm nào, dù ở trong hay ngoài lớp.
- `private`: Các thành phần mang thuộc tinh này chỉ có thể được truy cập *bên trong phạm vi lớp*. Vì trong C++ cho phép định nghĩa phương thức ngoài khai báo lớp nên phạm vi lớp được hiểu là bên trong khai báo lớp và bên trong các định nghĩa thuộc lớp. 
- `protected`: Các thành phần mang thuộc tinh này chỉ có thể được truy cập bên trong phạm vi lớp và *các lớp con kế thừa nó*. Như vậy, nếu một lớp không có lớp con kế thừa nó thì phạm vi `protected` cũng giống như `private`.

Một ngoại lệ chỉ có trong C++ đó là định nghĩa `friend`. Một hàm hoặc lớp `friend` có thể truy cập vào các thành phần `private` và `protected` của lớp với hàm đó (hàm `friend`) hoặc với các đối tượng khác (lớp `friend`) với điều kiện phải được khai báo trước trong lớp.

Một số lưu ý về phạm vi truy xuất trong C++:

- Phạm vi truy xuất trong C++ được xác định trong qua các nhãn trong khai báo lớp. Nhãn bao gồm từ khóa và dấu hai chấm.
- Mỗi nhãn có phạm vi ảnh hưởng từ lúc khai báo đến khi gặp nhãn khác hoặc hết khai báo lớp.
- Nếu không chỉ rõ nhãn đầu tiên thì ngầm định nó có phạm vi truy cập là private.