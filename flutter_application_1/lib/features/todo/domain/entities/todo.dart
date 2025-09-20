/// Todo - Đối tượng chính của ứng dụng
/// Chứa thông tin về một công việc cần làm
class Todo {
  final String id;           // ID duy nhất
  final String title;        // Tiêu đề công việc
  final String description;  // Mô tả chi tiết
  final bool isCompleted;    // Đã hoàn thành chưa?
  final DateTime createdAt;  // Thời gian tạo
  final DateTime? updatedAt; // Thời gian cập nhật (có thể null)

  const Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.createdAt,
    this.updatedAt,
  });

  /// Tạo bản sao Todo với một số thông tin thay đổi
  /// Ví dụ: todo.copyWith(isCompleted: true)
  Todo copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// So sánh 2 Todo có giống nhau không
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is Todo &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.isCompleted == isCompleted &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  /// Mã hash để sử dụng trong Map, Set
  @override
  int get hashCode {
    return Object.hash(
      id,
      title,
      description,
      isCompleted,
      createdAt,
      updatedAt,
    );
  }

  /// Hiển thị thông tin Todo dưới dạng text
  @override
  String toString() {
    return 'Todo(id: $id, title: $title, isCompleted: $isCompleted)';
  }
}


