---
title: "Bàn về MIME Type và Bài toán Nhận dạng File type khi upload"
slug: "mime-type-and-upload-file-problem"
date: 2021-09-29T22:30:00+07:00
draft: false
categories:
- "Lập trình"
- "Backend"
tags:
- "backend"
keywords:
- "mime type"
- "file type"
- "mime type detection"
- "upload"
thumbnailImage: /thumbnails/mime.png
thumbnailImagePosition: left
summary: Câu chuyện bắt đầu trong một dự án nọ, có một yêu cầu được đưa ra phải phát triển tính năng cho phép người quản trị upload một file text chứa các từ bị cấm để hệ thống cập nhật config phục vụ việc kiểm tra real-time nội dung người dùng gửi lên. Yêu cầu chỉ được phép upload lên file text theo một định dạng nhất định.
---

{{< toc >}}

# Mở đầu

Câu chuyện bắt đầu trong một dự án nọ, có một yêu cầu được đưa ra phải phát triển tính năng cho phép người quản trị upload một file text chứa các từ bị cấm. Hệ thống sau đó sẽ cập nhật config phục vụ việc kiểm tra real-time nội dung người dùng gửi lên. Yêu cầu chỉ được phép upload lên file text theo một định dạng nhất định.

Để chặn không cho người dùng upload những file khác ngoài file text, ta có thể được thực hiện trên frontend.

```html
<input type="file" accept="text/plain" />
```

Lúc này người dùng chỉ có thể chọn file text trong cửa sổ duyệt file.

Tuy nhiên, để đảm bảo an toàn cho hệ thống, chỉ chặn người dùng trên giao diện là chưa đủ, cần phải xác thực lại file được upload lên ở phía backend xem có phải người dùng đã tải lên một file text hay không. *{{< hl-text green >}}Bài toán chúng ta cần giải quyết là xác định kiểu của file được người dùng upload lên{{</ hl-text >}}*.

# Bắt tay nào!

Để minh họa cho bài toán trên, chúng ta sẽ xây dựng hệ thống minh họa với phần giao diện sử dụng React.js và backend sử dụng Java/Spring Boot.

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/software/mime-type-and-upload-file-problem/1.png">}}

Giao diện của chúng ta khá đơn giản, gồm một `input[type=file]` và một `button` để upload file được chọn. Khi chọn một file, giao diện sẽ hiển thị MIME Type mà trình duyệt xác định. Sau khi upload file, hệ thống sẽ trả về MIME type mà phía backend xác định. Toàn bộ source code có thể xem ở [đây](https://github.com/chidokun/mime-type-upload-example).

Đồng thời chuẩn bị một số file để test xem hệ thống có xác định đúng hay không.

{{< image classes="fancybox center" thumbnail-width="100%" src="/images/post/software/mime-type-and-upload-file-problem/2.png">}}

Chuẩn bị 3 file có định dạng đúng với extension, sau đó copy 3 file này và đổi tên lại: 

- real.png -> fake.txt
- real.jpg -> fake.zip
- real.svg -> fake.docx

# Xác thực kiểu File ở phía Backend

Hệ thống backend trong dự án được viết bằng Java sử dụng Spring Boot. Một controller được cài đặt để nhận request upload từ phía người dùng.

{{< codeblock "UploadController.java" "java">}}
@Slf4j
@RestController
public class UploadController {

    @PostMapping(path = "/check-file-type", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<Response> checkFileType(@RequestPart MultipartFile file) {
        // to be implemented
    }
}
{{</ codeblock >}}

Và một `Response` để trả kết quả về cho người dùng.

{{< codeblock "Response.java" "java">}}
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Response {
    private int status;
    private String message;
    private String mimeType;

    public Response(String mimeType) {
        this.status = HttpStatus.OK.value();
        this.message = "Successful";
        this.mimeType = mimeType;
    }
}
{{</ codeblock >}}


## Dựa vào MIME Type được xác định bởi User-agent

Khi chọn một file từ `input[type=file]`, kiểu file đã được trình duyệt (user-agent) xác định theo MIME type và truyền xuống backend thông qua request header `Content-Type`. Vì vậy, class `MultipartFile` trong tham số đầu vào của controller đã có thông tin về kiểu của file.

Đến đây có thể sử dụng `getContentType()` để xác định kiểu file dựa trên MIME Type.

```java
@PostMapping(path = "/check-file-type", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
public ResponseEntity<Response> checkFileType(@RequestPart MultipartFile file) {
    String mimeType = file.getContentType();
    return ResponseEntity.ok(new Response(mimeType));
}
```

Cùng test lại mới các file test đã chuẩn bị trước.

{{< image classes="fancybox center" thumbnail-width="100%" src="/images/post/software/mime-type-and-upload-file-problem/3.png" title="Kết quả test với real.png và fake.zip" >}}

Trường hợp file `real.png`, user-agent đã xác định đúng MIME type thông qua extension `.png`. Nhưng với file `fake.zip`, user-agent không thể xác định đúng loại file của nó là JPG mà xác định thông qua extension `.zip`. Do đó, việc dựa trên MIME type do client xác định tiềm ẩn nhiều rủi ro khi người dùng có thể cố tình đổi tên và extension của file.

Mỗi loại file có đặc tả khác nhau và được lưu trữ cấu trúc khác nhau, vì vậy muốn xác định chính xác kiểu của file thì cần dựa vào nội dung bên trong của file đó.

## MIME Type và một số cách xác định file type

**MIME type** (*Multipurpose Internet Mail Extensions*) là một tiêu chuẩn xác định bản chất và định dạng của tài liệu, file hoặc một tập hợp các byte. Nó được định nghĩa và chuẩn hóa trong [RFC 6838](https://datatracker.ietf.org/doc/html/rfc6838) của IETF.

Cấu trúc của MIME type gồm có *type* và *subtype*:

```
type/subtype
```

*Ví dụ*: `text/plain`, `application/zip`, ...

Trong đó:

- **Type** là danh mục chung mà loại dữ liệu thuộc về, chẳng hạn như `video` hoặc `text`.
- **Subtype** xác định loại dữ liệu chính xác của kiểu dữ liệu đó được phân loại. Ví dụ: Với type `text`, ta có thể có các subtype như `plain` (text thuần), `html` (HTML source code), hoặc `calendar` (định dạng `.ics` của iCalendar).

Nói chung, *{{< hl-text green >}}MIME Type là một cái tên gán cho một loại file và được dùng để xác định nội dung thuộc kiểu nào để truyền dữ liệu và các ứng dụng dựa vào đó hành xử phù hợp{{</ hl-text >}}*. Từ MIME type ta có thể xác định được loại file, vậy *{{< hl-text red >}}từ một file làm sao xác định MIME type của nó?{{</ hl-text >}}*

Để xác định MIME type, chúng ta cần đọc nội dung của nó. Mỗi loại sẽ file có cách lưu trữ khác nhau, chẳng hạn như file ZIP có đặc tả như ở [đây](https://www.iana.org/assignments/media-types/application/zip). Nhưng vẫn có chung một số đặc điểm mà có thể dùng để nhận dạng.

**File Signature** là những byte pattern được lưu ở vị trí bắt đầu file (hay còn gọi là *magic number* hay *magic bytes*), được dùng để xác định nội dung và định dạng của file. Bảng dưới đây liệt kê một vài File signature của một số định dạng phổ biến ([tham khảo](https://en.wikipedia.org/wiki/List_of_file_signatures)).

|Hex signature|ISO 8859-1|Offset|Extension|Description|
|---|---|---|---|---|
|`89 50 4E 47 0D 0A 1A 0A`|`‰PNG␍␊␚␊`|0|png|Image encoded in the Portable Network Graphics format|
|`EF BB BF`|`ï»¿`|0|txt|UTF-8 byte order mark, commonly seen in text files.|
|`25 50 44 46 2D`|`%PDF-`|0|pdf|PDF document|
|`66 74 79 70 69 73 6F 6D`|`ftypisom`|4|mp4|ISO Base Media file (MPEG-4)|
|`37 7A BC AF 27 1C`|`7z¼¯'␜|0|7z|7-Zip File Format|

Ngoài việc xác định *File signature*, đôi khi còn phải xác định cả nội dung của file thì mới tìm được chính xác loại file. Ví dụ: Định dạng SVG thực chất là XML. Do đó để xác định được nó, ngoài việc phải đọc *magic number* để xác định được định dạng XML, còn cần phải đọc thêm nội dung bên trong mới xác định chính xác định dạng SVG. 

Một số định dạng khác như *Apple iWork*, thực chất là một tập các file XML nằm bên trong một file Zip. Lúc này file Zip có nhiệm vụ làm container chứa các file XML và việc xác định trở nên khó hơn do phải giải nén nội dung bên trong.

## Dùng Apache Tika để xác định MIME Type

Với các hệ thống Java, có thể dùng [Apache Tika](https://tika.apache.org/) để trích xuất thông tin và xác định chính xác định dạng dữ liệu của file. Apache Tika xác định định dạng dữ liệu của file dựa vào nhiều tiêu chí:

- *Magic number*: Tập các byte đầu của file.
- *File name extension*: Một phần dựa vào file extension.
- *Metadata* của file được download về từ Internet.
- Xác định *container* và nội dung bên trong.

Để dùng Tika trong *Maven project*, có thể thêm dependency vào `pom.xml`:

```xml
<dependency>
    <groupId>org.apache.tika</groupId>
    <artifactId>tika-core</artifactId>
    <version>2.1.0</version>
</dependency>
```

Từ đây, chúng ta có thể viết thêm chức năng xác định đúng MIME type của một file khi upload lên hệ thống.

{{< codeblock "FileUtils.java" "java">}}
public class FileUtils {
    public static String getRealMimeType(MultipartFile file) {
        AutoDetectParser parser = new AutoDetectParser();
        Detector detector = parser.getDetector();
        try {
            Metadata metadata = new Metadata();
            TikaInputStream stream = TikaInputStream.get(file.getInputStream());
            MediaType mediaType = detector.detect(stream, metadata);
            return mediaType.toString();
        } catch (IOException e) {
            return MimeTypes.OCTET_STREAM;
        }
    }
}
{{</ codeblock >}}

Tạo thêm một API nữa dưới backend và sử dụng Tika để nhận dạng MIME Type.

```java
@PostMapping(path = "/check-real-type", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
public ResponseEntity<Response> checkRealType(@RequestPart MultipartFile file) {
    String mimeType = FileUtils.getRealMimeType(file);
    return ResponseEntity.ok(new Response(mimeType));
}
```

Sau đó, chỉnh sửa giao diện để upload file xuống backend sử dụng API vừa tạo rồi test lại với một số file.

{{< image classes="fancybox center" thumbnail-width="100%" src="/images/post/software/mime-type-and-upload-file-problem/4.png" title="Kết quả test lại với real.png và fake.zip. Tika đã xác định đúng.">}}

File `real.png` Tika đã xác định đúng MIME type. Với file `fake.zip`, Tika đã xác định đúng MIME type gốc của file là `image/jpeg` mặc dù đã được đổi tên thành `fake.zip`.

Có thể tham khảo danh sách các định dạng mà Tika đang hỗ trợ nhận dạng tại [đây](https://tika.apache.org/2.1.0/formats.html).

# TL;DR

Các hệ thống backend khi nhận file upload nên xác thực lại kiểu của file được upload lên. Kiểm tra kiểu của file dựa vào MIME type do client xác định là chưa đủ vì sẽ có trường hợp file bị đổi extension để đánh lừa hệ thống. Mỗi loại file đều có cấu trúc khác nhau, với các hệ thống Java, có thể xác định chính xác kiểu của file dựa vào cấu trúc của nó dưới sự giúp đỡ của Apache Tika.

Xem source code ở đây: https://github.com/chidokun/mime-type-upload-example

**References**

- [MIME types (IANA media types)](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/MIME_types)
- [Form Content-Type](https://www.w3.org/TR/html401/interact/forms.html#h-17.13.4)
- [List of file signatures](https://en.wikipedia.org/wiki/List_of_file_signatures)
- [Apache Tika - Content Detection](https://tika.apache.org/2.0.0/detection.html)
