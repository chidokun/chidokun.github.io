---
title: "Danh sách liên kết kép và các thao tác cơ bản"
slug: "doubly-linked-list"
date: 2015-08-17T22:25:00+07:00
draft: false
categories:
- "Lập trình"
- "Cấu trúc dữ liệu"
tags:
- "c/c++"
- "linked list"
keywords:
- "danh sách liên kết kép"
- "c/c++"
thumbnailImage: /thumbnails/heap.png
thumbnailImagePosition: left
---

Nếu bạn đã đọc bài viết về [Danh sách liên kết đơn]({{< ref "/posts/software/linked-list" >}}) thì có thể thấy việc tổ chức dạng danh sách tiện lợi hơn rất nhiều so với dùng mảng. Tuy nhiên, danh sách liên kết đơn vẫn có nhược điểm là chỉ có thể duyệt từ đầu đến cuối. Vì vậy, một số thao tác sẽ rất khó cài đặt trên nó. Danh sách liên kết kép có thể khắc phục nhược điểm này. Hầu hết các thao tác điều giống với danh sách liên kết đơn nhưng mình cũng khuyên các bạn nên đọc bài viết [Danh sách liên kết đơn và các thao tác cơ bản]({{< ref "/posts/software/linked-list" >}}) trước khi đọc bài viết này. Các thao tác được minh họa bằng C++.


<!--more-->

# Tổ chức dữ liệu

Với danh sách liên kết kép, mỗi phần tử sẽ liên kết với phần tử đứng trước và sau nó trong danh sách.
Mỗi phần tử trong danh sách (node) gồm biến lưu dữ liệu và 2 con trỏ liên kết tới phần tử trước và sau nó.

Khai báo phần tử của danh sách:

```cpp
struct Node
{
   <datatype> info;
   Node  *prev, *next;
};
```

Một danh sách thì gồm nhiều phần tử, các phần tử đã liên kết nhau, mà đây là cấu trúc dữ liệu động nên ta cần biết phần tử đầu và phần tử cuối của danh sách.

Khai báo cấu trúc danh sách:

```cpp
struct List
{
   Node *head, *tail;
}
```

Có thể minh họa danh sách liên kết kép như sau:

{{< image classes="fancybox center" thumbnail-width="100%" src="/images/post/software/doubly-linked-list/1.png">}}

# Các thao tác cơ bản

## Tạo danh sách rỗng

Khi bạn tạo một biến kiểu `List` như trên thì 2 con trỏ thành viên được tạo ra, tuy nhiên chúng chưa được khởi tạo giá trị. Thao tác với con trỏ rỗng thì nguy hiểm nên cần thiết phải gán `NULL` cho 2 con trỏ này.

```cpp
void CreateList(List &list)
{
   list.head = list.tail = NULL;
}
```

## Đưa dữ liệu vào node

Mọi dữ liệu của bạn phải được đóng gói thành "phần tử của danh sách" trước khi thêm vào danh sách và cài đặt dưới đây sẽ giúp thực hiện điều đó.

```cpp
Node* CreateNode(<datatype> data)
{
   Node* node = new Node;
   if (node)
   {
      node->info = data;
      node->prev = node->next = NULL;
   }
}
```

Việc gán `NULL` cho biến con trỏ mới khởi tạo luôn luôn là cần thiết để tránh nguy hiểm.

## Thêm node vào danh sách

Có 4 cách thêm: vào đầu, vào cuối, sau 1 node và trước 1 node. Nguyên tắc thêm vào giống hệt danh sách liên kết đơn (bạn có thể xem lại bài viết về DSLK đơn nếu muốn), chỉ có phần điều chỉnh lại liên kết là khác.

```cpp
void AddHead(List &list, Node* node)
{
   if (!list.head)
      list.head = list.tail = node;
   else
   {
      node->next = list.head;
      list.head->prev = node;
      list.head = node;
   }
}

void AddTail(List &list, Node* node)
{
   if (!list.head)
      list.head = list.tail = node;
   else
   {
      node->prev = list.tail;
      list.tail->next = node;
      list.tail = node;
   }
}

void AddAfter(List &list, Node* node, Node* after)
{
   if (after)
   {
      node->prev = after;
      node->next = after->next;
      after->next = node;
      if (list.tail != after)
         after->next->prev = node;
      if (list.tail == after) list.tail = after;
   }
   else
      AddHead(list, node);
}

void AddBefore(List &list, Node* node, Node* before)
{
   if (before)
   {
      node->next = before;
      node->prev = before->prev;
      if (list.head != before)
         before->prev->next = node;
      if (list.head == before)
         list.head = before;
   }
   else
      AddTail(list, node);
}
```

## Duyệt danh sách

Duyệt danh sách là thao tác đi đến từng phần tử để thực hiện một công việc nào đó (in ra màn hình, tính tổng, v.v...). Có 2 thao tác duyệt là duyệt xuôi và duyệt ngược. Ở đây mình cài đặt bằng vòng lặp `for`, bạn muốn cài đặt lại bằng `while` cũng được.

```cpp
void BrowseNext(List list)
{
   for (Node*i = list.head; i; i = i->next)
   {
      ///
   }
}

void BrowsePrev(List list)
{
   for (Node*i = list.tail; i; i = i->prev)
   {
      ///
   }
}
```

## Tìm phần tử

Ta sẽ tìm bằng phương pháp tìm kiếm tuần tự.

```cpp
Node* SearchNode(List list, int key)
{
   Node *i = list.head;
   while (i && i->info != key)
      i = i->next;
   return i;
}
```

## Xóa phần tử và cả danh sách

Có các trường hợp như sau: xóa đầu, xóa cuối, xóa phần tử trước 1 phần tử xác định, xóa phần tử sau 1 phần tử xác định, xóa một 1 phần tử xác định và xóa cả danh sách.

Nguyên tắc xóa cơ bản giống hệt như đối với danh sách liên kết đơn.

```cpp
void RemoveHead(List &list)
{
   if (!list.head)
      cout << "List is empty!" << endl;
   else if (list.head == list.tail)
   {
      delete list.head;
      list.head = list.tail = NULL;
   }
   else
   {
      Node *temp = list.head;
      list.head->next->prev = NULL;
      list.head = list.head->next;
      delete temp;
   }
}

void RemoveTail(List &list)
{
   if (!list.head)
      cout << "List is empty!" << endl;
   else if (list.head == list.tail)
   {
      delete list.head;
      list.head = list.tail = NULL;
   }
   else
   {
      Node* temp = list.tail;
      list.tail->prev->next = NULL;
      list.tail = list.tail->prev;
      delete temp;
   }
}

void RemoveAfter(List &list, Node* node)
{
   if (list.tail != node)
   {
      Node* temp = node->next;
      node->next->prev = node;
      node->next = node->next->next;
      delete temp;
   }
}

void RemoveBefore(List &list, Node* node)
{
   if (list.head != node)
   {
      Node* temp = node->prev;
      node->prev->next = node;
      node->prev = node->prev->prev;
      delete temp;
   }
}

void RemoveList(List &list)
{
   Node* i;
   while (list.head)
   {
      i = list.head;
      list.head = list.head->next;
      delete i;
   }
}

void RemoveKey(List &list, <datatype> key)
{
   Node* result = SearchNode(list, key);
   if (result)
   {
      if (result == list.head)
         RemoveHead(list);
      else if (result == list.tail)
         RemoveTail(list);
      else
      {
         result->prev->next = result->next;
         result->next->prev = result->prev;
         delete result;
      }
   }
   else
      cout << "Key is not found!";      
}
```

## Sắp xếp danh sách

Danh sách liên kết kép cũng có 2 kiểu sắp xếp: Đổi dữ liệu giữa các node và đổi liên kết giữa các node tương tự như danh sách liên kết đơn.