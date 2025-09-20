# 📱 Todo List App - Clean Architecture (Đơn Giản)

## 🎯 **Dành cho người mới bắt đầu với Flutter & Dart**

Đây là ứng dụng Todo List được xây dựng theo Clean Architecture nhưng **đơn giản hóa** để dễ hiểu cho người mới.

## 🏗️ **Cấu trúc đơn giản**

```
lib/
├── main.dart                    # 🚀 Điểm khởi đầu của app
├── core/                        # 🔧 Các tiện ích chung
│   └── utils/
│       └── injection_container.dart  # Quản lý dependencies
└── features/todo/               # 📝 Tính năng Todo
    ├── domain/                  # 🧠 Logic nghiệp vụ (không phụ thuộc Flutter)
    │   ├── common/              # Các class chung
    │   │   ├── result.dart      # Kết quả: Thành công hoặc Thất bại
    │   │   ├── failures.dart    # Các loại lỗi
    │   │   └── usecase.dart     # Interface cho use cases
    │   ├── entities/            # Đối tượng chính
    │   │   └── todo.dart        # Todo - công việc cần làm
    │   ├── repositories/        # Interface để lưu trữ dữ liệu
    │   │   └── todo_repository.dart
    │   └── usecases/            # Logic nghiệp vụ cụ thể
    │       ├── get_all_todos.dart    # Lấy tất cả todos
    │       ├── create_todo.dart      # Tạo todo mới
    │       ├── update_todo.dart      # Sửa todo
    │       └── delete_todo.dart      # Xóa todo
    ├── data/                    # 💾 Lưu trữ dữ liệu
    │   ├── models/              # Chuyển đổi dữ liệu
    │   ├── datasources/         # Nguồn dữ liệu (SharedPreferences)
    │   └── repositories/        # Triển khai repository
    └── presentation/            # 🎨 Giao diện người dùng
        ├── bloc/                # Quản lý trạng thái
        │   ├── todo_bloc.dart   # BLoC chính
        │   ├── todo_event.dart  # Các sự kiện (tạo, xóa, sửa...)
        │   └── todo_state.dart  # Các trạng thái (loading, loaded, error...)
        ├── pages/               # Màn hình
        │   └── todo_page.dart   # Màn hình chính
        └── widgets/             # Các component UI
            ├── add_todo_dialog.dart      # Dialog thêm todo
            ├── todo_item.dart            # Item hiển thị todo
            └── todo_filter_chips.dart    # Nút lọc todo
```

## 🔄 **Luồng hoạt động đơn giản**

### 1. **Người dùng nhấn nút "Thêm Todo"**
```
UI → Event (CreateTodo) → BLoC → Use Case → Repository → Data Source → SharedPreferences
```

### 2. **Dữ liệu trả về**
```
SharedPreferences → Data Source → Repository → Use Case → BLoC → State → UI
```

## 📚 **Các khái niệm cơ bản**

### **1. Entity (Todo)**
```dart
class Todo {
  final String id;           // ID duy nhất
  final String title;        // Tiêu đề
  final String description;  // Mô tả
  final bool isCompleted;    // Đã hoàn thành?
  final DateTime createdAt;  // Thời gian tạo
}
```

### **2. Use Case (Business Logic)**
```dart
class GetAllTodos {
  Future<Result<List<Todo>>> call() async {
    // Logic để lấy tất cả todos
  }
}
```

### **3. BLoC (State Management)**
```dart
class TodoBloc extends Bloc<TodoEvent, TodoState> {
  // Xử lý các sự kiện và cập nhật trạng thái
}
```

### **4. Result (Kết quả)**
```dart
// Thành công
Success<List<Todo>>(data: todos)

// Thất bại  
Failure<List<Todo>>(message: "Lỗi không thể tải dữ liệu")
```

## 🚀 **Cách chạy ứng dụng**

```bash
# 1. Cài đặt dependencies
flutter pub get

# 2. Chạy ứng dụng
flutter run
```

## 🎯 **Tính năng**

- ✅ **Thêm todo mới** - Nhập tiêu đề và mô tả
- ✅ **Xem danh sách todos** - Hiển thị tất cả công việc
- ✅ **Đánh dấu hoàn thành** - Click checkbox để đánh dấu
- ✅ **Xóa todo** - Nhấn nút xóa với xác nhận
- ✅ **Lọc todos** - Xem tất cả, đã hoàn thành, chưa hoàn thành
- ✅ **Lưu trữ local** - Dữ liệu được lưu trên thiết bị

## 💡 **Tại sao Clean Architecture?**

1. **Dễ hiểu** - Mỗi phần có trách nhiệm riêng
2. **Dễ test** - Có thể test từng phần độc lập
3. **Dễ bảo trì** - Sửa một phần không ảnh hưởng phần khác
4. **Dễ mở rộng** - Thêm tính năng mới dễ dàng

## 🔧 **Dependencies chính**

- `flutter_bloc` - Quản lý trạng thái
- `get_it` - Quản lý dependencies
- `shared_preferences` - Lưu trữ local
- `uuid` - Tạo ID duy nhất

## 📖 **Học thêm**

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [BLoC Pattern](https://bloclibrary.dev/)
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

---

**Chúc bạn học tập vui vẻ! 🎉**
