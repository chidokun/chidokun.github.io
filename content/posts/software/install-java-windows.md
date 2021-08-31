---
title: "Cài đặt và thiết lập Java trên Windows"
slug: "install-java-windows"
date: 2016-09-19T23:20:00+07:00
draft: false
categories:
- "Lập trình"
- "Thủ thuật"
tags:
- "java"
keywords:
- "java"
thumbnailImage: /images/post/software/install-java-windows/1.png
thumbnailImagePosition: left
---

Để cài đặt Java dành cho phát triển ứng dụng, bạn cần cài đặt JDK (Java Development Kit). Bộ JDK gồm các công cụ hữu ích để phát triển các ứng dụng được viết trên nền tảng Java.

<!--more-->

{{< image classes="fancybox center" thumbnail-width="60%" src="/images/post/software/install-java-windows/1.png" >}}

# Cài đặt Java Development Kit

Download JDK theo link sau:

[<p style="text-align:center">http://www.oracle.com/technetwork/java/javase/downloads/index.html</p>](http://www.oracle.com/technetwork/java/javase/downloads/index.html)

Chọn **Java Platform (JDK) 8u101 / 8u102** (bản Java mới nhất hiện tại là Java 8).

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/software/install-java-windows/2.png" >}}

Chọn hệ điều hành phù hợp (Windows x64 nếu đang chạy Windows 64-bit, Windows x86 nếu đang chạy Windows 32-bit). Nhớ chọn **Accept License Agreement** trước khi download.

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/software/install-java-windows/3.png" >}}

Sau khi download về, các bạn chạy file thực thi.

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/software/install-java-windows/4.png" >}}

Chọn thư mục cài đặt JDK, có thể để mặc định hoặc thay đổi tùy ý bằng cách bấm **Change...** Ở đây mình chọn *D:\Java\JDK*.

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/software/install-java-windows/5.png" >}}

Chờ giây lát để JDK cài đặt.

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/software/install-java-windows/6.png" >}}

Tiếp theo, trình cài đặt sẽ yêu cầu chọn nơi cài đặt JRE (Java Runtime Environment), có thể để mặc định hoặc bấm **Change...** để thay đổi. Ở đây mình chọn *D:\Java\JRE*. Sau đó nhấn **Next** để tiếp tục.

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/software/install-java-windows/7.png" >}}

Chờ giây lát để JRE được cài đặt.

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/software/install-java-windows/8.png" >}}

Cài đặt hoàn tất, chọn Close để kết thúc.

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/software/install-java-windows/9.png" >}}

# Thiết lập biến môi trường cho Java

Mục đích nhằm để thao tác với Java trên command-line mà không cần dùng tới các IDE.

Đầu tiên ta cần mở *System Properties*, có thể mở cửa sổ này theo nhiều cách khác nhau. Trên Windows 10 ta có thể thực hiện đơn giản bằng cách mở Start menu, gõ "`environment`" và chọn kết quả được hiển thị.

{{< image classes="fancybox center" thumbnail-width="50%" src="/images/post/software/install-java-windows/10.png" >}}

Chọn **Environment Variables...** để mở cửa sổ *Environment Variables*.

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/software/install-java-windows/11.png" >}}

Ta cần thêm vào *System variables* các biến sau:

- `JAVA_HOME`: đường dẫn đến nơi cài đặt IDK.
- `Path`: Giúp tìm kiếm các lệnh mà người dùng gọi.

Chọn **New...** và điền vào các giá trị như sau:

- *Variable name*: JAVA_HOME
- *Variable value*: đường dẫn đến thư mục cài đặt JDK lúc nãy. Ở đây là D:\Java\JDK

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/software/install-java-windows/12.png" >}}

Tiếp tục, cũng trong mục *System variable*, ta chọn biến `Path` và bấm **Edit...**.

Chọn **New** rồi gõ vào `%JAVA_HOME%\bin`.

{{< image classes="fancybox center" thumbnail-width="60%" src="/images/post/software/install-java-windows/13.png" >}}

Chọn OK để xác nhận.

Để kiểm tra lại Java, ta vào cmd và gõ lệnh: `java -version`

Kiểm tra lại javac, ta gõ lệnh: `javac -version`

{{< image classes="fancybox center" thumbnail-width="90%" src="/images/post/software/install-java-windows/14.png" >}}

