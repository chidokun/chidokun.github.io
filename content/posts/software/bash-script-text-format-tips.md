---
title: "Định dạng màu cho text khi viết Bash script"
slug: "bash-script-text-format-tips"
date: 2020-04-15T22:30:00+07:00
draft: false
categories:
- "Lập trình"
- "Thủ thuật"
tags:
- "tips"
keywords:
- "bash script"
- "shell script"
thumbnailImage: /thumbnails/terminal.png
thumbnailImagePosition: left
---

Với dân developer thì viết script để tự động hóa một số công việc cũng là một việc thường gặp. Mọi người thường nghĩ chỉ có thể hiển thị trên nền trắng đen đơn thuần. Thực ra terminal trên Linux và macOS cũng hỗ trợ hiển thị màu mè hoa lá nữa. Cùng xem cách định dạng chữ và màu để hiển thị trên terminal như thế nào nhé.

<!--more-->

<!--toc-->

{{< image classes="fancybox center" thumbnail-width="90%" src="/images/post/bash-script-text-format/bash-script-1.png" title="Terminal cũng có thể hiển thị màu mè thế này đây" >}}

# 1. Escape sequence

Các trình terminal hỗ trợ màu sắc và định dạng thông qua **Escape sequence**. **Escapse sequence** bắt đầu bằng ký tự Esc và theo sau là mã định dạng: `<Esc>[<Format code>m`.

Trong bash script, ký tự esc có thể viết là `\e`, `\033` hoặc `\x1B`. Vì vậy có thể dùng lệnh sau để hiển thị text có định dạng:

```sh
echo "<Esc>[<Format code>mMy text<Esc>[0m"
```

Sau đây là một số ví dụ:

```sh
echo -e "Hello \033[4;91meverybody\033[0m" # gạch dưới, màu đỏ
echo -e "Hello \e[1;34meverybody\e[0m" # in đậm, màu xanh dương
echo -e "Hello \x1B[42;33meverybody\x1B[0m" # chữ vàng, nền xanh lá
```

Kết quả là:

{{< image classes="fancybox center" thumbnail-width="90%" src="/images/post/bash-script-text-format/bash-script-2.png" >}}


Lệnh `echo -e` cho parse Escapse sequence. Format code `0` sẽ đặt lại tất cả các format trước đó, nên nó thường được để ở cuối để tránh ảnh hưởng đến các lệnh hiển thị phía sau. Escapse sequence cũng có thể sử dụng ở các ngôn ngữ lập trình khác ngoài Bash.

Kế tiếp mình sẽ giới thiệu một số format code hữu ích.

## 1.1. Định dạng

Bảng sau đây là một số format code để định dạng text, chưa bao gồm màu sắc:

|Format code|Mô tả|
|---|---|
|1|Bold/Bright|
|2|Dim|
|4|Underlined|
|5|Blink (nhấp nháy)|
|7|Invert (đảo màu text và màu nền)|
|8|Hidden (thường dùng cho password)|

Cùng xem preview nhé:

```sh
for i in {1,2,4,5,7,8} ; do echo -e "${i}. Hello \e[${i}meverybody\e[0m" ; done ; echo
```

{{< image classes="fancybox center" thumbnail-width="90%" src="/images/post/bash-script-text-format/bash-script-3.gif" >}}


## 1.2. Rest định dạng

Format code để reset định dạng thường dùng để hủy bỏ một định dạng đã set trước đó:

|Format code|Mô tả|
|---|---|
|0|Reset tất cả format|
|21|Reset Bold/Bright|
|22|Reset Dim|
|24|Reset Underlined|
|25|Reset Blink|
|27|Reset Invert|
|28|Reset Hidden|


## 1.3. Kết hợp format code

Nếu bạn muốn đoạn text vừa **in đậm** vừa <u>gạch dưới</u> thì có thể kết hợp các format code lại theo định dạng: `<Esc>[<Format code 1>;<Format code 2>;...;<Format code n>m`

Ví dụ:

```sh
echo -e "Hello \e[1;4meverybody\e[0m" # in đậm, gạch chân
```

{{< image classes="fancybox center" thumbnail-width="90%" src="/images/post/bash-script-text-format/bash-script-4.png" >}}

## 1.4. Tính tương thích

Hầu hết các terminal và terminal emulator hỗ trợ một số hay tất cả các định dạng và màu sắc. Có thể tham khảo tính tương thích của các terminal ở [đây](https://misc.flogisoft.com/bash/tip_colors_and_formatting#terminals_compatibility). 

# 2. Định dạng màu sắc

## 2.1. Màu 8 và 16

Hầu hết các terminal hỗ trợ màu 8 và 16. Lưu ý là các màu này có thể phụ thuộc vào cấu hình profile của terminal.

{{< image classes="fancybox center" thumbnail-width="95%" src="/images/post/bash-script-text-format/bash-script-5.png" title="Một số terminal cho phép thiết lập màu ANSI Color nên các màu 8 và 16 có thể phụ thuộc vào các cài đặt này">}}

Dưới đây là danh sách mã màu text:

|Format code|Mô tả|
|---|---|
|39|Default foreground color|
|30|Black|
|31|Red|
|32|Green|
|33|Yellow|
|34|Blue|
|35|Magenta|
|36|Cyan|
|37|Light gray|
|90|Dark gray|
|91|Light red|
|92|Light green|
|93|Light yellow|
|94|Light blue|
|95|Light magenta|
|96|Light cyan|
|97|White|

Và danh sách mã màu nền:

|Format code|Mô tả|
|---|---|
|49|Default foreground color|
|40|Black|
|41|Red|
|42|Green|
|43|Yellow|
|44|Blue|
|45|Magenta|
|46|Cyan|
|47|Light gray|
|100|Dark gray|
|101|Light red|
|102|Light green|
|103|Light yellow|
|104|Light blue|
|105|Light magenta|
|106|Light cyan|
|107|White|


## 2.2. Màu 88 và 256

Một số terminal có hỗ trợ màu 88 hoặc 256. 

Để sử dụng màu 256 làm màu text, ta sử dụng cú pháp: `<Esc>[38;5;<Format code>m`.

Sử dụng làm màu nền, ta có cú pháp: `<Esc>[48;5;<Format code>m`.

Danh sách các mã màu, các bạn tham khảo tại [đây](https://en.wikipedia.org/wiki/ANSI_escape_code#8-bit).

# 3. Kết luận

Chúng ta vừa điểm qua kha khá những mẹo định dạng text và màu trên terminal. Escapse sequence ngoài sử dụng cho bash script ra còn có thể sử dụng cho các ngôn ngữ lập trình khác nữa. Tuy nhiên, có một nhược điểm là không hiển thị được kiểu chữ nghiêng (italic). Nhưng như thế cũng đủ làm đoạn script của chúng ta thú vị hơn rồi.

## Tham khảo

- [Bash tips: Colors and formatting (ANSI/VT100 Control sequences)](https://misc.flogisoft.com/bash/tip_colors_and_formatting)
- [ANSI escape code](https://en.wikipedia.org/wiki/ANSI_escape_code)