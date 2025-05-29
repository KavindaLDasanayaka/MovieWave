import 'package:equatable/equatable.dart';
import 'package:moviewave/core/errors/exceptions.dart';

abstract class Failure extends Equatable {
  const Failure({required this.message, required this.statusCode});

  final String message;
  final int statusCode;

  String get errorMessage => message;
  String get errorMessageWithCode => '$statusCode Error: $message';

  @override
  List<Object> get props => [message, statusCode];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, required super.statusCode});

  ServerFailure.fromException(ServerException e)
    : this(message: e.message, statusCode: e.statusCode ?? 0);
}

class CacheFailure extends Failure {
  // 3 - Data not found in cache --> Just custom code I made up
  const CacheFailure({required super.message}) : super(statusCode: 3);

  CacheFailure.fromException(CacheException e) : this(message: e.message);
}
