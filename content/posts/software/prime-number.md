---
title: "Các vấn đề cơ bản về số nguyên tố trong lập trình"
slug: "prime-number"
date: 2015-01-12T23:13:00+07:00
draft: false
categories:
- "Lập trình"
- "Computer Science"
tags:
- "prime"
- "c/c++"
keywords:
- "số nguyên tố"
- "eratosthenes"
thumbnailImage: /thumbnails/heap.png
thumbnailImagePosition: left
---

Số nguyên tố là số chỉ có 2 ước, đó là 1 và chính nó, tức là nó chỉ chia hết cho số 1 và chính nó. Số 1 và 0 không được coi là số nguyên tố. Các bài toán cơ bản về số nguyên tố gồm kiểm tra một số nguyên n có phải là số nguyên tố và tìm các số nguyên tố nhỏ hơn hoặc bằng một số nguyên cho trước.

<!--more-->

# Kiểm tra một số nguyên có là số nguyên tố

*Ý tưởng*: Kiểm tra xem số n có chia hết cho từng số nhỏ hơn nó hay không. Nếu có thì không là số nguyên tố, nếu tất cả đều không có thì là số nguyên tố.

*Cài đặt bằng C*: Nếu số n là 1 hoặc 0 thì không là số nguyên tố. Dùng một vòng for chạy từ 2 đến n-1 để kiểm tra xem n có chia hết cho bất kỳ số nào trong đó không, nếu có thỉ không là số nguyên tố, nếu tất cả đều không thì là số nguyên tố. Trong một hàm nếu gặp lệnh `return`, hàm sẽ trả về giá trị và kết thúc hàm nên có thể viết gọn như sau:

```c++
int IsPrime(int n)
{
   if (n < 2) return 0;
   for(int i = 2; i < n; i++)
      if(n%i==0) return 0; 
   return 1; 
}
```

Tuy nhiên có thể nhận thấy việc kiểm tra đến n-1 là không cần thiết. Vì nếu n có các ước thì các ước của nó chắc chắn không vượt qua căn bậc 2 của n. Như vậy điều kiện trong vòng for sẽ được đổi thành `i <= sqrt(n)`, nhưng để gọi hàm `sqrt()` cần phải khai báo thư viện `math.h`, ép kiểu n sang kiểu thực,... khá rườm rà nên ta có thể đổi thành `i*i <= n` để tiện hơn.

Ta có hàm kiểm tra số nguyên tố đơn giản như sau.

```c++
int IsPrime(int n)
{
   if (n < 2) return 0;
   for(int i = 2; i*i <= n; i++)
      if(n%i==0) return 0; 
   return 1;
}
```

Một chương trình kiểm tra số nguyên tố sẽ có dạng tương tự như sau:

```c++
#include<stdio.h>
#include<conio.h>

//Hàm kiểm tra số nguyên tố
int IsPrime(int n) 
{
   if (n < 2) return 0;
   for(int i = 2; i*i <= n; i++)
      if(n%i==0) return 0; 
   return 1;
}

int main()
{
   int n;
   printf("Nhập số n: ");
   scanf("%d", &n);
   if(IsPrime(n))
      printf("%d là số nguyên tố.\n",n);
   else
      printf("%d không là số nguyên tố.\n",n);
   return 0;
   getch();
}
```

# Tìm các số nguyên tố nhỏ hơn hoặc bằng số n cho trước

*Ý tưởng*: Ta đã có hàm kiểm tra số nguyên tố nên ta sẽ xét mọi số nhỏ hơn n, nếu là số nguyên tố thì in ra màn hình.

*Cài đặt bằng C*: Dùng vòng for xét từ 2 đến n, kiểm tra xem nó có phải là số nguyên tố không, nếu có thì in ra màn hình. ta có hàm như sau:

```c++
void OutPrime(int n)
{
   for(int i = 2; i <= n; i++)
      if(IsPrime(i))
         printf("%d\t", i);
}
```

Có thể thấy mỗi số đều phải gọi hàm `IsPrime()` kiểm tra nên khối lượng công việc máy phải làm ngày càng lớn ở những số lớn hơn vì vậy thời gian tính toán sẽ lâu hơn. Để cải thiện điều này, có thể dùng thuật toán *sàng Eratosthenes*.

*Ý tưởng của thuật toán sàng Eratosthenes*: Giả sử tất cả đều là số nguyên tố, xét từ 2, loại tất cả các bội số của 2, xét lên 3, loại tất cả các bội số của 3, cứ thế xét đến căn bậc 2 của n. Kết thúc quá trình các số chưa bị loại là số nguyên tố.

Cài đặt bằng C: Tạo một mảng nguyên dùng để đánh dấu các vị trí không phải là số nguyên tố. Ban đầu đánh dấu tất cả đều là số nguyên tố. Duyệt mảng từ 2 đến căn bậc 2 của n, nếu phần tử đang được duyệt là số nguyên tố thì đánh dấu tất cả bội số của nó về giá trị không là số nguyên tố. Sau khi thực hiện xong ta được một mảng đã được đánh dấu và chỉ việc in ra những số được đánh dấu là số nguyên tố.

Code C:

```c++
void OutPrime(int n)
{
   //Ta quy định: 0: là số nguyên tố, 1: không là số nguyên tố
   int a[1000] = {0}; //Tạo mảng và gán tất cả bằng 0
   for(int i = 2; i*i <= n;i++)
      if(!a[i]) //Nếu là số nguyên tố
         //Duyệt các phần tử là bội số của i
         for(int j = i*i; j <= n; j+=i)
            a[j]=1; //Đánh dấu các phần tử là bội số.
   //In các phần tử là số nguyên tố ra màn hình
   for (int i=2;i<=n;i++)
      if(!a[i]) printf("%d ",i); 
}
```
