// ignore_for_file: avoid_annotating_with_dynamic

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:robbie_starter/core/errors/exceptions.dart';
import 'package:robbie_starter/core/utils/logger.dart';

/// HTTP client wrapper for API calls
@singleton
class ApiClient {
  ApiClient(this._dio) {
    _setupInterceptors();
  }

  final Dio _dio;

  void _setupInterceptors() {
    _dio.interceptors.addAll([
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (object) => Logger.debug(object.toString()),
      ),
      InterceptorsWrapper(
        onError: (error, handler) {
          Logger.error('API Error: ${error.message}', error);
          handler.next(error);
        },
      ),
    ]);
  }

  /// GET request
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  /// POST request
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  /// PUT request
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  /// DELETE request
  Future<Response<T>> delete<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.delete<T>(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  AppException _mapDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkException(message: 'Connection timeout');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        if (statusCode == 401) {
          return const AuthenticationException(message: 'Unauthorized');
        } else if (statusCode == 403) {
          return const AuthorizationException(message: 'Forbidden');
        } else if (statusCode == 404) {
          return const NotFoundException(message: 'Resource not found');
        } else {
          return ServerException(
            message: 'Server error: ${e.response?.statusMessage}',
          );
        }
      case DioExceptionType.cancel:
        return const ServerException(message: 'Request cancelled');
      case DioExceptionType.connectionError:
        return const NetworkException(message: 'No internet connection');
      case DioExceptionType.unknown:
        return const ServerException(message: 'Unexpected error occurred');
      case DioExceptionType.badCertificate:
        throw UnimplementedError();
    }
  }
}
