---
title: "Logistics Problem (Shopee Code League 2020)"
slug: "logistics-problem"
date: 2020-07-19T11:55:24+07:00
draft: false
categories:
- analysis
tags:
- data
- python
- programming
keywords:
- "shopee code league"
- "logistics"
thumbnailImage: /thumbnails/shopee-code-league.jpg
thumbnailImagePosition: left
---

**Logistics Problem** là challenge thứ x của Shopee Code League 2020 - một cuộc thi về Code và Data kéo dài 2 tháng với các challenge khác nhau. Bài toán Data Analytics lần này tiếp tục là một chủ đề về Logistics - hay nói nôm na là *"ship hàng"*. Nhiệm vụ của các đội là xác định các đơn hàng giao trễ hẹn dựa trên data và bộ rule cho sẵn. Sau một khoảng thời gian tìm hiểu và implement thì mình xin giới thiệu đến các bạn giải pháp của team (score: 1.0/1.0).

<!--more-->

<!--toc-->

# 1. Quan sát dữ liệu

Đề bài và mô tả dữ liệu trên Kaggle: [[Open] Shopee Code League - Logistics](https://www.kaggle.com/c/open-shopee-code-league-logistic)

{{< image classes="fancybox center" thumbnail-width="100%" src="/images/post/logistics-problem/1.png" title="Dữ liệu được public trên Kaggle">}}

Dữ liệu có 3.176.313 dòng x 6 cột:

- **orderid**: Mã đơn hàng, duy nhất trên toàn bộ dữ liệu.
- **pick**:  Thời gian lấy hàng dưới dạng epoch timestamp seconds.
- **1st_deliver_attempt**: Thời gian giao hàng lần 1 dưới dạng epoch timestamp seconds.
- **2nd_deliver_attempt**: Thời gian giao hàng lần 2 dưới dạng epoch timestamp seconds. Nếu 1 đơn hàng được giao thành công trong lần đầu thì sẽ không có lần giao thứ 2.
- **buyeraddress**: Địa điểm người mua (địa điểm đích).
- **selleraddress**: Địa điểm người bán (địa điểm gốc).

Một dòng dữ liệu thể hiện cho **một đơn hàng** trên nền tảng Shopee.

# 2. Phân tích yêu cầu

Yêu cầu của bài toán lần này khá đơn giản: *Xác định các đơn hàng giao trễ dựa trên* **Service Level Agreements (SLA)**.

**SLA** mô tả khoảng thời gian giao hàng cam kết của một đối tác giao hàng giữa 2 địa điểm và được định nghĩa dưới đây:

{{< image classes="fancybox center" thumbnail-width="100%" src="/images/post/logistics-problem/2.png" title="Ma trận SLA giữa các địa điểm">}}

Thời gian giao hàng bắt đầu tính từ **ngày tiếp theo** sau ngày lấy hàng (pick up date) đến lần giao hàng thứ nhất. Nếu lần đầu giao hàng không thành công thì **lần giao hàng thứ hai không được lớn hơn 3 ngày từ lần giao thứ nhất, bất kể lộ trình**.

Thời gian giao hàng chỉ tính từ Thứ Hai đến Thứ Bảy và loại trừ 4 ngày lễ: 

- 2020-03-08
- 2020-03-25
- 2020-03-30
- 2020-03-31

{{< alert info >}}
**Lưu ý**: cần chuyển epoch timestamp sang GMT+8 trước khi tính toán.
{{< /alert >}}

Như vậy ta có các rule sau để xác định đơn hàng trễ:

- Thời gian từ lúc lấy hàng đến lúc giao lần 1 lớn hơn thời gian cam kết SLA giữa 2 địa điểm người bán và người mua.

- Hoặc nếu có giao lần thứ hai thì thời gian giao hàng từ lần giao thứ nhất tới lần giao thứ hai lớn hơn 3 ngày.


# 3. Tìm giải pháp

Load dữ liệu và xem những thuộc tính của dữ liệu:

```python
data_path = "./data/delivery_orders_march.csv"
result_path = "./data/result.csv"
d = pd.read_csv(data_path)
```

{{< image classes="fancybox center" thumbnail-width="100%" src="/images/post/logistics-problem/3.png" title="Sơ lược về dữ liệu">}}

Fix những giá trị bị miss.

```python
d['1st_deliver_attempt'] = d['1st_deliver_attempt'].astype(np.int64)
d['2nd_deliver_attempt'] = d['2nd_deliver_attempt'].fillna(0).astype(np.int64)
```

Khởi tạo các địa điểm và mảng SLA phục vụ tính toán SLA.

```python
holidays = [ "2020-03-08", "2020-03-25", "2020-03-30", "2020-03-31" ]

places = [ "metro manila", "luzon", "visayas", "mindanao" ]

# mapping for city index
places_map = { place:i for i, place in enumerate(places)}

# sla_map[seller][buyer]
sla_map = [[3, 5, 7, 7],
           [5, 5, 7, 7],
           [7, 7, 7, 7],
           [7, 7, 7, 7]]
```

Xác định địa điểm người bán và người mua, giải quyết trường hợp trùng tên địa điểm nhưng ở những vị trí khác nhau. Sau đó thay thế địa chỉ bằng index của địa điểm trong SLA map.

```python
# convert address to city index
def get_place_index(address): 
    return np.argmax([address.lower().rfind(i) for i in places])

d["buyeraddress"] = d["buyeraddress"].apply(lambda x: get_place_index(x))
d["selleraddress"] = d["selleraddress"].apply(lambda x: get_place_index(x))
```

Tính toán SLA cho toàn bộ dữ liệu.

```python
d["sla"] = d.apply(lambda x: sla_map[x["selleraddress"]][x["buyeraddress"]], axis=1)
```

Chuyển timestamp ở các cột ngày thành GMT+8 và bỏ đi phần time.

```python
dt_columns = ['pick', '1st_deliver_attempt', '2nd_deliver_attempt']
for dt_col in dt_columns:
    d[dt_col] = (d[dt_col] + 3600*8) // (3600*24)
```

Tính toán ngày giao hàng dùng hàm busday_count của NumPy.

```python
t1 = d['pick'].values.astype('datetime64[D]')
t2 = d['1st_deliver_attempt'].values.astype('datetime64[D]')
t3 = d['2nd_deliver_attempt'].values.astype('datetime64[D]')

d['num_days1'] = np.busday_count(t1, t2, weekmask="1111110", holidays=holidays)
d['num_days2'] = np.busday_count(t2, t3, weekmask="1111110", holidays=holidays)
```

Cuối cùng là xác định đơn hàng giao trễ dựa trên các rule đã xác định.

```python
d['is_late'] = (d['num_days1'] > d['sla']) | (d['num_days2'] > 3)
d['is_late'] = d['is_late'].astype(int)
```

Ghi file và nộp.

```python
result = d[["orderid", "is_late"]]
result.to_csv(result_path, index=False)
```

Bóc thử những thằng trễ ra xem nó như thế nào :D

{{< image classes="fancybox center" thumbnail-width="100%" src="/images/post/logistics-problem/4.png" title="Những đơn hàng giao trễ">}}

Sau khi chạy xử lý xong thì phát hiện có **762.422** đơn hàng giao trễ :D


Các bạn có thể xem toàn bộ notebook, dữ liệu tại GitHub: [logistics-shopee-code-league](https://github.com/chidokun/logistics-shopee-code-league)


# 4. Nhận định

So với challenge trước (Order Burshing Problem), challenge lần này có các rule đơn giản hơn. Nhưng cũng sẽ khó hơn tí vì lượng dữ liệu khá lớn. Nếu chưa có nhiều kinh nghiệm xử lý dữ liệu và tối ưu hóa thì có thể sẽ không kịp thời gian làm bài (thời gian làm cho challenge này là 3 giờ).

Many thanks for my teammate **[@hoanghouit](https://github.com/hoanghouit)** (Business Analyst), **[@XuanVuong](https://github.com/XuanVuong)** (Business Analyst), **[@PhamVanMinh272](https://github.com/PhamVanMinh272)** (Data Engineer), **[@nlchibao](https://github.com/nlchibao)** (ML Engineer).