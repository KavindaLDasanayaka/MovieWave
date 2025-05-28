import 'package:equatable/equatable.dart';

class ResponseError extends Equatable {
  const ResponseError({
    required this.status,
    required this.errorMessage,
  });

  final bool status;
  final String errorMessage;

  @override
  List<Object?> get props => [status, errorMessage];

  factory ResponseError.fromString(String? message) {
    return ResponseError(
      status: false,
      errorMessage: message ?? "Unknown Error Occured!",
    );
  }

  String get message => errorMessage;
}
