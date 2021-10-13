---
title: "MIME Type and Upload File Problem"
slug: "mime-type-and-upload-file-problem/en"
date: 2021-10-13T22:54:00+07:00
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
summary: The story begins in my previous projects. There was a requirement to develop a feature that an administrator can upload a text file containing bad words. The system used these words to real-time check the contents that the user submitted. The uploaded file needs to follow a specific format.
---

{{< toc >}}

# Beginning

The story begins in my previous projects. There was a requirement to develop a feature that an administrator can upload a text file containing bad words. The system used these words to real-time check the contents that the user submitted. The uploaded file needs to follow a specific format.

To prevent users from uploading files other than text files, we can do it on the frontend.

```html
<input type="file" accept="text/plain" />
```

So that user merely selects a text file in the file selection window.

However, to ensure system security, just blocking the user on the interface is not enough. It is necessary to re-verify the uploaded file on the backend to see if the user has uploaded a text file or not.. *{{< hl-text green >}}The problem we need to solve is to determine the actual type of file uploaded by the user.{{</ hl-text >}}*.

# Let's go!

To illustrate the above problem, we will build a demo system with a frontend using React.js and a backend using Java/Spring Boot.

{{< image classes="fancybox center" thumbnail-width="80%" src="/images/post/software/mime-type-and-upload-file-problem/1.png">}}

Our interface is quite simple, consisting of an `input[type=file]` and a `button` to upload the selected file. When selecting a file, the UI will display the MIME Type that the browser determines. After uploading the file, the system will return the MIME type identified by the backend. All sourcecode is [here](https://github.com/chidokun/mime-type-upload-example).

Also, prepare some files to test whether the system determines correctly or not.

{{< image classes="fancybox center" thumbnail-width="100%" src="/images/post/software/mime-type-and-upload-file-problem/2.png">}}

Prepare 3 files with the correct extension, then copy these files and rename them:

- real.png -> fake.txt
- real.jpg -> fake.zip
- real.svg -> fake.docx

# File type determination on the backend

The backend system in the project is written in Java using Spring Boot. A controller is implemented to receive the upload request from the user as well.

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

And a `Response` to return the result to the user.

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


## Using the MIME Type defined by the User-agent

When selecting a file from `input[type=file]`, the file type is already determined by the browser (user-agent) follow MIME type format and then transmitted to the backend via the `Content-Type` request header. So the `MultipartFile` class in the controller's parameter already has information about the file's type.

Now you can use `getContentType()` to determine the file type based on the MIME Type.

```java
@PostMapping(path = "/check-file-type", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
public ResponseEntity<Response> checkFileType(@RequestPart MultipartFile file) {
    String mimeType = file.getContentType();
    return ResponseEntity.ok(new Response(mimeType));
}
```

Let's test the files we prepared above.

{{< image classes="fancybox center" thumbnail-width="100%" src="/images/post/software/mime-type-and-upload-file-problem/3.png" title="Test results with real.png and fake.zip" >}}

In the case of the file `real.png`, the user-agent identified the correct MIME type via the `.png` extension. But with the file `fake.zip`, the user-agent cannot correctly identify its file type as JPG but determines it through the `.zip` extension. Therefore, relying on a client-defined MIME type may have some risks when users intentionally change the file's name and extension.

Each file type has different specifications and is stored differently, so if you want to determine the exact type of the file, you need to read the contents of that file.

## MIME Type and some ways to determine file type

**MIME type** (*Multipurpose Internet Mail Extensions*) is a standard that defines the nature and format of a document, file, or set of bytes. It is defined and standardized in IETF's [RFC 6838](https://datatracker.ietf.org/doc/html/rfc6838).

The structure of the MIME type includes *type* and *subtype*:

```
type/subtype
```

*Example*: `text/plain`, `application/zip`, ...

Trong đó:

- **Type** is the general category to which the data type belongs, such as `video` or `text`.
- **Subtype** determines the exact data type classified. For example: With type `text`, we can have subtypes like `plain` (plain text), `html` (HTML source code), or `calendar` (iCalendar `.ics` format).

In general, *{{< hl-text green >}}MIME Type is a name assigned to a file type and is used to determine what type of content to transmit data and the applications based on it to behave accordingly{{</ hl-text >}}*. From the MIME type, we can determine the file type, so *{{< hl-text red >}}from a file how to identify its MIME type?{{</ hl-text >}}*

To determine the MIME type, we need to read its contents. Each file type will have a different storage method, such as a ZIP file with a file specification like [here](https://www.iana.org/assignments/media-types/application/zip). But there are still some common features that can be used for identification.

**File Signature** are pattern bytes stored at the beginning of the file (also known as *magic number* or *magic bytes*), used to identify the content and format of the file. The table below lists some File signatures of some popular formats (see some file signatures [here](https://en.wikipedia.org/wiki/List_of_file_signatures)).

|Hex signature|ISO 8859-1|Offset|Extension|Description|
|---|---|---|---|---|
|`89 50 4E 47 0D 0A 1A 0A`|`‰PNG␍␊␚␊`|0|png|Image encoded in the Portable Network Graphics format|
|`EF BB BF`|`ï»¿`|0|txt|UTF-8 byte order mark, commonly seen in text files.|
|`25 50 44 46 2D`|`%PDF-`|0|pdf|PDF document|
|`66 74 79 70 69 73 6F 6D`|`ftypisom`|4|mp4|ISO Base Media file (MPEG-4)|
|`37 7A BC AF 27 1C`|`7z¼¯'␜|0|7z|7-Zip File Format|

Besides using the *File signature*, sometimes it's necessary to read file content to find the exact file type. For example, SVG format is essentially XML. Therefore, to determine it, in addition to having to read *magic number* to determine the XML format, it is also necessary to read more content inside to determine the SVG format correctly.

Some other formats, such as *Apple iWork*, are actually a collection of XML files inside a Zip file. At this time, the Zip file is responsible for making the container containing the XML files. File type identification becomes more difficult due to the need to decompress the content inside.

## Using Apache Tika to determine MIME Type

With Java systems, [Apache Tika](https://tika.apache.org/) can be used to extract information and determine the exact format of the file's data. Apache Tika finds out the data format of a file based on several criteria:

- *Magic number*: Set of first bytes of the file.
- *File name extension*: Partially based on file extension.
- *Metadata* of files downloaded from the Internet.
- Define *container* and its contents.

To use Tika in a *Maven project*, you can add a dependency to `pom.xml`:

```xml
<dependency>
    <groupId>org.apache.tika</groupId>
    <artifactId>tika-core</artifactId>
    <version>2.1.0</version>
</dependency>
```

So we can write more functions that determine the correct MIME type of a file when uploading to the system.

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

Create one more API under the backend and use Tika to recognize the MIME Type.

```java
@PostMapping(path = "/check-real-type", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
public ResponseEntity<Response> checkRealType(@RequestPart MultipartFile file) {
    String mimeType = FileUtils.getRealMimeType(file);
    return ResponseEntity.ok(new Response(mimeType));
}
```

After that, edit the UI to upload files to the backend using the newly created API and test again with some files.

{{< image classes="fancybox center" thumbnail-width="100%" src="/images/post/software/mime-type-and-upload-file-problem/4.png" title="Test results with real.png and fake.zip. Tika got it right.">}}

In the file `real.png` Tika identified the correct MIME type. With the file `fake.zip`, Tika correctly identified the original MIME type of the file as `image/jpeg` despite being renamed `fake.zip`.

The list of formats that Tika is supporting can be found[here](https://tika.apache.org/2.1.0/formats.html).

# TL;DR

Backend systems should verify the type of the uploaded file when receiving an uploaded file. Checking the file type based on the MIME type detected by the browser may not be sufficient because there will be some cases where the file is changed to an extension to phishing the system. Each file type has a different structure. It's possible to determine the exact type of a file based on its format with the help of Apache Tika on Java systems.

See the source code here: https://github.com/chidokun/mime-type-upload-example

**References**

- [MIME types (IANA media types)](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/MIME_types)
- [Form Content-Type](https://www.w3.org/TR/html401/interact/forms.html#h-17.13.4)
- [List of file signatures](https://en.wikipedia.org/wiki/List_of_file_signatures)
- [Apache Tika - Content Detection](https://tika.apache.org/2.0.0/detection.html)
