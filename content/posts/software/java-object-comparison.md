---
title: "Bài toán So sánh Đối tượng trong Java"
slug: "java-object-comparison"
date: 2021-02-02T15:16:01+07:00
draft: true
categories:
- programming
tags:
- java
- programming
keywords:
- "so sánh"
- "comparator"
- "java"
thumbnailImage: /thumbnails/compare-obj.png
thumbnailImagePosition: left
---

Bài toán so sánh 2 đối tượng khác nhau có lẽ hiếm gặp hơn bài toán so sánh 2 đối tượng cùng lớp. Đối với các hệ thống Java, việc giải quyết bài toán so sánh 2 đối tượng khác nhau có phần khó hơn. Trong bài này, chúng ta cùng bàn về một số giải pháp để giải quyết bài toán so sánh 2 object khác nhau.

<!--more-->
{{< toc >}}

# 1. Vấn đề đặt ra

Thông thường, bài toán so sánh 2 object khác kiểu có thể gặp trong trường hợp cần đọc dữ liệu của cùng một loại đối tượng ở nhiều datasource khác nhau. Cụ thể là bài toán đảm bảo sự nhất quán của dữ liệu ở 2 datasource khác nhau. Trong quá trình vận hành hệ thống có thể có những incident khiến việc ghi dữ liệu không thành công, dẫn đến sự không nhất quán dữ liệu. Lúc này, sẽ dẫn đến nhu cầu scan dữ liệu, so sánh và cập nhật thông tin ở 2 datasource để đảm bảo sự nhất quán dữ liệu.

Nếu là bài toán so sánh 2 đối tượng cùng lớp, ta có thể "chỉ định" đối tượng này có thể so sánh được bằng cách implement class `Comparable<T>` và sau đó override method `compareTo(T obj)`. 

```java
@Override
public int compareTo(T obj) {
    return this.userId.compareTo(obj.userId);
}
```

Trường hợp cần so sánh bằng nhau, đã có [Lombok](https://projectlombok.org/) lo giúp chúng ta. Chỉ đơn giản dùng annotation `@EqualsAndHashCode`, nó sẽ tự override lại method `equals()` và `hashCode()`.

Nhưng với 2 đối tượng khác nhau, ta cần phải có giải pháp khác. Xét ví dụ về thông tin người dùng, chúng ta có 2 object từ 2 datasource khác nhau như sau (chọn vào tab để xem dữ liệu):

{{< tabbed-codeblock >}}
    <!-- tab UserProfile1 -->
{
    userId: "1574352",
    userName: "anonym",
    birthday: 957114000000,
    gender: 1,
    email: "anonym@gmail.com",
    avatar: "https://www.gravatar.com/***",
    phoneNumber: "+8414376598",
    city: "Hanoi",
    nationality: "Vietnam",
    idName: "ANONYM MR.",
    idMap: {
        1: "125347689"
    },
    idIssueDate: "2025/11/06",
    pinHash: "8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92",
    kycSource: 0,
    isLocked: false,
    lockTime: 0,
    userType: 1,
    totalAmount: 1000.0,
    registerDate: 1588310113000
}
    <!-- endtab -->
    <!-- tab UserProfile2 -->
{
    userId: "1574352",
    userName: "anonym",
    birthDate: "01/05/2000",
    gender: 1,
    email: "anonym@gmail.com",
    avatarUrl: "https://www.gravatar.com/***",
    phoneNumber: 8414376598,
    city: "Hanoi",
    nationality: "Vietnam",
    idFullName: "ANONYM MR.",
    idNumber: "125347689",
    idType: 1,
    idIssueDate: "2025/11/06",
    pinHash: "8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92",
    kycSource: 0,
    isLocked: false,
    lockTime: 0,
    userType: 1,
    totalAmount: 1000.0,
    day: 1,
    month: 5,
    year: 2020
}
    <!-- endtab -->
{{< /tabbed-codeblock >}}

Và các class chứa data trên được định nghĩa như sau:

{{< tabbed-codeblock >}}
<!-- tab userprofile1 -->
public class UserProfile1 {
    private String userId;
    private String userName;
    private Long birthday;
    private Integer gender;
    private String email;
    private String avatar;
    private String phoneNumber;
    private String city;
    private String nationality;
    private String idName;
    private Map<Integer, String> idMap;
    private String idIssueDate;
    private String pinHash;
    private Integer kycSource;
    private Boolean isLocked;
    private Long lockTime;
    private Integer userType;
    private Double totalAmount;
    private Long registerDate;
}
<!-- endtab -->
<!-- tab UserProfile2 -->
public class UserProfile2 {
    private String userId;
    private String userName;
    private String birthDate;
    private int gender;
    private String email;
    private String avatarUrl;
    private long phoneNumber;
    private String city;
    private String nationality;
    private String idFullName;
    private String idNumber;
    private String idType;
    private String idIssueDate;
    private String pinHash;
    private int kycSource;
    private boolean isLocked;
    private long lockTime;
    private int userType;
    private double totalAmount;
    private int day;
    private int month;
    private int year;
}
<!-- endtab -->
{{< /tabbed-codeblock >}}

Cùng nhận xét tí về các thuộc tính của 2 object này nhé:

- Hai object này khác nhau về số lượng thuộc tính.
- Dễ thấy, các thuộc tính của 2 object này có tên trùng nhau như `userId`, `userName` nhưng cũng có một số thuộc tính có tên khác nhau như `birthday` và `birthDate`, `avatar` và `avatarUrl`, v.v ...
- Một số thuộc tính không những khác nhau về tên mà còn khác kiểu dữ liệu: `birthday = 957114000000` và `birthDate = "01/05/2000"` chẳng hạn. Vì vậy cần phải chuyển về cùng kiểu thì mới so sánh được.
- Một thuộc tính phải dùng nhiều thuộc tính tương ứng để so sánh: `registerDate = 1588310113000` phải biến đổi thành dạng dd/MM/yyyy và dùng các thuộc tính `day = 1`, `month = 5` và `year = 2020` để so sánh.

Qua nhận xét trên, có thể thấy các thuộc tính ở các datasource có thể khác nhau về:

- **Tên thuộc tính**: Như `birthday` với `birthDate` chẳng hạn. 
- **Kiểu dữ liệu và định dạng**: `birthday` có kiểu timestamp nhưng `birthDate` đã được parse ra kiểu String với format `dd/MM/yyyy`, hay khác biệt về kiểu primitive của Java và Object như `int` với `Integer`, `boolean` với `Boolean` chẳng hạn.
- **Số lượng field cho cùng 1 thuộc tính**: Ví dụ rõ ràng nhất là `registerDate` với kiểu timestamp đã được parse ra format dd/MM/yyyy và lưu riêng 3 field này là `day`, `month`, `year`.

Với sự khác biệt như trên, ở phần kế tiếp mình sẽ bàn về một số cách so sánh 2 object này. 

# 2. So sánh 2 object khác nhau

## 2.1. Một số phương pháp

*So sánh lớn bé* thường được áp dụng cho 1 thuộc tính. Ví dụ: so sánh user này lớn hơn user kia dựa vào `userId` và thường dùng trong sắp xếp. Trái lại, *so sánh bằng* phải áp dụng cho tất cả thuộc tính vì lúc này phải so sánh từng thuộc tính liên quan với nhau.

Tùy vào nhu cầu và ngôn ngữ lập trình mà sẽ có các cách giải quyết khác nhau. Để so sánh 2 object khác nhau bằng Java, chúng ta có thể có những cách sau:

- **Viết một method so sánh object này với object kia**: Đây có lẽ là cách dễ dàng nhất. Chúng ta sẽ viết một method `boolean equals(UserProfile2 obj)` trong `UserProfile1`, so sánh từng thuộc tính với nhau, giải quyết hết tất cả những vấn đề về thuộc tính như đã đề cập ở trên trong cùng 1 function. Dễ thấy nếu ta viết hết mọi thứ trong cùng 1 function sẽ khiến code bị lặp rất nhiều. Đồng thời, nếu object có quá nhiều thuộc tính thì khá tốn công sức để code phần so sánh này.

- **Chuẩn hóa 2 object này về cùng object**: Có thể chuẩn hóa một object này thành object kia hoặc chuẩn hóa cả 2 object thành một object thứ 3. Lúc này bài toán trở thành so sánh 2 object cùng loại. Có nhiều thư viện hỗ trợ map object này thành object khác như `MapStruct`, nhưng nhìn chung, việc map object này thành object khác có thể gây tốn memory trong quá trình so sánh do phải lưu trữ các object trung gian.

- **Tạo ra các class chuyên biệt để so sánh 2 object này**: Nếu theo cách làm này, chúng ta có thể tạo ra các class chuyên biệt và cài đặt những tiêu chí so sánh cụ thể, giải quyết các trường hợp khác biệt của thuộc tính so sánh như đã đề cập ở trên. Cách này không có một giải pháp chung, tùy bài toán và vấn đề phát sinh mà chúng ta sẽ phải có cách thiết kế khác nhau.

Trong bài này mình sẽ bàn chủ yếu về giải pháp thứ 3: *Tạo ra các class chuyên biệt để so sánh 2 object này*

## 2.2. Các vấn đề cần giải quyết

Chúng ta sẽ lần lượt giải quyết những yêu cầu đặt ra của bài toán.

qua khảo sát các vấn đề trên ta tổng quát hóa lên như sau: 

- việc so sánh các đối tượng này sẽ quy về so sánh các tiêu chí của đối tượng, 
- một tiêu chí sẽ có thể gồm 1 hoặc nhiều thuộc tính với các kiểu dữ liệu khác nhau, 
- mỗi tiêu chí sẽ tự biết cách biến đổi các thuộc tính để có thể so sánh được, đồng nghĩa với việc mỗi tiêu chí sẽ có 1 hàm xử lý riêng.

và cách xử lý vấn đề phải thỏa một số yêu cầu sau:

- tái sử dụng các tiêu chí so sánh
- khả năng mở rộng
- viết code ngắn gọn
- không tốn mem

## 2.3. Từng bước giải quyết vấn đề

### 2.3.1. Định nghĩa "Tiêu chí" so sánh

trc hết ta định nghĩa ra một interface xử lý so sánh so

{{< codeblock "Spec.java" >}}
public interface Spec<T, U, V extends Comparator<?>> {
    int compare(T o1, U o2, V comparator);
}
{{< /codeblock >}}

Tham số T, U là 2 đối tượng cần so sánh, V là một comparator để so sánh 2 đối tượng này theo một field cụ thể.

Tiếp theo ta sẽ định một "tiêu chí so sánh" cụ thể, tiêu chí này chứa một comparator và một xử lý so sánh, đồng thời có một method compare để compare 2 đối tượng so sánh.

{{< codeblock "CompareSpec.java" >}}
@Setter
@Getter
@AllArgsConstructor
public abstract class CompareSpec<T, U, V extends Comparator<?>> {

    protected V comparator;
    protected Spec<T, U, V> spec;

    public int compare(T o1, U o2) {
        return spec.compare(o1, o2, comparator);
    }
}
{{< /codeblock >}}

Và một abstract class cụ thể để so sánh 2 đối tượng, chúng ta có thể có nhiều object thể hiện một profile của user vì vậy, chúng ta chỉ định 2 đối tượng này ở tham số T và U. Class UserSpec đại diện cho một tiêu chí cụ thể là tiêu chí so sánh user.

{{< codeblock "CompareSpec.java" >}}
@Setter
public abstract class CompareUser<T, U> {

    private Map<String, UserSpec<? extends Comparator<?>>> specs = new HashMap<>();

    public int compare(T o1, U o2, String specName) throws Exception {

        if (!this.specs.containsKey(specName)) {
            throw new Exception("\"" + specName + "\" is not supported");
        }

        return this.specs.get(specName).compare(o1, o2);
    }

    public boolean equals(T o1, U o2) {
        int compare = 0;
        Set<String> keys = specs.keySet();

        for (String specName : keys) {
            compare |= this.specs.get(specName).compare(o1, o2);
            System.out.println(specName + ": " + compare);
        }

        return compare == 0;
    }

    public class UserSpec<V extends Comparator<? extends Comparable<?>>> extends CompareSpec<T, U, V> {

        public UserSpec(V comparator, Spec<T, U, V> spec) {
            super(comparator, spec);
        }
    }
}

{{< /codeblock >}}




đầu tiên là giải quyết vấn đề null của các kiểu dữ liệu cơ bản

trong java nếu đối tượng là null thì sẽ quăng exception

vì vậy cần implement lại `Comparator<>` của Java (nói sơ về `Comparator<T>`)

phần này sẽ thêm mục xử lý null cho các kiểu dữ liệu cơ bản.

{{< codeblock "Comparer.java" >}}
public class Comparer<T extends Comparable<T>> implements Comparator<T> {

    @Override
    public int compare(T o1, T o2) {
        int nullO1 = o1 == null ? 1 : 0;
        int nullO2 = o2 == null ? 1 : 0;

        // if have at least 1 object is null
        if ((nullO1 | nullO2) != 0) {
            return nullO2 - nullO1;
        } else {
            return o1.compareTo(o2);
        }
    }
}
{{< /codeblock >}}

# 3. Kết luận

ưu điểm

nhược điểm

# Tham khảo

