// ignore_for_file: unreachable_switch_default

import 'dart:convert';
import 'dart:developer';

import 'package:clay_rigging_bridle/common/network_client/api_response.dart';
import 'package:clay_rigging_bridle/utils/api_urls.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

typedef GetUserAuthTokenCallback = Future<String?> Function();

class NetworkClient {
  static const contentTypeJson = 'application/json';
  static const contentTypeMultipart = 'multipart/form-data';

  final Dio _restClient;
  final Dio _fileClient;
  // final AppUserRole _userRole;

  ///
  ///
  ///
  NetworkClient()
    : _restClient = _createDio(ApiUrls.baseUrl),
      _fileClient = _createDio(ApiUrls.baseUrl);

  ///
  ///
  ///
  Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool? sendUserAuth,
  }) async {
    try {
      final resp = await _restClient.get(
        path,
        queryParameters: queryParameters,
        options: await _createDioOptions(
          contentType: contentTypeJson,
          sendUserAuth: sendUserAuth,
        ),
      );

      final jsonData = resp.data;
      return ApiResponse<T>.success(
        statusCode: resp.statusCode,
        rawData: jsonData,
      );
    } on DioException catch (e) {
      return _createResponse<T>(e);
    }
  }

  ///
  ///
  ///
  Future<ApiResponse<T>> post<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    bool? sendUserAuth,
  }) async {
    try {
      final resp = await _restClient.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: await _createDioOptions(
          contentType: contentTypeJson,
          sendUserAuth: sendUserAuth,
        ),
      );

      final jsonData = resp.data;
      return ApiResponse<T>.success(
        statusCode: resp.statusCode,
        rawData: jsonData,
      );
    } on DioException catch (e) {
      return _createResponse<T>(e);
    }
  }

  ///
  ///
  ///
  Future<ApiResponse<T>> put<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    bool? sendUserAuth,
  }) async {
    try {
      final resp = await _restClient.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: await _createDioOptions(
          contentType: contentTypeJson,
          sendUserAuth: sendUserAuth,
        ),
      );

      final jsonData = resp.data;
      return ApiResponse<T>.success(
        statusCode: resp.statusCode,
        rawData: jsonData,
      );
    } on DioException catch (e) {
      return _createResponse<T>(e);
    }
  }

  ///
  ///
  ///
  Future<ApiResponse<T>> patch<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    bool? sendUserAuth,
  }) async {
    try {
      final resp = await _restClient.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: await _createDioOptions(
          contentType: contentTypeJson,
          sendUserAuth: sendUserAuth,
        ),
      );

      final jsonData = resp.data;
      return ApiResponse<T>.success(
        statusCode: resp.statusCode,
        rawData: jsonData,
      );
    } on DioException catch (e) {
      return _createResponse<T>(e);
    }
  }

  ///
  ///
  ///
  Future<ApiResponse<T>> delete<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    bool? sendUserAuth,
  }) async {
    try {
      final resp = await _restClient.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: await _createDioOptions(
          contentType: contentTypeJson,
          sendUserAuth: sendUserAuth,
        ),
      );

      final jsonData = resp.data;
      return ApiResponse<T>.success(
        statusCode: resp.statusCode,
        rawData: jsonData,
      );
    } on DioException catch (e) {
      return _createResponse<T>(e);
    }
  }

  ///
  ///
  ///
  Future<ApiResponse<T>> upload<T>(
    String path, {
    required XFile file,
    bool? sendUserAuth,
  }) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(file.path, filename: fileName),
      });

      final resp = await _fileClient.post(
        path,
        data: formData,
        options: await _createDioOptions(
          contentType: contentTypeMultipart,
          sendUserAuth: sendUserAuth,
        ),
      );

      final jsonData = resp.data;
      return ApiResponse<T>.success(
        statusCode: resp.statusCode,
        rawData: jsonData,
      );
    } on DioException catch (e) {
      return _createResponse<T>(e);
    }
  }

  ///
  ///
  ///
  ApiResponse<T> _createResponse<T>(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiResponse<T>.error(
          statusCode: 501,
          message: 'Connection timed out',
        );
      case DioExceptionType.connectionError:
        return ApiResponse<T>.error(
          statusCode: 502,
          message: 'Connection Error',
        );
      case DioExceptionType.unknown:
        return ApiResponse<T>.error(
          statusCode: 503,
          message:
              'Something went wrong, check your internet connection and try again later',
        );
      case DioExceptionType.receiveTimeout:
        return ApiResponse<T>.error(
          statusCode: 502,
          message: 'Receive timed out',
        );
      case DioExceptionType.sendTimeout:
        return ApiResponse<T>.error(
          statusCode: 500,
          message: 'Failed to connect to server',
        );
      case DioExceptionType.badResponse:
        try {
          // Ensure response data is always a Map<String, dynamic>
          final responseData =
              error.response?.data is String
                  ? json.decode(error.response?.data)
                  : error.response?.data;

          // Safely extract the 'errors' field
          final errorStr =
              responseData is Map<String, dynamic>
                  ? responseData['errors']?.toString() ?? 'Unknown error'
                  : 'Unknown error';

          // Safely extract the 'message' field
          final message =
              responseData is Map<String, dynamic>
                  ? responseData['message']?.toString() ??
                      'Unknown error message'
                  : 'Unknown error message';

          if (error.response?.statusCode == 402) {
            return ApiResponse<T>.error(
              statusCode: 402,
              error: errorStr,
              message: message.isNotEmpty ? message : 'Payment Required',
            );
          }
          if (error.response?.statusCode == 409) {
            return ApiResponse<T>.error(
              statusCode: 409,
              error: errorStr,
              message: message.isNotEmpty ? message : 'Conflict',
            );
          }
          return ApiResponse<T>.error(
            statusCode: error.response?.statusCode,
            error: errorStr,
            message: message,
          );
        } catch (e) {
          return ApiResponse<T>.error(
            statusCode: error.response?.statusCode ?? 500,
            message: 'Failed to process server response.',
          );
        }
      case DioExceptionType.cancel:
        return ApiResponse<T>.error(
          statusCode: 500,
          message: 'Request canceled',
        );
      case DioExceptionType.badCertificate:
        return ApiResponse<T>.error(
          statusCode: 500,
          message: 'Bad Certificate',
        );
      default:
        return ApiResponse<T>.error(
          statusCode: 500,
          message: 'Unknown error occurred',
        );
    }
  }

  ///
  ///
  ///
  Future<Options> _createDioOptions({
    required String contentType,
    bool? sendUserAuth,
  }) async {
    final headers = <String, String>{};

    final options = Options(headers: headers, contentType: contentType);
    return options;
  }

  ///
  ///
  ///
  static Dio _createDio(String baseUrl) {
    final options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    );
    final dio = Dio(options);
    dio.interceptors.add(
      LogInterceptor(
        request: false,
        requestHeader: false,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        logPrint: (message) {
          log(message.toString());
        },
      ),
    );
    return dio;
  }
}
