---
title: "Những công cụ giúp làm việc hiệu quả hơn trên Terminal"
slug: "console-progress-bar"
date: 2021-12-12T15:20:21+07:00
draft: false
categories:
- "Lập trình"
- "Thủ thuật"
tags:
- "tips"
keywords:
- "terminal"
- "console"
- "zsh"
thumbnailImage: /thumbnails/terminal.png
thumbnailImagePosition: left
---

Với những công việc cần thao tác nhiều với dòng lệnh, một Terminal nhiều màu sắc và hỗ trợ nhiều thao tác sẽ có ích hơn là một Terminal nhàm chán với nền đen và chữ trắng. Vì vậy, thông thường mình sẽ cài nhiều plugins đễ hộ trợ cho công việc. Dưới đây là một số plugins của ZSH mà mình dùng để giúp việc làm việc với Terminal dễ dàng hơn. 

<!--more-->

{{< toc >}}

Để sử dụng các plugins bên dưới chúng ta cần cài:

- **ZSH**: Trình shell dựa trên Bourne Shell với rất nhiều tính năng, hỗ trợ plugin và theme.
- **Oh My ZSH**: Là một plugin framework của ZSH giúp quản lý và load các plugin/theme tốt hơn.

# 1. Auto suggestion: Tự nhắc lệnh

Với các lệnh đã từng gõ trước đó, plugin này sẽ tự động đề xuất các lệnh phù hợp. 

Sau khi gõ một vài ký tự. Plugin sẽ nhắc các gợi ý. Chọn `→` để fill lệnh hoặc `↑` hay `↓` để xem lệnh phù hợp khác.

Xem hướng dẫn cài đặt tại [đây](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md).

<script id="asciicast-37390" src="https://asciinema.org/a/37390.js" async></script>

# 2. Syntax Highlighter: Định dạng cú pháp lệnh

Plugins này giúp tự động highlight lệnh chính và các tham số, dấu ngoặc giúp dễ nhìn hơn.

Xem hướng dẫn cài đặt tại [đây](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md).

Sau khi cài đặt xong phải kích hoạt highlighter cho các tham số, dấu ngoặc vì mặc định chỉ highlight lệnh chính. Chúng ta sẽ thêm vào `.zshrc` như sau:

```sh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
```

# 3. Powerlevel10k: ZSH Theme dễ dùng và đầy đủ tiện ích

Mặc định, ZSH đã hỗ trợ rất nhiều theme. Để dễ dàng cấu hình cũng như hiệu chỉnh theme, mình sử dụng `Powerlevel10k` thay vì các theme khác.

Xem hướng dẫn cài đặt tại [đây](https://github.com/romkatv/powerlevel10k#oh-my-zsh).

Sau khi cài đặt xong có thể thiết lập theme bằng cách chạy lệnh:

```sh
p10k configure
```

{{< image classes="fancybox center" thumbnail-width="100%" src="https://raw.githubusercontent.com/romkatv/powerlevel10k-media/master/configuration-wizard.gif" title="Cấu hình Powerlevel10k">}}

Một số ưu điểm:

- Rất nhiều tùy chỉnh bằng wizard giúp hiệu chỉnh giao diện theo ý muốn.
- Hỗ trợ nhiều segment khác nhau và dễ dàng thêm hoặc bỏ bớt. Trong đó mình thấy có một vài segment hữu ích như:
    - `time`: Hiển thị thời gian
    - `command_execution_time`: Thời gian thực thi lệnh kể từ lệnh cuối.
    - `battery`: Hiển thị mức pin.
    - `load`: CPU load

{{< image classes="fancybox center" thumbnail-width="100%" src="https://raw.githubusercontent.com/romkatv/powerlevel10k-media/master/extravagant-style.png" title="Các segment của Powerlevel10k">}}

# Tham khảo

- [ZSH Auto Suggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [ZSH Syntax Highlighter](https://github.com/zsh-users/zsh-syntax-highlighting)
- [Powerlevel 10k ZSH Theme](https://github.com/romkatv/powerlevel10k)

