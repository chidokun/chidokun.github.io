---
title: "Đo trực tiếp thời gian chạy của thuật toán trong C/C++"
slug: "cpp-measure-execution-time"
date: 2015-03-21T01:38:00+07:00
draft: false
categories:
- "Lập trình"
- "Computer Science"
tags:
- "c/c++"
keywords:
- "đo thời gian chạy"
- "c/c++"
- "pointer"
thumbnailImage: /thumbnails/heap.png
thumbnailImagePosition: left
---

Đo thời gian chạy là một trong những cách để đánh giá hiệu quả của một thuật toán. Công việc nghe có vẻ khó khăn nhưng thực tế, với các hàm, kiểu dữ liệu được định nghĩa trong thư viện `time.h` của C (trong C++ có thể dùng cả `time.h` hoặc `ctime`), ta có thể đo thời gian chạy của một đoạn chương trình bất kỳ một cách dễ dàng.

<!--more-->

Trước hết cần tìm hiểu những thành phần cần thiết:

- `clock_t`: là một kiểu dữ liệu được dùng để đếm clock tick. Clock tick là đơn vị thời gian đặc biệt có mối quan hệ với hằng số `CLOCKS_PER_SEC` (thông thường là 1/1000 giây).
- `clock()`: là một hàm trả về thời gian xử lý của chương trình. Kiểu dữ liệu trả về là `clock_t`
- `CLOCKS_PER_SEC`: là một hằng số macro đại diện cho số clock tick mỗi giây (thường là 1000).

Vậy để đo thời gian chạy của một đoạn chương trình, ta dùng các biến `clock_t` ghi lại thời gian thực hiện rồi chia cho hằng số `CLOCKS_PER_SEC` để ra được số giây thực hiện.

Có thể xem ví dụ mẫu sau:

```cpp
int main()
{
   clock_t begin = clock(); //ghi lại thời gian đầu

   //Đoạn chương trình cần đo

   clock_t end = clock(); //ghi lại thời gian lúc sau
   cout<<"Time run: "<<(float)(end-begin)/CLOCKS_PER_SEC<<" s"<<endl;
   return 0;
}
```