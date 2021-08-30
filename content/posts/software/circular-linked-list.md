---
title: "Danh sách liên kết vòng và một số thao tác"
slug: "circular-linked-list"
date: 2015-08-19T21:04:00+07:00
draft: false
categories:
- "Lập trình"
- "Cấu trúc dữ liệu"
tags:
- "c/c++"
- "linked list"
keywords:
- "danh sách liên kết vòng"
- "c/c++"
thumbnailImage: /thumbnails/heap.png
thumbnailImagePosition: left
---

Chúng ta cùng tìm hiểu một cấu trúc dữ liệu cũng khá hữu ích là Danh sách liên kết vòng (Circular Linked List). Nó biểu diễn một cách tự nhiên các cấu trúc dạng tròn như các góc của đa giác, v.v... DSLK vòng có hai dạng thường thấy là dạng *vòng đơn* và *vòng kép*.

<!--more-->

Dạng vòng đơn thực chất là một [danh sách liên kết đơn]({{< ref "/posts/software/linked-list" >}}) có phần tử cuối trỏ về phần tử đầu tiên. Nó cũng có nhược điểm là chỉ duyệt từ một chiều. Dạng vòng kép cũng là một [danh sách liên kết kép]({{< ref "/posts/software/doubly-linked-list" >}}) có phần tử cuối trỏ về đầu và đầu trỏ ngược về cuối.

Với DSLK vòng ta cần biết một vài thao tác cơ bản đủ dùng và các thao tác này sẽ được minh họa bằng C++. Bài này chỉ nói về danh sách liên kết vòng kép và bạn cũng nên sử dụng vòng kép để việc code lại đơn giản hơn.

# Tổ chức dữ liệu

Một danh sách gồm có các phần tử gọi là node, mỗi node gồm 1 biến chứa dữ liệu và một hoặc nhiều biến con trỏ để liên kết với các node khác. Dưới đây là khai báo cấu trúc node:

```cpp
struct DoublyNode
{
   <datatype> info;
   DoublyNode* prev, *next;
};
```

Do cấu trúc này ở dạng vòng nên một danh sách ta chỉ cần chọn một phần tử đầu thôi.

```cpp
struct DoublyList
{
   DoublyNode* head;
};
```

# Các thao tác cơ bản

## Tạo danh sách rỗng

Do đặc điểm của cách cài đặt hướng cấu trúc và dùng con trỏ trong C++ nên cần thiết phải tạo danh sách rỗng bằng cách gán `NULL` cho phần tử đầu.

```cpp
void CreateList(DoublyList &list)
{
   list.head = NULL;
}
```

## Đưa dữ liệu vào node

Đơn giản là đưa dữ liệu của bạn vào một node để có thể thêm vào danh sách.

```cpp
DoublyNode* CreateNode(<datatype> data)
{
   DoublyNode* node = new DoublyNode;
   if (node)
   {
      node->info = data;
      node->next = node->prev = NULL;
   }
   return node;
}
```

## Thêm node vào danh sách

Ở đây ta chỉ cần 2 trường hợp: thêm trước 1 node và thêm sau 1 node (mà thực ra cũng chỉ cần thêm trước 1 node là đủ dùng), nhưng mình cũng code thêm hàm thêm vào cuối (có thể hiểu như thêm trước phần tử đầu).

```cpp
void AddTail(DoublyList &list, DoublyNode* node)
{
   if (!list.head)
   {
      list.head = node;
      node->next = node->prev = list.head;
   }
   else
   {
      node->prev = list.head->prev;
      node->next = list.head;
      list.head->prev->next = node;
      list.head->prev = node;
   }
}

void AddBefore(DoublyList &list, DoublyNode* node, DoublyNode* before)
{
   if (!before)
   {
      list.head = node;
      node->next = node->prev = list.head;
   }
   else
   {
      node->prev = before->prev;
      node->next = before;
      before->prev->next = node;
      before->prev = node;
   }
}

void AddAfter(DoublyList &list, DoublyNode* node, DoublyNode* after)
{
   if (!after)
   {
      list.head = node;
      node->next = node->prev = list.head;
   }
   else
   {
      node->prev = after;
      node->next = after->next;
      after->next->prev = node;
      after->next = node;
   }
}
```

## Duyệt danh sách

Duyệt là đến từng phần tử để thực hiện thao tác nào đó. Trong DSLK vòng phải có một điều kiện dừng nào đó để dừng duyệt (nếu không nó cứ đi lòng vòng). Cái này mình không nói cụ thể ở đây mà tùy trường hợp cụ thể điều kiện dừng sẽ khác nhau.

```cpp
void Browse(DoublyList list)
{
   for (DoublyNode* i = list.head; <condition>; i=i->next)
   {
      ///
   }
}
```

## Xóa phần tử và danh sách

Ở đây ta chỉ quan tâm việc xóa một phần tử cụ thể và xóa danh sách.

```cpp
void RemoveKey(DoublyList &list, int key)
{
   DoublyNode *i = list.head;
   do
   {
      if (i->info == key)
      {
         i->prev = i->next;
         i->next = i->prev;
         if (i == list.head)
            list.head = NULL;
         delete i;
         break;
      }
      i = i->next;
   } while (i != list.head);
}

void RemoveList(DoublyList &list)
{
   DoublyNode *i = NULL;
   do 
   {
      i = list.head;
      list.head->prev->next = list.head->next;
      list.head->next->prev = list.head->next;
      list.head = list.head->next;
      delete i;
      if (!i) list.head = NULL;
   } while (!list.head)
}
```

Các thao tác cơ bản này đã đủ dùng với danh sách liên kết vòng. Tuy nhiên các cài đặt trên chỉ là cài đặt mẫu, bạn cần phải cài đặt linh động hơn trong một số thao tác để giải quyết bài toán nhanh hơn.