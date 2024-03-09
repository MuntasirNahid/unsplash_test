import 'dart:io';

class ServerError extends HttpException {
  final int errorCode;

  ServerError(String message, {this.errorCode = HttpStatus.internalServerError})
      : super(message);
}

class UnauthorisedAccess extends HttpException {
  final int errorCode;

  UnauthorisedAccess(String message, {this.errorCode = HttpStatus.unauthorized})
      : super(message);
}

class RequestTimeout extends HttpException {
  final int errorCode;

  RequestTimeout(String message, {this.errorCode = HttpStatus.requestTimeout})
      : super(message);
}
