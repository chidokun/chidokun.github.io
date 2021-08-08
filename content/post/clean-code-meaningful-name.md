---
title: "Clean Code: Bạn đã đặt tên biến, hàm đủ \"clean\"?"
slug: "clean-code-meaningful-name"
date: 2021-08-06T19:00:39+07:00
draft: false
categories:
- programming
tags:
- "clean code"
keywords:
- "clean code"
- "naming"
- "đặt tên biến"
- "đặt tên biến, hàm"
- "java"
thumbnailImage: /thumbnails/clean-code.jpg
thumbnailImagePosition: left
---

Mỗi lần đọc lại quyển sách *Clean Code* của tác giả *Robert C. Martin*, mình lại nhận ra những điều mới để có thể giúp bản thân viết code chuyên nghiệp hơn. Cách đặt tên biến, hàm cũng ảnh hưởng khá nhiều đến độ *"clean"* của code mà đôi lúc chúng ta lại quên mất hoặc không để ý và khiến cho nó trở thành một đống hỗn độn theo thời gian. 

<!--more-->

<p style="text-align:center"><img style="display:inline-block" src="https://i2.wp.com/mathewanalytics.com/wp-content/uploads/2020/07/reviewcode.152f235.921f924.jpeg" /><span class="caption">(via mathewanalytics.com)</span></p>


# Cái tên tiết lộ mục đích

Có thể nói quan trọng nhất khi chọn một cái tên đó là cái tên này *phải tiết lộ mục đích* sử dụng của nó. Đây là cái mà chúng ta hay quên nhất và cũng có thể nói là tốn nhiều "chất xám" nhất.

Ví dụ trong sách đã khá rõ ràng và dễ hiểu. Giữa hai đoạn code bên dưới, bạn thấy đoạn code nào dễ hiểu hơn?

```java
public List<int[]> getThem() {
    List<int[]> list1 = new ArrayList<>(); 
    for (int[] x : theList)
        if (x[0] == 4) 
            list1.add(x);
    return list1; 
}

public List<Cell> getFlaggedCells() {
    List<Cell> flaggedCells = new ArrayList<>(); 
    for (Cell cell : gameBoard)
        if (cell.isFlagged())
            flaggedCells.add(cell);
    return flaggedCells; 
}
```

Đoạn code thứ nhất sẽ khiến bạn nổ bong bóng với những câu hỏi như: 

- Biến `list1` để làm gì và chứa cái gì trong đó? 
- Phần tử `0` đầu mảng có ý nghĩa gì? 
- Tại sao bằng `4` thì thêm vào `list1`? 
- ... 

Còn đoạn code thứ hai đã có ngữ cảnh quá rõ ràng và cách chọn tên phù hợp đã giúp đoạn code dễ hiểu hơn rất nhiều.

Thỉnh thoảng, chúng ta sẽ quên mất việc phải chọn một cái tên hợp lý với những biến tạm, biến trung gian (ngay cả mình cũng vậy :sweat_smile:). Đôi khi là một công thức mà viết quá gọn nên mất đi tính dễ hiểu. Các con số *"magic number"* (như số `0` hoặc số `4` ở đoạn code bên trên) cũng khiến cho đoạn code bị "mờ" đi một tí. Khi một người mới vào đọc code của bạn thì thế nào bạn cũng phải giải thích cho họ nghe con số đó nghĩa là gì.

Bên cạnh đó, một kiến trúc rõ ràng cũng giúp code được "clean" hơn và dễ dàng hơn để chúng ta chọn một cái tên phù hợp với ngữ cảnh. Các mẫu kiến trúc như [Hexagonal architecture](https://en.wikipedia.org/wiki/Hexagonal_architecture_(software)) có thể giúp tách bạch giữa domain logic code và giảm sự phụ thuộc lẫn nhau giữa các component. Từ đó, các ngữ cảnh đã được phân biệt rạch ròi thì việc chọn tên để đặt cho hàm hay biến cũng trở nên đơn giản hơn.

Sở dĩ mình nói nó là khó nhất vì không có quy tắc cụ thể nào để tuân theo cả, phải dựa vào kinh nghiệm và cải thiện dần dần thì mới thuần thục được.

# Một từ cho một khái niệm

*Bạn chỉ nên dùng một từ cho một và chỉ một khái niệm*. Nghe đơn giản phải không nào?

Nếu bạn dùng Java Spring Data JPA thì chắc hẳn đã biết đến cơ chế sinh query rồi phải không? Bạn chỉ đơn giản định nghĩa một interface kế thừa `JpaRepository`, bên trong nó định nghĩa một public method theo quy tắc nhất định thì Spring Data JPA sẽ tự sinh câu query tương ứng và thực thi nó.

Câu chuyện là, để sinh câu SQL `SELECT` bạn có thể đặt tên là `find…By`, `read…By`, `get…By`, `query…By`, `search…By`, `stream…By` và câu SQL `DELETE` có thể dùng `delete…By`, `remove…By` (xem thêm tại [đây](https://docs.spring.io/spring-data/jpa/docs/current/reference/html/#appendix.query.method.subject)).

Mình thì dùng `get…By` cho câu `SELECT` và `remove…By` cho câu `DELETE`, còn thằng em mình dùng `find…By` và `delete…By`. Kết quả là ta có đoạn code lổm chổm dưới đây.

```java
@Repository
public interface SomethingRepository extends JpaRepository<Something, String> {

  List<Something> getAllByNameLike(String name);

  Something getByName(String name);

  Something findByNameAndOther(String name, String other);

  void removeByNameIn(List<String> names);

  void deleteByName(String name);
}
```

<p style="text-align:center"><img style="display:inline-block" src="https://media.giphy.com/media/uMu5Pp7HhZNL4lzN58/giphy-downsized.gif" /><span class="caption">(via giphy.com)</span></p>


Câu chuyện tiếp theo là về các *DTO - Data Transfer Object*. Mình thường thấy rất nhiều class với suffix lúc thì `ProductDTO`, `ProductData`, `ProductInfo`, `ProductModel`, `ProductEntity`,… để chung với nhau. Các class này đều cùng chứa info của một Product nhưng khác nhau về các thuộc tính bên trong :sweat_smile:. Một số thì dùng để nhận request params từ bên ngoài, một số thì dùng xử lý logic, một số dùng lưu dữ liệu xuống database.

Trường hợp này, tác giả cũng khuyên nên có một context - chẳng hạn như tạo một package khác nhau - để phân biệt mục đích của chúng. Lúc này có thể không cần phân biệt mục đích bằng cách dùng suffix nữa. Đó cũng là một convention cần thống nhất để mọi người hiểu cùng một khái niệm và giữ sự đồng nhất trong cách đặt tên.

# Kết luận nhẹ!

Điều mà mình nhận ra sau khi đọc lại quyển *Clean Code*, đó là hầu hết các vấn đề về đặt tên có thể được giải quyết bằng một convention chung cho cả team, chỉ trừ việc đặt tên thể hiện mục đích sử dụng cho biến. Việc *chọn tên thể hiện mục đích sử dụng* thực sự rất khó và tốn nhiều thời gian suy nghĩ, nhưng hiệu ứng mang lại là code sẽ dễ đọc dễ hiểu hơn mà không cần quá nhiều comment.

Dưới đây là một ví dụ khác của code khó hiểu. Phương thức `compare` sẽ so sánh hai object khác kiểu dựa trên tiêu chí `specName`. Bạn hiểu đoạn code này viết gì không :laughing:?

```java
public int compare(T o1, U o2, String specName) {
    if (!this.specs.containsKey(specName)) {
        throw new IllegalArgumentException("\"" + specName + "\" is not supported");
    }

    int nullableO1 = o1 == null ? 1 : 0;
    int nullableO2 = o2 == null ? 1 : 0;
    if ((nullableO1 | nullableO2) != 0) {
        return nullableO1 - nullableO2;
    } else {
        return this.specs.get(specName).compare(o1, o2);
    }
}
```

Thú thực là mình mất vài phút mới hiểu được nó viết gì. 

Hãy xem đoạn khó hiểu nhất này.

```java
int nullableO1 = o1 == null ? 1 : 0;
int nullableO2 = o2 == null ? 1 : 0;
if ((nullableO1 | nullableO2) != 0) {
    return nullableO1 - nullableO2;
}
```

Cả đoạn này có ý nghĩa là: 

- Nếu cả hai object trên đều bằng `null` thì chúng bằng nhau. 
- Nếu một trong hai object bằng `null` thì object nào khác `null` sẽ lớn hơn.

Khá khó hiểu bởi vì hiệu ứng thực sự của đoạn code trên không được thể hiện rõ ràng. Bạn có thể làm nó *"clean"* hơn không :wink:?