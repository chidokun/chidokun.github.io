---
title: "Hàm xóa một hàng và một cột bất kỳ trong ma trận"
slug: "delete-row-and-col"
date: 2015-03-03T17:27:00+07:00
draft: false
categories:
- "Lập trình"
- "Computer Science"
tags:
- "c#"
keywords:
- "mảng động"
- "mảng hai chiều"
- "cấp phát động"
thumbnailImage: /thumbnails/heap.png
thumbnailImagePosition: left
---

Có thể viết hàm xóa một hàng riêng và xóa một cột riêng và gọi chúng để xóa một hàng và một cột trong ma trận. Tuy nhiên, như vậy sẽ duyệt ma trận đến 2 lần. Để tối ưu hóa, ta có thể thực hiện xóa cùng lúc 1 hàng và một cột bằng cách sau đây.

<!--more-->

Để dễ hiểu có thể xem hình minh họa:

{{< image classes="fancybox center" thumbnail-width="70%" src="/images/post/software/delete-row-and-col/1.png">}}

Giả sử gọi cột cần xóa là iColumn và hàng cần xóa là iRow thì cả 2 sẽ tạo nên 4 vùng. Chỉ có vùng phía trên bên trái giữ nguyên còn các vùng khác di chuyển theo hướng như trên hình. Vùng phía trên bên phải sẽ dịch sang trái 1 cột, vùng phía dưới bên trái sẽ dịch lên 1 hàng và vùng phía dưới bên phải sẽ dịch xéo lên phía trái.

Như vậy ta sẽ minh họa cách làm bằng C/C++ như sau:

```cpp
void DeleteRowColumn(int a[][20], int &m, int &n, int iRow, int iColumn)
{
   for(int i=0;i<m;i++)
      for(int j=0;j<n;j++)
      {
         if(i < iRow && j >= iColumn) //Vùng phía trên bên phải
            a[i][j]=a[i][j+1];
         else if(i >= iRow && j < iColumn) //Vùng phía dưới bên trái
            a[i][j]=a[i+1][j];
         else if(i >= iRow && j >= iColumn) //Vùng phía dưới bên phải
            a[i][j]=a[i+1][j+1];
      }
   m--;
   n--;
}
```