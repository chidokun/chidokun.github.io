---
title: "Làm quen với MessageBox trong C#"
slug: "csharp-message-box"
date: 2015-03-03T20:27:00+07:00
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

Chắc hẳn MessageBox đã quá quen thuộc với chúng ta khi sử dụng hệ điều hành Windows. Ngôn ngữ C# và nền tảng .NET Framework đã hỗ trợ rất nhiều trong việc sử dụng *MessageBox*. Bài viết này sẽ hướng dẫn các bạn làm quen với *MessageBox* trong Windows Form.

<!--more-->

`MessageBox` là một lớp (class) nằm trong `System.Windows.Forms` có một phương thức `Show()` để hiển thị thông báo. Có rất nhiều kiểu thông báo, bạn có thể điều chỉnh nội dung thông báo, tiêu đề, các nút OK-Cancel, biểu tượng, v.v...

```csharp
MessageBox.Show("Xin chào! Tôi là C#");
```

Đây là kiểu thông báo đơn giản nhất, chỉ có nội dung và nút OK, chưa bao gồm biểu tượng, tiêu đề, v.v..

{{< image classes="fancybox center" thumbnail-width="90%" src="/images/post/software/csharp-message-box/1.png">}}

Để có tiêu đề ta thêm 1 tham số chuỗi truyền vào phương thức như sau:

```csharp
MessageBox.Show("Xin chào! Tôi là C#","Thông báo");
```

{{< image classes="fancybox center" thumbnail-width="30%" src="/images/post/software/csharp-message-box/2.png">}}

Để cài đặt nút bấm, ta cũng thêm 1 tham số kiểu enum là `MessageBoxButtons.<loại nút>`. Các loại nút có sẵn bao gồm `AbortRetryIgnore`, `OK`, `OKCancel`, `RetryCancel`, `YesNo`, `YesNoCancel`. Ví dụ:

```csharp
MessageBox.Show("Xin chào! Tôi là C#", "Thông báo", 
                                MessageBoxButtons.AbortRetryIgnore);
```

{{< image classes="fancybox center" thumbnail-width="50%" src="/images/post/software/csharp-message-box/3.png">}}

Để xử lý các sự kiện khi nhấn vào các nút này mình sẽ hướng dẫn bên dưới.

Để thêm vào icon ta thêm tham số kiểu enum là `MessageBoxIcon.<loại icon>`, có nhiều loại nhưng phổ biến là `Warning` (tam giác vàng có dấu chấm than), `Error` (hình tròn đỏ có chữ X), `Information` (hình tròn xanh lam có chữ i), `Question` (hình tròn lam có dấu chấm hỏi). Ví dụ:

```csharp
MessageBox.Show("Xin chào! Tôi là C#", "Thông báo", 
               MessageBoxButtons.OKCancel, MessageBoxIcon.Question);
```

{{< image classes="fancybox center" thumbnail-width="40%" src="/images/post/software/csharp-message-box/4.png">}}

Còn rất nhiều tùy chọn khác các bạn có thể tự khám phá. Còn bây giờ mình sẽ hướng dẫn các bạn xử lý sự kiện khi click vào một button trên `MessageBox`.

Giả sử bạn có một `Form`, và bạn muốn khi người dùng nhấp vào nút Close trên thanh tiêu đề thì sẽ có thông báo hỏi người dùng có muốn thoát chương trình. Nếu người dùng chọn Yes, chương trình sẽ kết thúc, chọn No sẽ không tắt chương trình.

Ta xử lý sự kiện `FormClosing`, tức là một Form đang đóng lại (nháy vào nút X hoặc lệnh `this.Close()`,...).

Bạn sẽ dùng một biến kiểu `DialogResult` để lưu lại kết quả trả về của phương thức `MessageBox.Show()`

```csharp
DialogResult dlr = MessageBox.Show("Bạn muốn thoát chương trình?",
      "Thông báo", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
```

Đến lúc này ta chỉ cần xét giá trị của biến `dlr` để rẽ nhánh thôi. Vì `Form` đang đóng nên nếu người dùng nhấn No thì sẽ hoãn hành động đóng lại, tham số sự kiện của FormClosing là e nên ta thực hiện như sau:

```csharp
DialogResult dlr = MessageBox.Show("Bạn muốn thoát chương trình?",
     "Thông báo", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
if (dlr == DialogResult.No) e.Cancel = true;
```

{{< image classes="fancybox center" thumbnail-width="90%" src="/images/post/software/csharp-message-box/5.png">}}

Với những giới thiệu sơ lược, các bạn đã có thể nắm được cách sử dụng cơ bản về MessageBox trong Windows Form.