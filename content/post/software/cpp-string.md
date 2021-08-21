---
title: "Tổng quan về kiểu string trong C++"
slug: "cpp-string"
date: 2015-03-06T11:48:00+07:00
draft: false
categories:
- "Lập trình"
- "Computer Science"
tags:
- "c/c++"
keywords:
- "chuỗi"
- "string"
thumbnailImage: /thumbnails/heap.png
thumbnailImagePosition: left
---

Khi tao tác với chuỗi trong ngôn ngữ C chúng ta thao tác với `char*` và các hàm thao tác với chuỗi. C++ đã bổ sung kiểu dữ liệu `string` tiện lợi hơn rất nhiều. Bài viết này sẽ tóm tắt những điều cơ bản cần biết về kiểu `string` của C++.

<!--more-->

**1**. `string` là kiểu dữ liệu mới được định nghĩa sẵn trong C++, nó có nhiều ưu điểm vượt trội và giúp tránh được những phiền phức so với chuỗi kiểu `char*` của C.

**2**. Trong C++, bạn vẫn có thể dùng kiểu `char*` nếu muốn. Có thể chuyển từ kiểu `string` sang chuỗi `char*` bằng phương thức `c_str()`.

**3**. Cần khai báo `#include<string>` để có thể sử dụng đầy đủ tiện ích của `string`.

**4**. `string` có các phép `+`, `+=` để nối chuỗi thay vì dùng hàm trong thư viện `string.h` như kiểu `char*`.

**5**. Các hàm trong thư viện `string.h` (`strlen`, `strcmp`, `strlwr`,... ) sẽ không sử dụng được với `string`.

**6**. Có thể so sánh trực tiếp 2 chuỗi `string`: `==`, `!=`, `>`, `>=`, `<`, `<=`. Nguyên tắc so sánh giống hệt như khi dùng hàm `strcmp()`.

**7**. Dùng phương thức `length()` để lấy độ dài chuỗi, dùng phép lấy chỉ số `[]` để lấy từng phần tử của chuỗi.

Ví dụ:

```cpp
string a = "ABCDE";
cout<< a.length();
cout<< a[2];
```

**8**. Dùng phép gán (`=`) để gán trực tiếp biến `string` bằng một chuỗi hoặc một biến `string` khác mà không cần copy.

**9**. Biến kiểu `string` có thể xuất bằng `cout<<` và nhập đến khi gặp khoảng trắng bằng `cin>>`.

**10**. Dùng `getline(cin, <tên biến chuỗi>)` để nhập chuỗi có khoảng trắng.

Ví dụ:

```cpp
string a;
getline(cin, a);
cout << a;
```

**11**. string thực chất là một `vector<char>` có bổ sung thêm một số phương thức và thuộc tính. Do đó, nó có toàn bộ tính chất của một vector.

**12**. Dùng phương thức `substr(<vị trí>, <số ký tự>)` để lấy chuỗi con.

Ví dụ:

```cpp
string a = "ABCDEF";
cout << a.substr(1, 3);
//Kết quả: BCD
```

**13**. Dùng phương thức `insert()` để chèn một chuỗi vào giữa chuỗi khác. Có rất nhiều cách để làm điều này:

```cpp
str.insert(int pos, char * s); //chèn chuỗi kiểu char* vào vị trí pos
str.insert(int pos, string s); //chèn chuỗi s vào vị trí pos
str.insert(int pos, int n, char ch); //chèn n lần ch vào vị trí pos
```

**14**. Dùng phương thức `erase()` để xóa một phần chuỗi.

```cpp
str.erase(int pos, int n); //xóa n ký tự từ vị trí pos
str.erase(int pos); //xóa từ vị trí pos đến cuối chuỗi
```

**15**. Có thể dùng phương thức `compare()` để so sánh 2 chuỗi nếu không muốn dùng các toán tử quan hệ.

```cpp
int compare(const string& str) const;
int compare(const char* s) const;
int compare(size_t pos1, size_t n1, const string& str) const;
int compare(size_t pos1, size_t n1, const char* s) const;
int compare(size_t pos1, size_t n1, const string& str, size_t pos2, size_t n2) const;
int compare(size_t pos1, size_t n1, const char* s, size_t n2) const;
```

**16**. Dùng phương thức `find()` để tìm một chuỗi khác xuất hiện trong chuỗi. Trả về vị trí xuất hiện đầu tiên nếu tìm thấy và `-1` nếu không tìm thấy.

```cpp
str.find(int ch, int pos = 0); //tìm ký tự ch kể từ pos đến cuối
str.find(char *s, int pos = 0); //tìm chuỗi kiểu char* từ pos đến cuối
str.find(string& s, int pos = 0); //tìm chuỗi s kể từ pos đến cuối
```

**17**. Dùng phương thức `replace()` để thay thế một đoạn con trong chuỗi ban đầu.

```cpp
str.replace(int pos, int nchar, char *s);
str.replace(int pos, int nchar, string s);
str.replace(int pos, int nchar, int n, int ch);
```