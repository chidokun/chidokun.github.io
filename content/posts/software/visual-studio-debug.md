---
title: "Hướng dẫn sử dụng tính năng Debug trong Visual Studio"
slug: "visual-studio-debug"
date: 2015-11-09T15:22:00+07:00
draft: false
categories:
- "Lập trình"
- "Thủ thuật"
tags:
- "debug"
- "visual studio"
keywords:
- "debug"
- "visual studio"
thumbnailImage: /thumbnails/heap.png
thumbnailImagePosition: left
---

Debug là một công việc mà hầu hết người lập trình đều phải thực hiện để tìm lỗi trong phần mềm của mình. Visual Studio đã hỗ trợ khá mạnh tính năng này để giúp đơn giản hơn trong việc tìm lỗi sản phẩm. Trong bài viết này mình sẽ hướng dẫn các bạn sử dụng tính năng Debug trên phiên bản mới nhất của Visual Studio, hiện tại là bản 2015. Các thao tác sẽ được thực hiện trên Visual Studio Enterprise 2015.

<!--more-->

# Sơ lược về Debug của Visual Studio

Debug trong Visual Studio cho phép bạn chạy chương trình từng bước để xem sự thay đổi giá trị của biến, trả về của hàm,... qua đó phát hiện những lỗi logic trong chương trình.

Một số thành phần cơ bản

- **Breakpoints**: Là điểm mà chương trình sẽ dừng lại để cho phép bạn chạy từng bước các dòng code. Có thể đặt nhiều breakpoint trong chương trình.

- **Các cửa sổ theo dõi biến**: Giúp bạn theo dõi sự thay đổi của biến hoặc hàm cho mỗi bước chạy. Nếu một biến có sự thay đổi giá trị thì sẽ có màu đỏ để phân biệt. Có 3 loại:

   - *Autos*: Hiển thị tự động các biến, hoặc hàm trả về trong các dòng code trước.
   - *Locals*: Tương tự Autos nhưng chỉ hiển thị các biến liên quan trong nội bộ hàm hoặc khối lệnh.
   - *Watch*: cửa sổ tùy chỉnh cho phép bạn xem chỉ các biến mà bạn yêu cầu hoặc giá trị tùy chỉnh bất kỳ. Visual Studio cho phép bạn mở tối đa 4 cửa sổ Watch.

{{< image classes="fancybox center" thumbnail-width="90%" src="/images/post/software/visual-studio-debug/1.png">}}

- **Thanh công cụ Debug**: cung cấp các nút lệnh để bạn thực hiện Debug chương trình.

{{< image classes="fancybox center" thumbnail-width="100%" src="/images/post/software/visual-studio-debug/2.png">}}

- **Cửa sổ Call Stack**: Chứa lời gọi hàm trong ngăn xếp. Nếu chỉ debug ở mức độ cơ bản thì cũng không cần quan tâm cửa sổ này lắm.

- **Cửa sổ Diagnostic Tool**: Chứa các công cụ chẩn đoán nâng cao. Cung cấp biểu đồ thời gian thực bộ nhớ, CPU,... mà chương trình sử dụng. Ngoài ra nó còn hiển thị các sự kiện được bắt và thời gian bắt.

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/software/visual-studio-debug/3.png">}}

# Thực hiện Debug chương trình

Để bắt đầu thực hiện Debug, ta click vào rìa bên trái tại dòng code cần bắt đầu debug để đặt breakpoint. Breakpoint sẽ có màu đỏ như hình dưới. Lưu ý là có thể đặt nhiều breakpoint khác nhau. Để xóa một breakpoint ta click vào nó một lần nữa.

{{< image classes="fancybox center" thumbnail-width="60%" src="/images/post/software/visual-studio-debug/4.png">}}

Sau khi đặt Breakpoints, ta bắt đầu chạy chương trình dưới chế độ Debug bằng cách nhấn phím F5. Chương trình sẽ chạy bình thường cho tới khi gặp một breakpoint như hình dưới.

{{< image classes="fancybox center" thumbnail-width="60%" src="/images/post/software/visual-studio-debug/5.png">}}

Lúc này bạn sẽ sử dụng các nút lệnh trên thanh công cụ Debug để tiến hành chạy từng bước.

Các nút điều khiển Debug cơ bản:

- *Step Over* (`F10`): chạy lần lượt các câu lệnh, tuy nhiên sẽ không đi vào trong hàm con mà chỉ lướt qua.
- *Step Into* (`F11`):  chạy lần lượt các câu lệnh và đi vào hàm con.
- *Step Out* (`Shift + F11`): Lướt qua hàm con hiện tại để trở về hàm trước. Ngoài ra có thể dùng nó để nhảy qua breakpoint kế tiếp.

# Các thủ thuật nâng cao

## Variable popup

Trong quá trình Debug, bạn có thể di chuột đến bất kỳ biến nào để xem giá trị hoặc thay đổi giá trị của biến. Ngoài ra có thể ghim popup tại màn hình để tiện theo dõi.

{{< image classes="fancybox center" thumbnail-width="70%" src="/images/post/software/visual-studio-debug/6.png">}}

## Disable breakpoint

Nếu bạn có nhiều Breakpoints trong chương trình, muốn tạm không dùng một breakpoint nào đó mà không xóa nó. Bạn có thể disable bằng cách di chuột vào breakpoint đó, một popup hiện ra và chọn Disable breakpoint. Breakpoint bị disable sẽ có màu trắng như trong hình.

{{< image classes="fancybox center" thumbnail-width="60%" src="/images/post/software/visual-studio-debug/7.png">}}

## Debug có điều kiện

Visual Studio hỗ trợ bạn tính năng Debug có điều kiện. Nghĩa là chỉ thực hiện debug tại breakpoint khi thỏa một điều kiện nào đó. Để thực hiện bạn cũng di chuột vào breakpoint cần đặt điều kiện và chọn *Settings* trong popup hiện ra.

{{< image classes="fancybox center" thumbnail-width="90%" src="/images/post/software/visual-studio-debug/8.png">}}

Lúc này bạn tick chọn *Conditions* và gõ vào một điều kiện phù hợp. Có thể thêm điều kiện bằng cách chọn *Add condition*. Lúc này breakpoint đã được đặt điều kiện (sẽ có hình dấu cộng) và sẽ chỉ dừng lại để debug khi thỏa điều kiện đó.

Trên đây là những kiến thức cơ bản khi sử dụng Debug trong Visual Studio 2015. Hi vọng sẽ giúp ích được cho các bạn.
