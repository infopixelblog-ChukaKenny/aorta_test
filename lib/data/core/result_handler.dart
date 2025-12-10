import 'dart:async';

import 'package:aorta/data/core/error/exceptions.dart';
import 'package:fpdart/fpdart.dart';

extension ResultHandlerX<T> on Future<Either<Exception, T>> {

  Future<T?> handleResult({
    Future<void> Function()? onLoading,
    Future<void> Function()? onLoadingStopped,
    Future<void> Function(T data)? onSuccess,
    Future<void> Function(ServerException error)? onServerError,
    Future<void> Function(TransactionException error)? onTransactionError,
    Future<void> Function(NetworkException error)? onNoNetwork,
    Future<void> Function(TimeoutException error)? onTimeout,
    Future<void> Function(CancelException error)? onCancelled,
  }) async {
    final completer = Completer<T?>();
    if (onLoading != null) {
      await onLoading();
    }

    final result = await this;

    if (onLoadingStopped != null) {
      await onLoadingStopped();
    }

    result.match(
          (error) async {
        // Handle known exception types
        if (error is ServerException) {
          await onServerError?.call(error);
          return;
        }

        if (error is TransactionException) {
          await onTransactionError?.call(error);
          return;
        }

        if (error is NetworkException) {
          if (onNoNetwork != null) {
            await onNoNetwork(error);
            return;
          }
        }

        if (error is TimeoutException) {
          if (onTimeout != null) {
            await onTimeout(error);
            return;
          }
        }

        if (error is CancelException || error is RequestCancelledException) {
          if (onCancelled != null) {
            await onCancelled(error is CancelException
                ? error
                : CancelException());
            return;
          }
        }

        // ⚠️ Fallback: unexpected or unhandled errors go to ServerError
        if (onServerError != null) {
          await onServerError(ServerException(
            message: error.toString(),
            title: "Unexpected Error",
            statusCode: 500,
          ));
        }
        completer.complete(null);
      },
          (data) async {
            await onSuccess?.call(data);
            completer.complete(data);
          },
    );
    return await completer.future;
  }
}