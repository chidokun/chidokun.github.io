---
title: "Tập tành crawl dữ liệu product của Tiki"
slug: "crawl-tiki-products"
date: 2020-05-31T21:37:27+07:00
draft: false
categories:
- programming
tags:
- crawl
- python
- programming
keywords:
- "crawl"
- "cào dữ liệu"
- "python"
thumbnailImage: /thumbnails/crawl-tiki.png
thumbnailImagePosition: left
---

Tiki là một trong những trang thương mại điện tử lớn nhất Việt Nam. Với chính sách gắt gao để hạn chế hàng nhái, hàng giả nên những thông tin product trên Tiki có thể "tin tưởng" được. Nếu có nhu cầu lấy dữ liệu sản phẩm thì dữ liệu trên Tiki cũng là một nguồn tham khảo đáng tin cậy. Bên cạnh đó, mình cũng đang tập tành viết crawler nên trong bài này mình sẽ giới thiệu cách mình đã làm để lấy dữ liệu về sản phẩm trên Tiki.



{{< alert info >}}
Qua một khoảng thời gian dài, nhiều bạn feedback với mình là code trong bài viết này không thể chạy được nữa. Không bất ngờ lắm với vấn đề này, mình sẽ hướng dẫn các bạn lấy lại dữ liệu về sản phẩm trên Tiki với Phần 2 nhé: [Tập tành crawl dữ liệu product của Tiki (Phần 2)]({{< ref "/post/crawl-tiki-products-p2" >}})
{{< /alert >}}

<!--more-->

<!--toc-->

# 1. Inspect Tiki và xác định thông tin cần lấy

Dữ liệu mình cần là các sản phẩm Laptop bao gồm thông tin cơ bản, cấu hình và giá cả. Các bạn có thể dùng dữ liệu này để dự đoán giá Laptop dựa vào cấu hình chẳng hạn. Theo mình khảo sát, đến thời điểm này, Tiki có số lượng sản phẩm Laptop nhiều nhất so với các trang khác như Thế giới di dộng hoặc FPT Shop.



{{< image classes="fancybox center" thumbnail-width="90%" src="/images/post/crawl-tiki-products/1.png" title="Một mẫu laptop trên trang Tiki.vn" >}}

Để bắt đầu "ngâm cứu", mình sử dụng **Chrome Developer Tool** của Chrome. Quá trình này thường là "mò kim đáy bể", tìm vàng trong rác :). Mình chọn **XHR** để lọc các request AJAX, và xem xét hết tất cả các response để tìm xem cái nào sẽ trả những dữ liệu mà chúng ta cần.

{{< image classes="fancybox center" thumbnail-width="100%" src="/images/post/crawl-tiki-products/2.png">}}

Ở đây mình tìm được API này:

```text
https://tiki.vn/api/v2/products/52179836
```

Rất may API này trả đầy đủ dữ liệu mình cần. Nếu không tìm thấy API như vậy, có khi chúng ta phải mò từng API một. Thậm chí trong trường hợp xấu nhất, trang web là server-render thì chúng ta phải đọc từng tag HTML để bóc tách ra dữ liệu mình cần.

Test lại một tí API trên xem có cần xác thực gì không, dùng Postman gọi thẳng vẫn OK. Ở đây bạn có thể xác định mã sản phẩm ở đây là `52179836`.

{{< image classes="fancybox center" thumbnail-width="100%" src="/images/post/crawl-tiki-products/3.png">}}


Vậy là mình đã xác định được một API dùng để lấy thông tin sản phẩm. Việc kế tiếp là tìm ra tất cả mã sản phẩm cho những sản phẩm mình muốn lấy.

Tiếp tục inspect trang Laptop của Tiki.

{{< image classes="fancybox center" thumbnail-width="100%" src="/images/post/crawl-tiki-products/4.png">}}

Không may như trường hợp trước, lần này mình không tìm ra được API nào để có thể lấy danh sách sản phẩm trong kết quả tìm kiếm. Vậy thì chúng ta phải đọc từng tag HTML để lấy dữ liệu thôi.

Mình sẽ inspect vào từng sản phẩm trong kết quả tìm kiếm xem thế nào. Ở đây có 2 attribute nghi ngờ là `data-seller-product-id` và `data-id`, đơn giản là thế vào API trước xem kết quả trả về có phù hợp không.

{{< image classes="fancybox center" thumbnail-width="100%" src="/images/post/crawl-tiki-products/5.png">}}

Kết quả là dữ liệu trong attribute `data-id` cho kết quả phù hợp nên chúng ta sẽ lấy dữ liệu của `data-id` làm Mã sản phẩm.

Navigate qua trang kế tiếp trong kết quả tìm kiếm thì lúc này, trên url xuất hiện thêm `&page=2`. 

{{< image classes="fancybox center" thumbnail-width="100%" src="/images/post/crawl-tiki-products/6.png">}}

Test thử `&page=100` xem sao.

{{< image classes="fancybox center" thumbnail-width="100%" src="/images/post/crawl-tiki-products/7.png">}}

Như vậy, chúng ta có thể duyệt qua từng page để lấy danh sách mã sản phẩm rồi ứng với mã sản phẩm đó, ta có thể lấy được dữ liệu mong muốn.

# 2. Crawl dữ liệu trên Tiki

Mình dùng thư viện BeautifulSoup trên Python để đọc các tag HTML lấy dữ liệu.

Bước đầu tiên, mình sẽ crawl hết tất cả mã sản phẩm của Laptop, đồng cũng ghi ra file để backup lại.

```python
def crawl_product_id():
    product_list = []
    i = 1
    while (True):
        print("Crawl page: ", i)
        response = requests.get(laptop_page_url.format(i))
        parser = BeautifulSoup(response.text, 'html.parser')

        product_box = parser.findAll(class_="product-item")

        if (len(product_box) == 0):
            break

        for product in product_box:
            product_list.append(product.get("data-id"))

        i += 1

    return product_list, i

def save_product_id(product_list=[]):
    file = open(product_id_file, "w+")
    str = "\n".join(product_list)
    file.write(str)
    file.close()
    print("Save file: ", product_id_file)

# crawl product id
product_list, page = crawl_product_id()

print("No. Page: ", page)
print("No. Product ID: ", len(product_list))

# save product id for backup
save_product_id(product_list)
```

Sau khi đã có tất cả mã sản phẩm, chúng ta sẽ gọi đến API đã tìm được để lấy thông tin product.

```python
def crawl_product(product_list=[]):
    product_detail_list = []
    for product_id in product_list:
        response = requests.get(product_url.format(product_id))
        if (response.status_code == 200):
            product_detail_list.append(response.text)
            print("Crawl product: ", product_id, ": ", response.status_code)
    return product_detail_list

```

Thông tin trả về dạng JSON với rất nhiều cấp, chúng ta có thể lọc ra những thông tin cần thiết để lưu dưới dạng CSV. Ở đây mình tạm "làm phẳng" JSON với bằng cách chuyển những field object thành JSON String.

```python
flatten_field = [ "badges", "inventory", "categories", "rating_summary", 
                  "brand", "seller_specifications", "current_seller", "other_sellers", 
                  "configurable_options",  "configurable_products", "specifications", "product_links",
                  "services_and_promotions", "promotions", "stock_item", "installment_info" ]

def adjust_product(product):
    e = json.loads(product)
    if not e.get("id", False):
        return None

    for field in flatten_field:
        if field in e:
            e[field] = json.dumps(e[field], ensure_ascii=False)
    return e

# flatten detail before converting to csv
product_json_list = [adjust_product(p) for p in product_list]
```

Cuối cùng là ghi file ra CSV.

```python
def save_product_list(product_json_list):
    file = open(product_file, "w")
    csv_writer = csv.writer(file)

    count = 0
    for p in product_json_list:
        if p is not None:
            if count == 0:
                header = p.keys() 
                csv_writer.writerow(header) 
                count += 1
            csv_writer.writerow(p.values())
    file.close()
    print("Save file: ", product_file)

# save product to csv
save_product_list(product_json_list)
```

Và đây là kết quả :)

{{< image classes="fancybox center" thumbnail-width="90%" src="/images/post/crawl-tiki-products/8.png" title="Thành quả sau khi crawl dữ liệu từ Tiki">}}

# 3. Kết luận

Quá trình crawl dữ liệu chủ yếu nằm ở việc phân tích website để tìm ra các giải pháp crawl. Trường hợp này rất may mắn là Tiki không dùng nhiều cơ chế chặn crawl nên mình mới crawl thông tin dữ liệu một cách dễ dàng. Các bạn có thể tham khảo code tại đây:

- https://github.com/chidokun/crawl-tiki-products/tree/p1