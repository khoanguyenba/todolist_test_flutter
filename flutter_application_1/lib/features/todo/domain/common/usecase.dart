/// Base UseCase interface for domain layer
/// This replaces the core usecase to maintain domain independence
import 'result.dart';

abstract class UseCase<Type, Params> {
  Future<Result<Type>> call(Params params);
}

/// No parameters class for use cases that don't need parameters
class NoParams {
  const NoParams();
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is NoParams;
  
  @override
  int get hashCode => 0;
  
  @override
  String toString() => 'NoParams()';
}
