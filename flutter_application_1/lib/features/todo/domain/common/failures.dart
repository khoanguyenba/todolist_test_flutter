/// Các loại lỗi trong ứng dụng - đơn giản hóa
/// Chỉ cần 2 loại lỗi chính cho ứng dụng Todo

class ValidationFailure {
  final String message;
  const ValidationFailure(this.message);
}

class CacheFailure {
  final String message;
  const CacheFailure(this.message);
}
