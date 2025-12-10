import 'package:aorta/data/core/aorta_network_call.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fpdart/fpdart.dart';
import 'error/exceptions.dart';
import 'network_info.dart';

class NetworkCall extends AortaNetworkcall {
  final Dio dio;
  final NetworkInfo networkInfo;

  NetworkCall({required this.dio, required this.networkInfo});

  @override
  Future<Either<Exception, T>> get<T>(String route,
      {Map<String, dynamic>? queryParams,
      Options? options,
      bool requireAuth = true,
      ProgressCallback? onReceiveProgres,
      CancelToken? cancelToken,
      required T Function(Map<String, dynamic>) fromJson}) async {
    if (await networkInfo.isConnected) {
      try {
        final modifiedOptions = options ?? Options();
        modifiedOptions.headers ??= {};
        modifiedOptions.headers?['requireAuth'] = requireAuth.toString();
        final response = await dio.get(route,
            onReceiveProgress: onReceiveProgres,
            cancelToken: cancelToken,
            queryParameters: queryParams,
            options: options);

        final T result = parseResponse(response, fromJson);
        return Right(result);
      } on DioException catch (e) {
        debugPrint("DrioException $e");
        return Left(parseError(e));
      } on Exception catch (e) {
        debugPrint(e.toString());
        return Left(ServerException(message: UNKNOWN_ERROR_STRING));
      }
    } else {
      return Left(NetworkException());
    }
  }

  @override
  Future<Either<Exception, List<T>>> getList<T>(String route,
      {Map<String, dynamic>? queryParams,
      Options? options,
      bool requireAuth = true,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgres,
      T Function(dynamic)? fromJson,
      Future<Either<Exception, List<T>>> Function()? fromCache}) async {
    if (await networkInfo.isConnected) {
      try {
        final modifiedOptions = options ?? Options();
        modifiedOptions.headers ??= {};
        modifiedOptions.headers?['requireAuth'] = requireAuth.toString();
        final response = await dio.get(route,
            onReceiveProgress: onReceiveProgres,
            cancelToken: cancelToken,
            queryParameters: queryParams,
            options: options);

        // Check if the response is a list of maps
        final data = response.data;
        if (data is List) {
          final List<T> result = data
              .map((item) =>
                  (fromJson == null) ? item as T : fromJson(item as dynamic))
              .toList();
          return Right(result);
        } else {
          return Left(ServerException(message: UNKNOWN_ERROR_STRING));
        }
      } on DioException catch (e) {
        return Left(parseError(e));
      } on Exception catch (e) {
        debugPrint(e.toString());
        return Left(ServerException(message: UNKNOWN_ERROR_STRING));
      }
    } else {
      if (fromCache != null) {
        return await fromCache();
      }
      return Left(NetworkException());
    }
  }

  @override
  Future<Either<Exception, T>> post<T, Y>(String route,
      {Map<String, String>? queryParams,
      Y? body,
      CancelToken? cancelToken,
      Options? options,
      bool requireAuth = true,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgres,
      required T Function(Map<String, dynamic>) fromJson}) async {
    if (await networkInfo.isConnected) {
      try {
        final modifiedOptions = options ?? Options();
        modifiedOptions.headers ??= {};
        modifiedOptions.headers?['requireAuth'] = requireAuth.toString();
        final response = await dio.post(route,
            queryParameters: queryParams,
            data: body,
            options: options,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgres,
            cancelToken: cancelToken);
        final T result = parseResponse(response, fromJson);
        return Right(result);
      } on DioException catch (e) {
        return Left(parseError(e));
      } on Exception {
        return Left(ServerException(message: UNKNOWN_ERROR_STRING));
      } catch (e) {
        return Left(ServerException(message: UNKNOWN_ERROR_STRING));
      }
    } else {
      return Left(NetworkException());
    }
  }

  @override
  Future<Either<Exception, T>> put<T, Y>(String route,
      {Map<String, String>? queryParams,
      Y? body,
      Options? options,
      bool requireAuth = true,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgres,
      required T Function(Map<String, dynamic>) fromJson}) async {
    if (await networkInfo.isConnected) {
      try {
        final modifiedOptions = options ?? Options();
        modifiedOptions.headers ??= {};
        modifiedOptions.headers?['requireAuth'] = requireAuth.toString();
        final response = await dio.put(route,
            queryParameters: queryParams,
            data: body,
            options: options,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgres,
            cancelToken: cancelToken);
        final T result = parseResponse(response, fromJson);
        return Right(result);
      } on DioException catch (e) {
        return Left(parseError(e));
      } on Exception {
        return Left(ServerException(message: UNKNOWN_ERROR_STRING));
      } catch (e) {
        return Left(ServerException(message: UNKNOWN_ERROR_STRING));
      }
    } else {
      return Left(NetworkException());
    }
  }

  @override
  Future<Either<Exception, T>> delete<T, Y>(String route,
      {Map<String, String>? queryParams,
      Y? body,
      Options? options,
      bool requireAuth = true,
      CancelToken? cancelToken,
      required T Function(Map<String, dynamic>) fromJson}) async {
    if (await networkInfo.isConnected) {
      try {
        final modifiedOptions = options ?? Options();
        modifiedOptions.headers ??= {};
        modifiedOptions.headers?['requireAuth'] = requireAuth.toString();
        final response = await dio.delete(route,
            queryParameters: queryParams,
            data: body,
            options: options,
            cancelToken: cancelToken);
        final T result = parseResponse(response, fromJson);
        return Right(result);
      } on DioException catch (e) {
        return Left(parseError(e));
      } on Exception {
        return Left(ServerException(message: UNKNOWN_ERROR_STRING));
      } catch (e) {
        return Left(ServerException(message: UNKNOWN_ERROR_STRING));
      }
    } else {
      return Left(NetworkException());
    }
  }

  @override
  Future<Either<Exception, List<T>>> postList<T, Y>(
      String route,
      {Map<String, String>? queryParams,
      Y? body,
      Options? options,
      bool requireAuth = true,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgres,
      T Function(Map<String, dynamic>)? fromJson}) async {
    if (await networkInfo.isConnected) {
      try {
        final modifiedOptions = options ?? Options();
        modifiedOptions.headers ??= {};
        modifiedOptions.headers?['requireAuth'] = requireAuth.toString();
        final response = await dio.post(route,
            queryParameters: queryParams,
            data: body,
            options: options,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgres,
            cancelToken: cancelToken);
        final data = response.data;
        if (data is List) {
          final List<T> result = data
              .map((item) => (item! is Map<String, dynamic> || fromJson == null)
                  ? item as T
                  : fromJson(item as Map<String, dynamic>))
              .toList();
          return Right(result);
        } else {
          return Left(ServerException(message: UNKNOWN_ERROR_STRING));
        }
      } on DioException catch (e) {
        return Left(parseError(e));
      } on Exception {
        return Left(ServerException(message: UNKNOWN_ERROR_STRING));
      } catch (e) {
        return Left(ServerException(message: UNKNOWN_ERROR_STRING));
      }
    } else {
      return Left(NetworkException());
    }
  }

  @override
  Future<Either<Exception, T>> patch<T, Y>(String route,
      {Map<String, String>? queryParams,
      Y? body,
      Options? options,
      bool requireAuth = true,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgres,
      required T Function(Map<String, dynamic>) fromJson}) async {
    if (await networkInfo.isConnected) {
      try {
        final modifiedOptions = options ?? Options();
        modifiedOptions.headers ??= {};
        modifiedOptions.headers?['requireAuth'] = requireAuth.toString();
        final response = await dio.patch(route,
            queryParameters: queryParams,
            data: body,
            options: options,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgres,
            cancelToken: cancelToken);
        final T result = parseResponse(response, fromJson);
        return Right(result);
      } on DioException catch (e) {
        return Left(parseError(e));
      } on Exception {
        return Left(ServerException(message: UNKNOWN_ERROR_STRING));
      } catch (e) {
        return Left(ServerException(message: UNKNOWN_ERROR_STRING));
      }
    } else {
      return Left(NetworkException());
    }
  }

  Exception parseError(DioException e) {
    if (e.response != null) {
      if (e.response?.data is Map<String, dynamic>) {
        final message = e.response?.data as Map<String, dynamic>?;
        return (ServerException(
            message: message != null
                ? "${message["message"]}"
                : UNKNOWN_ERROR_STRING,
            title:
                message != null ? "${message["title"]}" : UNKNOWN_ERROR_STRING,
            statusCode: e.response?.statusCode ?? 500));
      } else {
        return (ServerException(
            message: e.response?.data?.toString() ?? UNKNOWN_ERROR_STRING,
            statusCode: e.response?.statusCode ?? 500));
      }
    } else {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return TimeoutException();

        case DioExceptionType.connectionError:
          return NetworkException();

        case DioExceptionType.cancel:
          {
            debugPrint("Upload cancelled");
            return RequestCancelledException();
          }

        default:
          return ServerException(
            message: UNKNOWN_ERROR_STRING,
            statusCode: e.response?.statusCode ?? 500,
          );
      }
    }
  }

  @override
  Future<Either<Exception, T>> downloadFile<T, Y>(
      String route, dynamic downloadPath,
      {Map<String, String>? queryParams,
      Options? options,
      bool requireAuth = true,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgres,
      required T Function(Map<String, dynamic> p1) fromJson}) async {
    if (await networkInfo.isConnected) {
      try {
        final modifiedOptions = options ?? Options();
        modifiedOptions.headers ??= {};
        modifiedOptions.headers?['requireAuth'] = requireAuth.toString();
        final response = await dio.download(route, downloadPath,
            queryParameters: queryParams,
            options: options,
            onReceiveProgress: onReceiveProgres,
            cancelToken: cancelToken);
        final T result = parseResponse(response.data, fromJson);
        return Right(result);
      } on DioException catch (e) {
        return Left(parseError(e));
      } on Exception {
        return Left(ServerException(message: UNKNOWN_ERROR_STRING));
      } catch (e) {
        return Left(ServerException(message: UNKNOWN_ERROR_STRING));
      }
    } else {
      return Left(NetworkException());
    }
  }

  parseResponse<T>(
      Response<dynamic> response, T Function(Map<String, dynamic>) fromJson) {
    try {
      if (response.data is Map<String, dynamic>) {
        return fromJson(response.data);
      } else {
        return response.data;
      }
    } catch (e) {
      return null;
    }
  }
}
