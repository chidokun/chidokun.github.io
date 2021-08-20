---
title: "Thuật toán sắp xếp: Interchange Sort (đổi chỗ trực tiếp)"
slug: "interchange-sort"
date: 2015-03-08T23:44:00+07:00
draft: false
categories:
- "Lập trình"
- "Cấu trúc dữ liệu và Giải thuật"
tags:
- "c/c++"
keywords:
- "sắp xếp"
- "đổi chỗ trực tiếp"
- "interchange sort"
thumbnailImage: /thumbnails/heap.png
thumbnailImagePosition: left
---

Để sắp xếp một dãy, có nhiều cách làm khác nhau. Trong bài viết này mình sẽ nói về Interchange Sort, hay còn gọi là thuật toán sắp xếp đổi chỗ trực tiếp.

<!--more-->

# Ý tưởng

Ý tưởng của thuật toán này là bắt cặp tất cả các phần tử trong dãy cần sắp xếp và đổi chỗ hai phần tử trong cặp nếu chúng nghịch thế (không thỏa điều kiện thứ tự).

Để bắt cặp tất cả các phần tử trong dãy, ta dùng 2 vòng lặp. Vòng lặp ngoài sẽ chạy từ đầu dãy đến phần tử kế cuối. Vòng lặp trong sẽ chạy từ phần tử tiếp theo của vị trí đang xét ở vòng lặp ngoài. Mỗi lần xét ta sẽ so sánh 2 phần tử trong cặp. Nếu chúng nghịch thế thì sẽ hoán đổi vị trí của chúng.

Ta thấy sau mỗi lần duyệt ở vòng lặp ngoài ta sẽ được phần tử đầu tiên đứng đúng thứ tự yêu cầu. Cứ thực hiện đến hết dãy ta sẽ được một dãy đã sắp xếp

# Cài đặt

Mã dưới đây được cài đặt theo ngôn ngữ C/C++ với yêu cầu sắp xếp dãy tăng dần.

```cpp
void InterchangeSort(int *a, int n)
{
   for (int i = 0; i < n-1; i++)
      for (int j = i+1; j < n; j++)
         if (a[i] > a[j])
         {
            int temp = a[i];
            a[i] = a[j];
            a[j] = temp;
         }
}
```

# Đánh giá

Số phép so sánh của thuật toán này không đổi, không phụ thuộc tình trạng ban đầu của dãy. Phần tử thứ `i` được so sánh với `n-i` phần tử còn lại nên có thể ước lượng số phép so sánh bằng: $(n-1) + (n-2) + ... + 1 = n(n - 1)/2$.

Tuy nhiên số phép hoán vị (3 phép gán) lại phụ thuộc tình trạng ban đầu. Trong trường hợp tốt nhất, tức dãy đã được sắp xếp hoàn toàn thì không cần phải hoán vị, nên số phép hoán vị là: 0.
Trường hợp xấu nhất, tức dãy có thứ tự ngược với yêu cầu. Mỗi lần so sánh ta lại phải hoán vị nên số phép hoán vị là: $n(n - 1)/2$.

Do vậy độ phức tạp của thuật toán này là: $O(n^2)$.