/// Kết quả trả về - đơn giản hóa cho người mới
/// Có 2 loại: Thành công (Success) hoặc Thất bại (Failure)
abstract class Result<T> {
  const Result();
  
  /// Kiểm tra xem có thành công không
  bool get isSuccess => this is Success<T>;
  
  /// Kiểm tra xem có thất bại không  
  bool get isFailure => this is Failure<T>;
  
  /// Lấy dữ liệu nếu thành công, null nếu thất bại
  T? get data => isSuccess ? (this as Success<T>).data : null;
  
  /// Lấy lỗi nếu thất bại, null nếu thành công
  String? get error => isFailure ? (this as Failure<T>).message : null;
}

/// Kết quả thành công - chứa dữ liệu
class Success<T> extends Result<T> {
  final T data;
  
  const Success(this.data);
  
  @override
  String toString() => 'Success($data)';
}

/// Kết quả thất bại - chứa thông báo lỗi
class Failure<T> extends Result<T> {
  final String message;
  
  const Failure(this.message);
  
  @override
  String toString() => 'Failure($message)';
}
