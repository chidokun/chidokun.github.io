---
title: "Sleep Sort: Thuật toán sort bá đạo"
slug: "sleep-sort"
date: 2021-07-12T22:52:28+07:00
draft: false
categories:
- "Lập trình"
- "Giải thuật"
tags:
- "java"
- "sorting algorithm"
keywords:
- "sleep sort"
- "sort"
- "java"
thumbnailImage: /thumbnails/sleep-sort.png
thumbnailImagePosition: left
---

Nghe tên có thể bạn nghĩ rằng khi dùng thuật toán này thì chúng ta có thể rung đùi mà ngủ không cần làm gì hết? Bạn có từng nghe qua thuật toán sort nào mà số phép so sánh bằng 0 chưa? Nếu chưa thì *Sleep Sort* là một thuật toán bá đạo như vậy đấy. 

<!--more-->

<!--toc-->

# 1. Giới thiệu

Mấu chốt của thuật toán này là với mỗi giá trị trong mảng sẽ tạo ra một thread và thread đó sẽ sleep một khoảng thời gian bằng đúng giá trị của phần tử trong mảng rồi mới in ra giá trị đó. 

Điều đó nghĩa là, phần tử có giá trị nhỏ nhất sẽ được in trước tiên. Và chúng ta phải chờ đến khi phần tử lớn nhất được in ra, thuật toán kết thúc.

Do đó, thuật toán luôn in ra giá trị mảng đã được sắp xếp từ nhỏ đến lớn.

Tất cả quá trình này được thực hiện bởi hệ điều hành và chúng ta không biết điều gì xảy ra bên dưới.

<p style="text-align:center"><img style="display:inline-block" src="https://media.giphy.com/media/XHqLWPZtKNCN0Np2Gx/source.gif" width="480" /></p>

# 2. Cài đặt ngay thôi

Các bước thực hiện bao gồm:

- Duyệt qua toàn bộ mảng `arr`, với mỗi phần tử `arr[i]`:
    - Tạo một thread với và sleep trong `arr[i]`.
    - Sau khi sleep xong, in phần tử ra màn hình.
- Thuật toán hoàn tất khi tất cả các thread chạy xong.

{{< tabbed-codeblock SleepSort>}}
    <!-- tab java -->
public class SleepSort {
    public void sort(int[] arr) {
        for (int i = 0; i < arr.length; i++)
            sleep(arr[i]);
    }

    private void sleep(int s) {
        new Thread(() -> {
            try {
                Thread.sleep(s);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            System.out.print(s + " ");
        }).start();
    }

    public static void main(String[] args) {
        int[] arr = new int[] { 5, 3, 2, 4, 7, 6, 8, 10 };
        SleepSort s = new SleepSort();
        s.sort(arr);
    }
}
    <!-- endtab -->
{{< /tabbed-codeblock >}}

Kết quả là:

```
2 3 4 5 6 7 8 10 
```

Thời gian chạy của thuật toán phụ thuộc vào phần tử lớn nhất của mảng. Ngoài ra thuật toán cũng bị ảnh hưởng bởi việc định thời của hệ điều hành. Hệ điều hành định thời dựa trên heap-based priority queue thì quá trình tạo thread và thêm tất cả các thread vào queue sẽ tốn $O(NlogN)$. Do đó, có thể xem độ phức tạp của thuật toán là $O(NlogN + max(array))$.

Ngoài ra nó cũng có một số hạn chế như:

- Không chạy được với số âm.
- Không ổn định và nhạy cảm với độ lớn của các phần tử. Đôi khi chỉ sort 2 phần tử `1` và `9999` mà chúng ta phải tốn `10000 ms`.
- Trong trường hợp số lượng phần tử quá lớn, đôi khi một số thread chạy xong trước khi chạy qua xong tất cả các phần tử sẽ dẫn đến kết quả không chính xác.

Nhìn chung, thuật toán này chủ yếu để vui là chính chứ không có quá nhiều ứng dụng trong thực tế.

# References

- [Sleep sort](https://iq.opengenus.org/sleep-sort/)


