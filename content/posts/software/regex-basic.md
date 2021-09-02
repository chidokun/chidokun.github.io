---
title: "Cơ bản về Regex - Biểu thức chính quy"
slug: "regex-basic"
date: 2016-10-21T00:28:00+07:00
draft: false
categories:
- "Lập trình"
- "Công cụ"
tags:
- "git"
keywords:
- "git"
thumbnailImage: /images/post/software/regex-basic/1.png
thumbnailImagePosition: left
---

Regular Expressions (biểu thức chính quy, viết tắt là regexp, regex hay regxp) là một chuỗi mẫu để mô tả một bộ các chuỗi khác, theo những quy tắc cú pháp nhất định. Trong lập trình Regex thường được dùng để kiểm tra sự trùng khớp cũng như tính hợp lệ của một chuỗi, chẳng hạn như kiểm tra tính hợp lệ của email, hay số điện thoại. Nhiều ngôn ngữ lập trình hiện nay như C#, Java, PHP,... đã hỗ trợ biểu thức chính quy trong việc xử lý chuỗi. Vì vậy kiến thức về Regex là không thể thiếu bởi nó sẽ giúp đơn giản hóa công việc lập trình.

<!--more-->

{{< image classes="fancybox center" thumbnail-width="70%" src="/images/post/software/regex-basic/1.png">}}

Bài viết này mình sẽ giới thiệu sơ lược về Regex và cú pháp của nó để các bạn có thể sử dụng và nghiên cứu thêm.

# Làm quen với Regex

Dưới đây là một đoạn regex:

```r
/hello/g
```
Khi so khớp với một chuỗi khác thì có nghĩa là tìm chuỗi hello bất kỳ trong chuỗi được so khớp. Vì vậy chuỗi "hello" sẽ khớp và chuỗi "helloo" cũng khớp luôn.

Vậy nếu muốn chỉ khớp duy nhất với chuỗi "hello" thì ta có đoạn regex:

```r
/^hello$/g
```

Lúc này đoạn regex chỉ khớp duy nhất với chuỗi "hello", các chuỗi khác như "hello hello" cũng sẽ không khớp.

Tiếp tục một đoạn khác:

```r
/[0-9]/g
```

Chuỗi này có nghĩa là khớp với bất kỳ ký tự nào trong khoảng từ ký tự 0 đến ký tự 9. Có nghĩa là "123" sẽ khớp và "123e" cũng sẽ khớp. Nhưng "eeefg" thì không khớp do không nằm troong khoảng đó.

Đến đây bạn đã mường tượng được cách viết regex. Phần tiếp theo chúng ta tiếp tục tìm hiểu cú pháp Regex.

# Cú pháp Regex

Một chuỗi regex thường được gọi là pattern, nghĩa là mẫu, nó sẽ được viết theo cú pháp regex dùng để so khớp với các chuỗi khác. Pattern thường gồm các ký tự được gom chung vào 2 nhóm: *literal character* (ký tự thường, dùng để so khớp) và *meta character* (ký tự đặc biệt, chỉ thị mệnh lệnh).

Trước khi bắt đầu thực hành bạn có thể sử dụng các trang web như [regexr.com](regexr.com) hay [regexpal.com](regexpal.com) để test regex.

Ta cùng tìm hiểu một số ký tự điều khiển đặc biệt trong bảng sau:

|Ký tự|Mô tả/Giải nghĩa|
|---|---|
|`/`|Bắt đầu hoặc kết thúc chuỗi regex|
|`\`|Bắt đầu ký tự có chức năng đặc biệt hoặc biến meta character thành literal character.<br />Ví dụ: `\n` là xuống hàng, `\\` khớp với "\"|
|`\|`|Chỉ định lựa chọn khớp với 1 hoặc nhiều từ. Tương đương phép OR|
|`()`|Xác định chuỗi bên trong như 1 đơn thể. Ví dụ: `a(b|c)c` khớp với "abc" và "acc"|
|`{}`|Xác định số lượng. Ví dụ: `a{3}` khớp với "aaa"|
|`[]`|Xác định các ký tự đơn sẽ khớp hoặc không.|
|`.`|Khớp bất kỳ ký tự đơn nào trừ ký tự xuống dòng.|
|`^`|Chỉ các ký tự bắt đầu chuỗi.|
|`$`|Chỉ các ký tự kết thúc chuỗi.|
|`*`|Tương đương với số lượng ký tự theo sau bất kỳ ({0,}).<br />Ví dụ: `zo*` khớp với "z", "zo", "zoooooo"|
|`+`|Khớp ít nhất 1 chuỗi đằng trước và số lượng ký tự theo sau bất kỳ ({1,}).<br />Ví dụ: `zo+` khớp với "zo", "zoooooo" nhưng không khớp với "z"|
|`?`|Khớp một phần hoặc toàn bộ chuỗi đằng trước ({0,1}).<br />Ví dụ: `zo?` khớp với "z", "zo" nhưng không khớp với "zoooooo".|

## Bắt đầu và kết thúc chuỗi

Một pattern sẽ bắt đầu bằng dấu `/` và kết thúc cũng bằng dấu `/`. Đằng sau cặp dấu này là 3 ký tự flag: `i` (không phân biệt hoa thường), `g` (so khớp lặp lại với các ký tự khác trong toàn bộ văn bản), `m` (cho phép khớp theo từng dòng đối với văn bản đa dòng và có sử dụng cặp `^$`).

Dấu bắt đầu `^` chỉ các ký tự văn bản bắt đầu và dấu `$` chỉ các ký tự kết thúc.

Ví dụ:

- `^abc` sẽ khớp với chuỗi "abc", "abcdef" (nghĩa là bắt đầu bằng "abc").
- `abc$` sẽ khớp với chuỗi "abc", "defabc" (nghĩa là kết thúc bằng "abc").
- `^abc$` chỉ khớp với duy nhất chuỗi "abc".

Trở lại với các ký tự flag, sự khác nhau của chúng được mô tả trong các ví dụ sau:

- `/abc/i` Khớp chuỗi "ABC", "abc", Khớp với "ABC" trong chuỗi "ABCabc"
- `/abc/g` Khớp chuỗi "abc", khớp với bất kỳ chuỗi "abc" nào trong văn bản, khi không có g thì chỉ khớp chuỗi đầu tiên
- `/^abc$/m` Khớp chuỗi "abc", "abc\nabc\nabc"

## Biểu thức nhóm `[]`

Cặp dấu `[abc]` so khớp với bất kỳ ký tự đơn nào trong cặp dấu này. Ví dụ: `/[abc]/` sẽ khớp với "a" và "b" trong "absent".

Cặp `[^abc]` sẽ khớp với các ký tự đơn không nằm trong cặp dấu này. Ví dụ: `/[^abc]/` sẽ khớp với "s", "e", "n", "t" trong "absent".

Cặp `[a-z]` sẽ khớp với các ký tự đơn trong khoảng chỉ định, ở đây là "a" đến "z". Ví dụ: /[a-zA-Z][0-9]/ sẽ khớp với "a1", "E4", "o9".

## Chỉ định số lượng {}

Cặp dấu `{}` đặt sau một đơn thể dùng để chỉ định số lượng đơn thể theo sau nó.

Cụ thể hơn:

- Cặp dấu `{n}` sẽ khớp với đơn thể lặp lại chính xác `n` lần với `n` là số không âm. Ví dụ: `a{3}` sẽ khớp với "aaa". `[0-9]{11}` sẽ khớp với "01254321456".
- Cặp dấu `{n,}` sẽ khớp với đơn thể lặp lại từ n lần trở lên. Ví dụ: `a{2,}` sẽ khớp với "aa" và "aaaaa" nhưng không khớp với "a".
- Cặp dấu `{a,b}` sẽ khớp với đơn thể lặp lại từ a đến b lần. Ví dụ: `a{2,3}` khớp với "aa" và "aaa" nhưng không khớp với "a" và "aaaa".

## Các ký tự đặc biệt

Các ký tự đặc biệt thông dụng khác được mô tả trong bảng sau:

|Ký tự|Mô tả|
|---|---|
|`\b`|Khớp với chuỗi nằm ở biên.<br />Ví dụ: `er\b` khớp với "never" và "error" nhưng không khớp với "verb"|
|`\B`|Khớp với chuỗi không nằm ở biên.<br />Ví dụ: `er\B` khớp với "verb" và không khớp với "error" và "never"|
|`\d`|Khớp với chữ số. Tương đương [0-9]|
|`\D`|Khớp với ký tự không phải số. Tương đương [^0-9]|
|`\w`|Khớp với chữ, số và dấu gạch dưới "_". Tương đương [a-zA-Z0-9_]|
|`\W`|Khớp với ký tự không phải chữ, số và dấu gạch dưới "_". Tương đương [^a-zA-Z0-9_]|
|`\cX`|Khớp với CTRL+X với X thuộc [a-zA-Z]|
|`\xNN`|Khớp với ký tự được biểu diễn bởi đúng 2 chữ số hexa.<br />Ví dụ: `\x41` khớp với "A"|
|`\uXXXX`|Khớp với ký tự Unicode được biểu diễn bởi 4 chữ số hexa.<br />Ví dụ: `\u00A9` khớp với "©"|

Đến đây bạn có thể tự viết được các biểu thức regex đơn giản rồi. =))

# Tham khảo

- Regular expression - https://en.wikipedia.org/wiki/Regular_expression
- Regular Expression Language - Quick Reference - https://msdn.microsoft.com/en-us/library/az24scfc(v=vs.110).aspx
- Creating a Regular Expression - https://msdn.microsoft.com/en-us/library/dd997379(v=vs.100).aspx
- Regular Expression Syntax - https://msdn.microsoft.com/en-us/library/ae5bf541(v=vs.100).aspx