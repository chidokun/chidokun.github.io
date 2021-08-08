---
title: "Truy vấn với JavaScript (Phần 2)"
slug: query-with-javascript-ep2
date: 2019-12-24T18:00:00+07:00
categories:
- programming
keywords:
- js
- javascript
- query
- truy vấn
- dữ liệu
tags:
- javascript
- programming
- tips
comments: true
draft: false
thumbnailImage: https://upload.wikimedia.org/wikipedia/commons/thumb/6/6a/JavaScript-logo.png/240px-JavaScript-logo.png
thumbnailImagePosition: left
---

Ở phần 1, mình đã giới thiệu một số cách dùng JavaScript để truy vấn thống kê trên 1 tập dữ liệu. Tiếp tục phần này, mình sẽ giới thiệu thêm một số cách dùng JavaScript để giải quyết một số vấn đề thường gặp liên quan đến mối quan hệ giữa nhiều tập dữ liệu nhé.

<!--more-->

<!--toc-->

Lần này, chúng ta sử dụng các tập dữ liệu mã số sinh viên sau:

{{< codeblock js>}}
let data1 = [
	"160706400000502",
	"160922005010007",
	"160830020001505",
	"170920002006001",
	"160824003001503",
	"160925005004023",
	"160824700001510",
	"170929000806002",
	"160927900006001",
	"160823000701002"
];

let data2 = [
	"170413006008003",
	"170914000806002",
	"170922020006001",
	"160922005010007",
	"160927900006001",
	"160823000701002",
	"160825900002003",
	"170815700006009",
	"160925005004023",
	"170413000029003"
];

let data3 = [
	"160927900006001",
	"160823000701002",
	"160830020001505",
	"170920002006001",
	"160824700001510",
	"170929000806002",
	"160824003001503",
	"160925005004023"	
]

let data4 = [
	"181005009007138", 
	"181005070009679", 
	"181005070009681", 
	"181023900003987", 
	"181107500003264"
]
{{< /codeblock >}}

Mục tiêu là tìm ra mối liên hệ giữa các tập dữ liệu. Trong thực tế có thể bạn sẽ gặp những tình huống mà cần phải tìm ra mối liên hệ của những tập dữ liệu hàng trăm, hàng nghìn dòng thì JavaScript vẫn đáp ứng được.

Trước hết cùng nhận xét "nhẹ" về tập dữ liệu nhé:

- Mã số sinh viên ở dạng số có cùng format là 15 chữ số. Nhìn 2 chữ số đầu có thể bạn sẽ đoán được đây là năm khai khóa chẳng hạn.
- Số lượng mẫu:

```js
data1.length
// 10
data2.length
// 10
data3.length
// 8
data4.length
// 5
```

# 1. Tìm giao của 2 danh sách

Mục đích là tìm các phần tử thuộc về cả 2 danh sách. Ở đây, chúng ta có thể dùng `filter()` để lọc ra các phần tử của danh sách 1 mà có tồn tại trong danh sách 2. JavaScript cung cấp phương thức `indexOf()` để tìm vị trí xuất hiện của một phần tử. Phương thức `indexOf()` sẽ trả về index của phần tử trong mảng hoặc `-1` nếu không tìm thấy. 

Vì vậy, chúng ta có thể `filter()` lại danh sách 1 với điều kiện là `indexOf()` khác `-1`.

```js
// Tìm giao của data1 và data2
let data12 = data1.filter((e) => data2.indexOf(e) != -1);
// Result: ["160922005010007","160925005004023","160927900006001","160823000701002"]

// Tìm giao của data2 và data3
let data23 = data2.filter((e) => data3.indexOf(e) != -1);
// Result: ["160927900006001","160823000701002","160925005004023"]

// Tìm giao của data2 và data4
let data24 = data2.filter((e) => data4.indexOf(e) != -1);
// Result: []

// bạn tiếp tục với các tập còn lại nhé
```

Qua lượt kiểm tra như trên, chúng ta thấy được `data1` và `data2` có trùng nhau (được lưu bằng `data12`), tập `data2` và `data3` cũng vậy (`data23`). Tập `data4` không có liên hệ với các tập trên. Liệu `data12` và `data23` có giao nhau không?

```js
let data123 = data12.filter((e) => data23.indexOf(e) != -1);
// Result: ["160925005004023","160927900006001","160823000701002"]
```

# 2. Tìm phần bù

Mục tiêu chính là tìm ra những phần tử của tập dữ liệu 1 mà không nằm trong tập dữ liệu 2. Cách dùng cũng tương tự như trên, vẫn dùng `filter()` kết hợp với `indexOf()`. Tuy nhiên, điều kiện là `indexOf()` bằng `-1`.

Cách dùng này ngoài để tìm phần bù ra, có thể dùng để xác định 1 tập có nằm hoàn toàn trong tập khác bằng cách kiểm tra xem phần bù có rỗng hay không.

Ở ví dụ trên, để biết tập `data23` có là tập con của `data12` hay không? Chúng ta kiểm tra thử:

```js
data23.filter((e) => data12.indexOf(e) == -1);
// Result: [] chứng tỏ tập `data23` nằm hoàn toàn trong `data12`
```

Thêm một ví dụ khác:

```js
// Tìm phần bù của data3 với data2
let _data32 = data3.filter((e) => data2.indexOf(e) == -1);
// Result: ["160830020001505","170920002006001","160824700001510","170929000806002","160824003001503"]
```

{{< alert info >}}
Bạn có thể dùng `filter()` kết hợp với `indexOf()` để tìm các phần tử trùng nhau cũng như phần bù giữa 2 tập.
{{< /alert >}}

# 3. Kết luận

Phía trên mình đã giới thiệu cách tìm giao và phần bù chỉ bằng cách sử dụng `filter()` và `indexOf()`. Sau khi phân tích xong, có thể kết luận mối quan hệ giữa các tập như sau:

{{< image classes="fancybox center" src="/images/post/query-with-javascript-ep2-1.png" title="Mối liên hệ giữa các tập dữ liệu" >}}

Hi vọng bài viết sẽ giúp ích cho các bạn. Nếu biết thêm về các thủ thuật khác thì có thể chia sẻ với mình thông qua bình luận bên dưới nhé.



