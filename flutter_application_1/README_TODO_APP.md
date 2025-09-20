# Todo List App - Clean Architecture

Ứng dụng Todo List được xây dựng theo kiến trúc Clean Architecture với Flutter và BLoC pattern.

## Cấu trúc dự án

```
lib/
├── core/                           # Core layer - chứa các thành phần chung
│   ├── constants/                  # Các hằng số
│   ├── errors/                     # Định nghĩa các loại lỗi
│   │   └── failures.dart
│   ├── usecases/                   # Base use case
│   │   └── usecase.dart
│   └── utils/                      # Utilities
│       └── injection_container.dart
└── features/
    └── todo/                       # Todo feature
        ├── domain/                 # Domain layer - Business logic
        │   ├── entities/           # Business entities
        │   │   └── todo.dart
        │   ├── repositories/       # Repository interfaces
        │   │   └── todo_repository.dart
        │   └── usecases/           # Use cases
        │       ├── create_todo.dart
        │       ├── delete_todo.dart
        │       ├── get_all_todos.dart
        │       └── update_todo.dart
        ├── data/                   # Data layer - Data sources
        │   ├── datasources/        # Data sources
        │   │   └── todo_local_data_source.dart
        │   ├── models/             # Data models
        │   │   └── todo_model.dart
        │   └── repositories/       # Repository implementations
        │       └── todo_repository_impl.dart
        └── presentation/           # Presentation layer - UI
            ├── bloc/               # BLoC pattern
            │   ├── todo_bloc.dart
            │   ├── todo_event.dart
            │   └── todo_state.dart
            ├── pages/              # Pages/Screens
            │   └── todo_page.dart
            └── widgets/            # Reusable widgets
                ├── add_todo_dialog.dart
                ├── todo_filter_chips.dart
                └── todo_item.dart
```

## Kiến trúc Clean Architecture

### 1. Domain Layer (Entities, Use Cases, Repositories)
- **Entities**: Định nghĩa các đối tượng nghiệp vụ (Todo)
- **Use Cases**: Chứa logic nghiệp vụ cụ thể
- **Repositories**: Interface định nghĩa contract cho data access

### 2. Data Layer (Models, Data Sources, Repository Implementations)
- **Models**: Chuyển đổi giữa entities và data sources
- **Data Sources**: Truy cập dữ liệu (Local storage, API, etc.)
- **Repository Implementations**: Triển khai các interface từ domain layer

### 3. Presentation Layer (Pages, Widgets, BLoC)
- **Pages**: Các màn hình chính của ứng dụng
- **Widgets**: Các component UI có thể tái sử dụng
- **BLoC**: Quản lý state và business logic cho UI

## Tính năng

- ✅ Thêm todo mới
- ✅ Xem danh sách todos
- ✅ Đánh dấu hoàn thành/chưa hoàn thành
- ✅ Xóa todo
- ✅ Lọc todos theo trạng thái (Tất cả, Chưa hoàn thành, Đã hoàn thành)
- ✅ Lưu trữ dữ liệu local với SharedPreferences

## Dependencies

- **flutter_bloc**: State management
- **get_it**: Dependency injection
- **shared_preferences**: Local storage
- **uuid**: Tạo unique ID
- **equatable**: Value equality
- **dartz**: Functional programming

## Cách chạy

1. Cài đặt dependencies:
```bash
flutter pub get
```

2. Chạy ứng dụng:
```bash
flutter run
```

## Các nguyên tắc Clean Architecture được áp dụng

1. **Dependency Rule**: Dependencies chỉ hướng vào trong (inward)
2. **Separation of Concerns**: Mỗi layer có trách nhiệm riêng biệt
3. **Testability**: Dễ dàng test từng layer độc lập
4. **Maintainability**: Code dễ bảo trì và mở rộng
5. **Independence**: UI không phụ thuộc vào framework cụ thể


