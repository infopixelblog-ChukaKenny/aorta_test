import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';

const UNKNOWN_ERROR_STRING = "Unknown Error Occurred";
const NOT_LOGGED_IN_ERROR_STRING = "401";
const NETWORK_ERROR = "2";
const POOR_NETWORK = "3";

abstract class AortaNetworkcall {
  Future<Either<Exception, T>> get<T>(String route,
      {Map<String, dynamic>? queryParams,
      Options? options,
      bool requireAuth = true,
      ProgressCallback? onReceiveProgres,
      CancelToken? cancelToken,
      required T Function(Map<String, dynamic>) fromJson});

  Future<Either<Exception, List<T>>> getList<T>(
    String route, {
    Map<String, String>? queryParams,
    Options? options,
    bool requireAuth = true,
    ProgressCallback? onReceiveProgres,
    CancelToken? cancelToken,
    T Function(dynamic)? fromJson,
    Future<Either<Exception, List<T>>> Function()? fromCache,
  });

  Future<Either<Exception, T>> post<T, Y>(String route,
      {Map<String, String>? queryParams,
      Y? body,
      Options? options,
      bool requireAuth = true,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgres,
      required T Function(Map<String, dynamic>) fromJson});

  Future<Either<Exception, T>> delete<T, Y>(String route,
      {Map<String, String>? queryParams,
      Options? options,
      bool requireAuth = true,
      CancelToken? cancelToken,
      Y? body,
      required T Function(Map<String, dynamic>) fromJson});

  Future<Either<Exception, T>> put<T, Y>(String route,
      {Map<String, String>? queryParams,
      Y? body,
      Options? options,
      bool requireAuth = true,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgres,
      required T Function(Map<String, dynamic>) fromJson});

  Future<Either<Exception, List<T>>> postList<T , Y>(
      String route,
      {Map<String, String>? queryParams,
      Y? body,
      Options? options,
      bool requireAuth = true,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgres,
      T Function(Map<String, dynamic>)? fromJson});

  Future<Either<Exception, T>> patch<T, Y>(String route,
      {Map<String, String>? queryParams,
      Y? body,
      Options? options,
      bool requireAuth = true,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgres,
      required T Function(Map<String, dynamic>) fromJson});

  Future<Either<Exception, T>> downloadFile<T, Y>(
      String route, dynamic downloadPath,
      {Map<String, String>? queryParams,
      Options? options,
      bool requireAuth = true,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgres,
      required T Function(Map<String, dynamic>) fromJson});

  static AortaNetworkcall getInstance() {
    return GetIt.instance<AortaNetworkcall>();
  }


}
