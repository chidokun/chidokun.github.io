---
title: "Thuật toán sắp xếp: Selection Sort (chọn trực tiếp)"
slug: "selection-sort"
date: 2015-03-16T23:36:00+07:00
draft: false
categories:
- "Lập trình"
- "Giải thuật"
tags:
- "c/c++"
- "sorting algorithm"
keywords:
- "sắp xếp"
- "sắp xếp chọn"
- "selection sort"
- "giải thuật"
thumbnailImage: /thumbnails/heap.png
thumbnailImagePosition: left
---

Selection Sort là một thuật toán sắp xếp tương đối dễ hiểu. Ý tưởng chính vẫn là đổi chỗ những cặp nghịch thế, tuy nhiên cái hay là ở chỗ Selection Sort tìm vị trí chứa phần tử nhỏ nhất để đổi chỗ với phần tử đang xét chứ không đổi tất cả các cặp nghịch thế như [Bubble Sort]({{< ref "/post/software/bubble-sort" >}}) hay [Interchange Sort]({{< ref "/post/software/interchange-sort" >}}).

<!--more-->

# Ý tưởng

Xét phần tử đầu tiên của dãy. Tìm phần tử nhỏ nhất trong các phần tử còn lại. Hoán đổi phần tử đầu tiên với phần tử nhỏ nhất này, ta được phần tử đầu tiên có vị trí đúng. Bỏ qua phần tử vừa được xét, tiếp tục xét đến phần tử kế tiếp và thực hiện đến hết dãy.

# Cài đặt trong C++

```cpp
int min, i, j; //min là chỉ số phần tử nhỏ nhất
for(i = 0; i < n-1; i++)
{
   min = i;
   for(j = i+1; j < n; j++)
      if(a[j] < a[min])
         min = j; //tìm min trong các phần tử còn lại
   if(min != i)
     swap(a[i], a[min]); //đổi chỗ nếu tìm thấy min
}
```

# Minh họa

Nguồn: Wikipedia.

{{< image classes="fancybox center" thumbnail-width="20%" src="http://upload.wikimedia.org/wikipedia/commons/9/94/Selection-Sort-Animation.gif" title="Minh họa Selection Sort" >}}

# Đánh giá

Về số phép so sánh, ở lượt xét thứ `i` luôn có `n-i` phép so sánh để tìm min và không phụ thuộc tình trạng ban đầu của dãy nên số phép so sánh ước lượng là: $(n-1) + (n-2) + ... + 1 = n(n - 1)/2$.

Số lần hoán vị ở trường hợp tốt nhất là $0$.
Trường hợp xấu nhất là: $3n(n-1)/2$.

Độ phức tạp là: $O(n^2)$.