---
title: "Tạo Progress Bar trong Java Console"
slug: "console-progress-bar"
date: 2021-07-07T17:54:21+07:00
draft: false
categories:
- "Lập trình"
- "Thực hành"
tags:
- "tips"
keywords:
- "java"
- "progress bar"
- "console"
thumbnailImage: /thumbnails/terminal.png
thumbnailImagePosition: left
---

Là một lập trình viên làm việc khá nhiều với terminal, mình thường xuyên thấy các lệnh chạy trên console cũng có thanh tiến trình để thể hiện phần trăm hoàn thành công việc cũng khá hay ho. Vì vậy, trong bài viết này, chúng ta cùng thử làm một thanh Progress Bar với Java nhé.

<!--more-->

{{< image classes="fancybox center" thumbnail-width="100%" src="/images/post/console-progress-bar/1.gif" title="Một Progress Bar khá hay ho của Yarn">}}

<!--toc-->

# 1. Design Progress bar

Trước tiên, mình phác thảo ra giao diện mà mình sẽ làm. Giao diện khá đơn giản thôi. Đầu tiên là một cái *spinner* "quay quay" để chúng ta biết chương trình vẫn đang hoạt động. Tiếp theo là *thanh tiến trình* được fill theo đúng tỉ lệ phần trăm giá trị hiện tại so với giá trị lớn nhất. Cuối cùng là hiển thị *số liệu* hiện tại so với giá trị lớn nhất. Khi thànnh công thì spinner sẽ đổi thành dấu tick, nếu có lỗi thì spinner sẽ đổi thành dấu x biểu thị thất bại.

{{< image classes="fancybox center" thumbnail-width="100%" src="/images/post/console-progress-bar/2.png" title="Phác thảo giao diện chúng ta sẽ làm">}}

Dựa vào giao diện phác thảo ở trên, chúng ta có thể mường tượng được class `ProgressBar` sẽ có những phương thức như sau:

```java
   public class ProgressBar
-----------------------------------------------------
           void setMaxRange(double maxRange)
           void setValue(double value)
           void reportSuccess()
           void reportError()
           void render()
```

- *setMaxRange(double maxRange)*: Set giá trị lớn nhất của ProgressBar.
- *setValue(double value)*: Cập nhật giá trị hiện tại của ProgressBar.
- *reportSuccess()*: Gọi phương thức này để hiển thị dấu "tick" báo thành công.
- *reportError()*: Hiển thị dấu "x" báo thất bại.
- *render()*: Chịu trách nhiệm tính toán và print lên console.


# 2. Cài đặt Progress bar

Bài viết này, mình dùng Java để cài đặt. Với các ngôn ngữ khác cũng tương tự miễn là bạn hiểu tư tưởng cốt lõi.

## 2.1. Cơ bản

Trước hết, ta khai báo class `ProgressBar với các thuộc tính cơ bản:

- *width*: Thể hiện độ dài của thanh tiến trình.
- *value*: Giá trị hiện tại.
- *maxRange*: Giá trị lớn nhất.

{{< tabbed-codeblock ProgressBar>}}
    <!-- tab java -->
public class ProgressBar {
    private int width = 40;
    private double value = 0;
    private double maxRange = 100d;
}
    <!-- endtab -->
{{< /tabbed-codeblock >}}

Cài đặt các setter cho `value` và `maxRange`. Bạn có thể cài đặt thêm setter cho `width` cũng được.

```java
public void setMaxRange(double maxRange) {
    this.maxRange = maxRange;
}

public void setValue(double value) {
    this.value = value;
    this.render();
}
```

Tiếp theo chúng ta sẽ cài đặt hàm `render()` làm nhiệm vụ in toàn bộ thanh tiến trình lên màn hình console. Để in được thanh tiến trình, chúng ta làm các bước sau:

- Tính tỉ lệ giữa giá trị hiện tại và giá trị lớn nhất, quy về số lượng ô trong độ dài thanh tiến trình.
- In ra số ô đã hoàn thành bằng ký tự `#`.
- In các ô còn lại bằng ký tự `-`.

Để tiện tạo chuỗi lặp, các bạn có thể viết hàm utility sau:

```java
public class Strings {
    public static String repeat(char c, int count) {
        char[] arr = new char[count];
        Arrays.fill(arr, c);
        return new String(arr);
    }
}
```

Khi đó hàm `render()` sẽ như sau:

```java
public void render() {
    int currentBlock = (int) (value / maxRange * width);
    char symbol = 'o';
    String filledBlock = Strings.repeat('#', currentBlock);
    String remainBlock = Strings.repeat('-', width - currentBlock);
    String text = String.format("%s [%s%s] %.0f/%.0f\r", symbol, filledBlock, remainBlock, value, maxRange);
    System.out.print(text);
}
```

Test thử với hàm `main`.

```java
public static void main(String[] args) throws InterruptedException {
    final int MAX = 100;
    Random rand = new Random();
    ProgressBar p = new ProgressBar();
    p.setMaxRange(MAX);
    for (int i = 1; i <= 55; i++) {
        p.setValue(i);
        Thread.sleep(50 + rand.nextInt(300));
    }
}
```

Và kết quả là:

```text
o [######################------------------] 55/100
```

Cũng khá giống rồi phải không :laughing:. Ký tự `o` mình đặt trước ở vị trí đó để thay thế bằng cái spinner "quay quay" ở bước tiếp theo.

## 2.2. Animation với Timer

Để làm animation, chúng ta cần một chuỗi các ký tự thay đổi liên tục theo thời gian. Ở đây mình sẽ sử dụng chuỗi ký tự như bên dưới và khai báo vào class `ProgressBar`.

```java
private String animation = "⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏";
private int animationIndex = 0;
private final Timer timer;
```

Cài đặt một `TimerTask` vào constructor của `ProgressBar` để tăng `animationIndex` sau mỗi 100 ms.

```java
public ProgressBar() {
    timer = new Timer();
    timer.schedule(new TimerTask() {
        @Override
        public void run() {
            animationIndex++;
            render();
        }
    }, 100, 100);
}
```

Sửa lại một chút ở hàm `render()`:

```java
public void render() {
    int currentBlock = (int) (value / maxRange * width);
    char symbol = animation.charAt(animationIndex % animation.length());
    String filledBlock = Strings.repeat('#', currentBlock);
    String remainBlock = Strings.repeat('-', width - currentBlock);
    String text = String.format("%s [%s%s] %.0f/%.0f\r", symbol, filledBlock, remainBlock, value, maxRange);
    System.out.print(text);
}
```

Kết quả:

{{< image classes="fancybox center" thumbnail-width="100%" src="/images/post/console-progress-bar/3.gif" title="Kết quả sau khi làm animation với Timer">}}

Tuy nhiên, sau khi hoàn tất, chương trình không dừng lại, nó vẫn tiếp tục "quay quay" và chúng ta phải reset lại `Timer` để tắt animation. Để báo hiệu hoàn tất, chúng ta implement thêm method `stop()` bên trong class `ProgressBar` và gọi method này khi muốn dừng animation.

```java
public void stop() {
    timer.cancel();
}
```

## 2.3. Thành công và thất bại

Sau khi kết thúc tác vụ, cho dù là thành công hay thất bại, chúng ta đều phải ngưng animation lại, không hiển thị spinner nữa mà thay vào đó là icon biểu thị thành công hoặc thất bại.

Để làm điều này, chúng ta thêm vào 1 field `flag`, đồng thời cài đặt method `reportSuccess()` và `reportError()`.

```java
private int flag = 0;

public void reportSuccess() {
    this.flag = 1;
    this.render();
    this.stop();
}

public void reportError() {
    this.flag = -1;
    this.render();
    this.stop();
}
```

Phương thức `render()` cũng sửa lại một tí.

```java
private char getSymbol() {
    switch (flag) {
        case 1: return '\u2714';
        case -1: return '\u2718';
        default: return animation.charAt(animationIndex % animation.length());
    }
}
public void render() {
    int currentBlock = (int) (value / maxRange * width);
    char symbol = getSymbol();
    String filledBlock = Strings.repeat('#', currentBlock);
    String remainBlock = Strings.repeat('-', width - currentBlock);
    String text = String.format("%s [%s%s] %.0f/%.0f\r", symbol, filledBlock, remainBlock, value, maxRange);
    System.out.print(text);
}
```

Và giờ test lại với hàm `main()` với trường hợp thành công.

```java
public static void main(String[] args) throws InterruptedException {
    final int MAX = 100;
    Random rand = new Random();
    ProgressBar p = new ProgressBar();
    p.setMaxRange(MAX);
    for (int i = 1; i <= MAX; i++) {
        p.setValue(i);
        Thread.sleep(rand.nextInt(50));
    }
    p.reportSuccess();
}
```

Kết quả là:

{{< image classes="fancybox center" thumbnail-width="100%" src="/images/post/console-progress-bar/4.gif" title="Thành công!">}}

Cùng test trường hợp thất bại luôn nào.

```java
public static void main(String[] args) throws InterruptedException {
    final int MAX = 100;
    Random rand = new Random();
    ProgressBar p = new ProgressBar();
    p.setMaxRange(MAX);
    try {
        for (int i = 1; i <= MAX; i++) {
            p.setValue(i);
            Thread.sleep(50 + rand.nextInt(50));
            if (i >= 45) {
                throw new RuntimeException("Error while process");
            }
        }
        p.reportSuccess();
    } catch (Exception ex) {
        p.reportError();
    }
}
```

Và kết quả:

{{< image classes="fancybox center" thumbnail-width="100%" src="/images/post/console-progress-bar/5.gif" title="Thất bại!">}}

Vậy là chúng ta đã hoàn thiện một Progress Bar trên màn hình console với ngôn ngữ Java. Các bạn có thể tham khảo [source code](https://github.com/chidokun/console-progress-bar) của toàn bộ bài viết.

Khi nào rảnh mình sẽ hướng dẫn các bạn làm thêm một tí màu mè vào thanh Progress Bar nữa nhé :laughing:.