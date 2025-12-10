class ServerException implements Exception {
  final String? title;
  final String message;
  final int statusCode;
  ServerException(
      {required this.message, this.title = "", this.statusCode = 500});

  @override
  String toString() {
    return 'ServerException{title: $title, message: $message, statusCode: $statusCode}';
  }
}

class TransactionException implements Exception {
  final String message;
  final int errorCode;
  TransactionException(
      {required this.message, required this.errorCode });

  @override
  String toString() {
    return 'TransactionException{message $message, statusCode: $errorCode}';
  }
}

class InputException implements Exception {
  final String message;
  InputException({required this.message});
}

class NetworkException implements Exception {}

class RequestCancelledException implements Exception {}

class TimeoutException implements Exception {}

class CancelException implements Exception {}
