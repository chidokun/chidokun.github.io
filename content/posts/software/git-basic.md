---
title: "Các khái niệm cơ bản trong Git"
slug: "git-basic"
date: 2016-10-10T00:10:00+07:00
draft: false
categories:
- "Lập trình"
- "Công cụ"
tags:
- "git"
keywords:
- "git"
thumbnailImage: /images/post/software/git-basic/1.png
thumbnailImagePosition: left
---

Nếu bạn là người mới sử dụng Git để quản lý source code thì chắc chắn có rất nhiều thứ để tìm hiểu, đặc biệt là các thuật ngữ trong Git. Vì vậy trong bài viết này mình sẽ cố gắng giải thích các thuật ngữ cơ bản trong Git một các dễ hiểu nhất để có thể nhanh chóng nắm bắt được hệ thống quản lý source code này.

<!--more-->

{{< image classes="fancybox center" thumbnail-width="70%" src="/images/post/software/git-basic/1.png">}}


# Khái niệm cơ bản

**{{< hl-text green >}}Git{{< /hl-text >}}**: là một trong những Hệ thống Quản lý phiên bản phân tán, vốn được phát triển nhằm quản lý mã nguồn (source code) của Linux. Trên Git, ta có thể lưu trạng thái của file dưới dạng lịch sử cập nhật. Những bạn mới bắt đầu với Git hay bị nhầm lẫn khái niệm Git với GitHub (một server lưu trữ các dự án).

**{{< hl-text green >}}Version Control system{{< /hl-text >}}**: là một hệ thống lưu giữ các phiên bản của mã nguồn của sản phẩm phần mềm, giúp các lập trình viên có thể dễ dàng lấy lại phiên bản mong muốn. Có nhiều version control system khác như CSV, SVN, TeamVS,... Git chính là một trong những hệ thống quản lý phiên bản đó.

**{{< hl-text green >}}GitHub{{< /hl-text >}}**: là một máy chủ để mình có thể lưu source code lên đó. Là cộng đồng nổi tiếng nhất trong thế giới Git. Ở đây có thể tìm được source code đủ thể loại phần mềm. Một số công ty lớn như Microsoft cũng thường mở mã nguồn phần mềm của họ trên đây. Ở đây cũng có thể tìm được cả source code của hệ điều hành Linux và các dự án lớn khác. Nhược điểm của GitHub là chỉ cho phép tạo dự án công khai (người khác có thể vào xem), muốn tạo dự án private phải trả phí cho nó (note: hiện tại GitHub đã cho phép tạo repo private). Ngoài GitHub ra còn có rất nhiều server khác như bitbucket.org, gitlab.com,...

**{{< hl-text green >}}GitLab{{< /hl-text >}}**: cũng là một máy chủ khác để lưu source code. Ra đời sau GitHub và được phát triển dạng mã nguồn mở. Điểm khác biệt của GitLab cho phép tạo các dự án private. Về cơ bản cách sử dụng GitLab và GitHub là hoàn toàn giống nhau, nếu nắm vững Git và đã biết dùng GitHub thì khi chuyển qua GitLab sẽ làm quen một cách nhanh chóng.

**{{< hl-text green >}}Repository (repo){{< /hl-text >}}**: Nghĩa gốc là kho lưu trữ. Hiểu đơn giản, repo là các dự án bạn tạo ra, chứa mã nguồn phần mềm của bạn. Có 2 dạng: Remote repo (là repo chung được lưu trên server), và Local repo (là repo lưu trên máy của người dùng). Ta có thể làm việc và commit trên local reposity ngay cả trong điều kiện offline, khi có mạng chỉ việc đồng bộ lên remote repo để chia sẻ cho người dùng khác.

**{{< hl-text green >}}Commit{{< /hl-text >}}**: là hành động xác nhận sự thay đổi của repo, lưu lại một trạng thái của repo. Khi thực hiện commit, trong repo sẽ tạo ra commit (hoặc revision) ghi lại sự khác biệt của tất cả các file trong repo từ trạng thái đã commit lần trước đó đến trạng thái hiện tại. Bằng việc xem các commit bạn có thể biết được file đã được sửa đổi như thế nào. Khi code một tính năng phải được hoàn thiện cơ bản và chạy được thì mới nên commit.

**{{< hl-text green >}}Branch{{< /hl-text >}}**: là các nhánh phát triển của repo. Ví dụ: bạn muốn thêm một tính năng mới cho phần mềm, bạn có thể tạo một branch khác để phát triển tiếp. Nếu sau này có muốn hủy bỏ tính năng đó thì cũng sẽ được thực hiện một cách dễ dàng mà không ảnh hưởng đến branch chính. Mỗi repo sẽ có một branch chính là master, các thành viên trong nhóm sẽ tạo các branch khác nhau để làm việc. Có nhiều cách chia branch khác nhau tùy mục đích và bạn cần phải học cách chia branch. Mỗi branch giống như một ngữ cảnh khác nhau, branch có thể được chia tách cũng như sát nhập dễ dàng.

**{{< hl-text green >}}Check out{{< /hl-text >}}**: là hành động chuyển sang làm việc trên một branch khác. Trước khi chuyển branch thì bạn phải lưu lại trạng thái của branch hiện tại bằng cách commit.

**{{< hl-text green >}}Push{{< /hl-text >}}**: là hành động upload một commit hoặc branch lên remote repo. Sau khi upload lên thì các thành viên của team có thể thấy và đồng bộ code xuống máy.

**{{< hl-text green >}}Pull{{< /hl-text >}}**: là hành động download các thay đổi xuống local repo. Ví dụ: trong khi bạn đang code trên một file thì một người bạn trong nhóm của bạn cũng code trên một file khác cùng branch, người bạn đó hoàn thành công việc, commit và push lên remote repo. Lúc này bạn muốn lấy những thay đổi mà người bạn của bạn đã thực hiện thì bạn sẽ thực hiện hành động Pull xuống.

**{{< hl-text green >}}Clone{{< /hl-text >}}**: là hành động tạo bản sao của remote repo từ máy chủ về máy mình để có thể lập trình và phát triển. Local repo được clone về cũng có lịch sử thay đổi giống hệt như remote repo. Vì vậy bạn có thể commit lên local repo này.

**{{< hl-text green >}}Merge{{< /hl-text >}}**: là hành động hợp nhất một nhánh phát triển vào nhánh khác hoặc hợp nhất lịch sử thay đổi khi pull hoặc push. Ví dụ trường hợp merge branch: bạn phát triển xong 1 tính năng, đã test/ kiểm thử các kiểu và thấy nó hoàn chỉnh, có thể tích hợp vào phần mềm thì bạn sẽ tiến hành merge code. Sau khi merge có thể giữ lại 1 trong 2 branch hoặc cả 2. Yêu cầu trước khi merge: phải push hết các commit lên branch.

**{{< hl-text green >}}Conflict{{< /hl-text >}}**: là trường hợp có nhiều sự thay đổi trong cùng 1 dòng code khi merge và máy không thể tự quyết định cái nào là đúng. Lúc này bạn phải tự quyết định giữ lại dòng code nào. Công việc xử lý conflict nên được thực hiện bằng GUI thay vì command-line.

**{{< hl-text green >}}Fork{{< /hl-text >}}**: (khái niệm này trên GitHub) là hành động một người dùng khác copy một bản sao của repo về kho của họ. Trước khi tham gia vào một dự án của người khác thì bạn sẽ fork repo của họ và kho của mình nếu như người khác chưa cho phép bạn trở thành thành viên.

**{{< hl-text green >}}Pull request{{< /hl-text >}}** hay **{{< hl-text green >}}Merge request{{< /hl-text >}}**: Khi người dùng khác tham gia phát triển phần mềm và đã phát triển xong một tính năng, họ muốn merge tính năng của họ vào phần mềm của bạn thì lúc này họ sẽ gửi một Pull request/Merge request để bạn chọn chấp nhận hay không.

Trên đây là một số thuật ngữ cơ bản trong Git, để có thể tìm hiểu thêm về các thuật ngữ nâng cao cũng như học cách sử dụng thành thạo Git, bạn có thể xem thêm những tài liệu tham khảo bên dưới.

# Tham khảo

- Hướng dẫn về Git cho người mới bắt đầu - https://backlogtool.com/git-guide/vn/
- Git book - https://git-scm.com/book/vi/v1