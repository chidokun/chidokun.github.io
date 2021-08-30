---
title: "Biểu diễn dữ liệu sử dụng Biểu đồ Tròn (Pie Chart)"
slug: "pie-chart-and-how-to-use"
date: 2020-01-31T22:00:00+07:00
draft: false
categories:
- "Dữ liệu"
- "Visualization"
tags:
- "data visualization"
- "data analysis"
- "data science"
keywords:
- "biểu diễn dữ liệu"
- "dữ liệu"
- "data visualization"
- "biểu đồ tròn"
- "cách sử dụng"
- "pie chart"
thumbnailImage: /thumbnails/pie-chart.png
thumbnailImagePosition: left
---

Biểu đồ tròn (Pie Chart) rất hay được dùng để biểu diễn/trực quan hóa dữ liệu trong những báo cáo/bảng biểu trong trong Phân tích dữ liệu cũng như một số ngành nghề khác, giúp cho người đọc dễ dàng hiểu dữ liệu hơn. Tuy nhiên, các dạng Pie Chart nếu sử dụng không khéo sẽ khiến cho biểu đồ trở nên mơ hồ và không diễn đạt được hết ý nghĩa của dữ liệu. Mình xin giới thiệu một số lưu ý để dùng Pie chart một cách trực quan hơn.

<!--more-->

{{< toc >}}

# 1. Pie Chart

Pie Chart được sử dụng để biểu diễn tỉ lệ phần trăm của các thành phần so với tổng thể. Vì vậy, nó không được dùng để biểu diễn giá trị chính xác.

Dưới đây là một ví dụ về *Tỉ lệ dân số thế giới theo lục địa giữa năm 2018* ([nguồn](https://www.statista.com/statistics/262881/global-population-by-continent/)):

{{< image classes="fancybox center" src="/images/post/pie-chart-and-how-to-use/pie-chart-1.png" title="Tỉ lệ dân số thế giới theo lục địa giữa năm 2018" >}}

# 2. Một số lưu ý khi dùng Pie chart

- **Đảm bảo tổng các thành phần là 100%**: Với các công cụ hỗ trợ thì không cần lo lắng về lỗi này vì các công cụ đã đảm bảo được sự chính xác của số liệu khi biểu diễn. Nếu vẽ Pie chart thủ công thì chúng ta cần kiểm tra lại tính đúng đắn một lần nữa.

- **Chỉ dùng Pie chart khi số lượng thể loại ít hơn 6**: Trừ khi bạn có 1 thể loại trội hơn cả và muốn tập trung vào thể loại này. Việc sử dụng Pie Chart khi có quá nhiều thể loại sẽ khiến cho biểu đồ khá rối. Nếu có quá nhiều thể loại, bạn nên xem xét một biểu đồ khác như **Column Chart**.

{{< image classes="fancybox center" src="/images/post/pie-chart-and-how-to-use/pie-chart-3.png" title="Nếu có nhiều thể loại, xem xét Column Chart" >}}

- **Không dùng Pie Chart nếu tỉ lệ giữa các thể loại gần tương đương nhau**: Nếu tỉ lệ giữa các thể loại là tương đương nhau thì dường như Pie Chart lúc này là vô dụng vì không thể hiện cụ thể một ý nghĩa gì. Con người có thể nhận ra dễ dàng sự khác biệt về chiều dài, nhưng có đánh giá được các góc hay diện tích. Có thể sử dụng label để chỉ rõ giá trị phần trăm nhưng đây không hẳn là giải pháp. Giải pháp lúc này là xem xét một dạng biểu đồ khác như **Column Chart** hoặc **Bar Chart**.

{{< image classes="fancybox center" src="/images/post/pie-chart-and-how-to-use/pie-chart-2.png" title="Nếu có nhiều thể loại có giá trị gần tương đương nhau, xem xét Column Chart hoặc Bar Chart" >}}

- **Nên sắp xếp giá trị các thể loại để dễ hiểu hơn**: Sắp xếp lại dữ liệu giúp cho người xem nhận ra ngay thể loại có tỉ lệ cao nhất. Đồng thời với 2 thể loại gần như tương đương thì biết được thể loại nào có giá trị lớn hơn. Thông thường, giá trị trong Pie Chart được sắp xếp từ lớn đến nhỏ theo chiều kim đồng hồ như ví dụ bên dưới.

{{< image classes="fancybox center" src="/images/post/pie-chart-and-how-to-use/pie-chart-5.png" title="Sắp xếp lại dữ liệu giúp Pie Chart dễ hiểu hơn" >}}

- **Tránh sử dụng dạng 3D hoặc nghiêng**: Các biểu đồ dạng 3D hoặc nghiêng có thể làm tăng tính thẩm mỹ nhưng không thể tăng "mức độ dễ hiểu" cho biểu đồ của chúng ta. Các dạng 3D hoặc nghiêng làm biến đổi các góc và diện tích càng khiến cho chúng ta khó hiểu biểu đồ hơn.

{{< image classes="fancybox center" src="/images/post/pie-chart-and-how-to-use/pie-chart-6.png" title="Nếu không có mục đích khác, nên hạn chế dùng những hiệu ứng như hình trên" >}}


# 3. Các dạng khác của Pie chart

## 3.1. Donut Chart

Dạng này không khác gì Pie Chart ngoại trừ phần rỗng bên trong. Biểu diễn dữ liệu bằng **Donut Chart** có vẻ sẽ thẩm mỹ và lạ mắt hơn. Những ưu điểm hay hạn chế của **Donut Chart** cũng giống như Pie Chart.

{{< image classes="fancybox center" src="/images/post/pie-chart-and-how-to-use/pie-chart-7.png" title="Donut Chart" >}}

## 3.2. Stacked Donut Chart

Là một biến thể của Donut Chart, **Stacked Donut Chart** lồng nhiều Donut Chart vào nhau để biểu diễn sự thay đổi tỉ lệ phần trăm qua từng thời kỳ. Tuy cách biểu diễn này gọn nhưng sẽ kiến biểu đồ trở nên rối và "không thể hiểu được". Vì vậy, tách **Stacked Donut Chart** ra thành nhiều **Pie Chart** hoặc xem xét chuyển qua biểu diễn bằng **Column Chart** sẽ là giải pháp tối ưu hơn.

{{< image classes="fancybox center" src="/images/post/pie-chart-and-how-to-use/pie-chart-8.png" title="Ví dụ về Stacked Donut Chart" >}}

## 3.3. Semi-Circle Pie Chart

Dạng biểu đồ này thường được dùng để so sánh tỉ lệ phần trăm khi mà chỉ có 2 thể loại duy nhất. Ví dụ: *Tỉ lệ dân cư ở thành thị/nông thôn trong cùng một tỉnh*, ...

{{< image classes="fancybox center" src="/images/post/pie-chart-and-how-to-use/pie-chart-9.png" title="Ví dụ về Semi-Circle Pie Chart" >}}


## 3.4. Irregular Pie Chart

Đây là một dạng Pie Chart thể hiện các miếng bánh với bán kính không bằng nhau. **Irregular Pie Chart** có thể khắc phục sự gần giống nhau của những thể loại có tỉ lệ gần bằng nhau, vì bán kính khác nhau thì diện tích cũng khác nhau khá nhiều. Tuy nhiên, nếu thể loại có tỉ lệ cao nhất cách khá xa thể loại có tỉ lệ thấp nhất thì ta cũng không nên dùng biểu đồ này do sự mất cân đối quá lớn giữa các thể loại.

{{< image classes="fancybox center" src="/images/post/pie-chart-and-how-to-use/pie-chart-10.png" title="Ví dụ về Irregular Pie Chart" >}}


# 4. Kết luận

Mình đã sơ lược qua những lưu ý khi sử dụng Pie Chart và một số dạng biểu đồ khác của Pie Chart. Hy vọng sẽ giúp ích cho các bạn trong phân tích dữ liệu cũng như vẽ bảng biểu.

## Tham khảo

- [Data Visualization – How to Pick the Right Chart Type?](https://eazybi.com/blog/data_visualization_and_chart_types/)
- [Do This, Not That: Pie Charts](https://infogram.com/blog/do-this-not-that-pie-charts/)

