---
title: "Tìm hiểu lệnh shutdown của Windows 8 và cách tạo shortcut tắt máy"
slug: "tim-hieu-lenh-shutdown-cua-windows-8-va"
date: 2013-11-25T22:29:00+07:00
draft: false
categories:
- "Lập trình"
- "Thủ thuật"
tags:
- "tin học"
- "thủ thuật"
keywords:
- "tin học"
- "thủ thuật"
thumbnailImage: /images/post/other/lenh-shutdown/3.png
thumbnailImagePosition: left
---

Windows 8 ra đời kèm theo nhiều tính năng mới rất hữu ích. Đặc biệt ta có thể thấy Windows 8 hoạt động rất mượt mà, tắt và khởi động máy nhanh hơn hẳn người tiền nhiệm. Có được điều này là do Microsoft đã trang bị cho Windows 8 tính năng "hybrid boot" có thể cải thiện thời gian khởi động nhanh hơn 30-70% so với thời gian khởi động từ chế độ lạnh truyền thống trong Windows 7.
Cùng với đó, lệnh shutdown trong Windows 8 cũng có nhiều thay đổi. Bài viết này đề cập đến các tham số lệnh và cách sử dụng chúng đồng thời hướng dẫn bạn cách tạo shortcut đơn giản để tắt máy.

<!--more-->

# Tính năng "hybrid boot"

Tính năng “hybrid boot” của Windows 8 là chế độ lai giữa Shutdown và Hibernate. Microsoft mô tả quá trình tắt máy của Windows 7 của mình như sau: Người sử dụng sẽ tắt máy bằng cách chọn Shutdown từ Start Menu hoặc bằng cách nhấn nút nguồn hoặc một ứng dụng tắt máy bằng cách kích hoạt lệnh API như ExitWindowsEx hoặc InitiateShutdown. Lúc này, cửa sổ chương trình sẽ phát thông điệp tới các ứng dụng đang chạy, cho phép chúng lưu dữ liệu và các thiết lập. Ứng dụng cũng có thể yêu cầu thêm ít thời gian để hoàn tất những gì mà họ đã làm.

Hybrid boot là sự chấm dứt của việc sử dụng chế độ hibernate trong khởi động cũng như dữ liệu trình điều khiển thiết bị cho lần khởi động tiếp theo. Công nghệ khởi động này làm việc dưới sự hỗ trợ của công nghệ EFI để Windows khởi động nhanh hơn. EFI là sự thay thế cho các BIOS đã được xem lão hóa trên hầu hết máy tính hiện tại, và Windows 8 hỗ trợ đầy đủ công nghệ mới.

# Tìm hiểu lệnh `shutdown`

Để tìm hiểu cú pháp của lệnh này, bạn mở Command Promt dưới quyền Administrator và gõ `shutdown /?` để liệt kê tất cả các tham số lệnh và cách sử dụng.

{{< image classes="fancybox center" thumbnail-width="90%" src="/images/post/other/lenh-shutdown/1.png" title="Cửa sổ Command Promt">}}

Cấu trúc lệnh như sau:

```
shutdown [/i | /l | /s | /r | /g | /a | /p | /h | /e | /o] [/hybrid] [/f] [/m \\computer] [/t xxx] [/d [p|u:]xx:yy [/c "comment"]]
```

Ta chỉ tìm hiểu những tham số quan trọng:

- No arg: Không có tham số. Sẽ hiển thị Trợ giúp
- `/?` : Hiển thị phần trợ giúp
- `/i` : Hiển thị giao diện đồ hoạ người dùng (GUI). Hộp thoại Remote Shutdown Dialog xuất hiện cung cấp cho bạn nhiều tuỳ chọn cao cấp một cách trực quan.

{{< image classes="fancybox center" thumbnail-width="60%" src="/images/post/other/lenh-shutdown/2.png" title="Hộp thoại Remote Shutdown Dialog">}}

- `/l` : Đăng xuất. Không được dùng với `/m` hoặc `/d`
- `/s` : Tắt máy tính
- `/r` : Tắt máy tính và khởi động lại
- `/a` : Bỏ qua lệnh tắt máy
- `/h` : Hibernate (chế độ ngủ đông)
- `/hybrid` : Tính năng này chỉ đi kèm với `/s`. Nó sẽ thực hiện việc tắt máy và khởi động nhanh. Lệnh này tương đương khi bạn bấm nút Shutdown từ Windows
- `/o` : Khởi động lại và vào Menu tuỳ chọn nâng cao trong Boot. Chỉ được sử dụng với `/r`.
- `/t xxx` : Định thời gian tắt máy, xxx là số giây đếm ngược đến thời điểm tắt máy
- `/c "comment"` : Hiển thị thông báo

Nắm rõ những tham số lệnh cơ bản này bạn có thể điều khiển việc tắt mở máy theo ý muốn. Nếu bạn không muốn phải sử dụng giao diện dòng lệnh rắc rối, hộp thoại Remote Shutdown Dialog có thể giúp bạn.

# Sử dụng lệnh `shutdown`

Ta có thể kết hợp các tham số lại để tạo lệnh theo ý muốn.

Ví dụ:

- Để tắt máy sau 5 giây ta gõ: `shutdown /s /t 05`
- Để chuyển sang chế độ ngủ đông sau 10 giây với thông báo "abc" ta gõ: `shutdown /h /t 10 /c "abc"`
- Để tắt máy kèm chế độ khởi động nhanh ngay ta gõ: `shutdown /s /hybrid /t 00`
- Để huỷ bỏ tất cả các lệnh trên nếu chưa quá thời gian ta gõ: `shutdown /a`
- ...

# Tắt máy tính trong Windows 8

Việc tắt máy tính trong Windows 8 khá lằng nhằng, bạn di chuột lên góc trên bên phải để hiện Charm bar, rồi chọn vào Settings. Chọn Power để hiển thị các tuỳ chọn rồi chọn Shutdown.

{{< image classes="fancybox center" thumbnail-width="60%" src="/images/post/other/lenh-shutdown/3.png">}}

# Tạo shortcut tắt máy

Bạn có thể tạo shortcut tắt máy để việc tắt máy trở nên dễ dàng hơn.

Đầu tiên, bấm chuột phải chọn New > Shortcut.

Trong hộp thoại Create Shortcut, bạn gõ lệnh vào theo ý muốn (ở đây là: `shutdown /s /hybrid /t 005 /c "computer will be turned off"`, nghĩa là tắt máy kèm chế độ khởi động nhanh sau 5 giây đồng thời hiện thông báo nhắc nhở) rồi bấm Next.

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/other/lenh-shutdown/4.png">}}

Sau đó đặt tên cho shortcut vừa tạo rồi bấm Finish

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/other/lenh-shutdown/5.png">}}

Đổi icon để shortcut trông đẹp hơn

{{< image classes="fancybox center" thumbnail-width="60%" src="/images/post/other/lenh-shutdown/6.png">}}

Ngoài ra, cũng có thể đính vào Start Screen bằng cách chuột phải vào shortcut chọn Pin to Start và xoá đi shortcut trên Desktop một cách an toàn.

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/other/lenh-shutdown/7.png">}}