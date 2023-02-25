import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:posts_app/core/api/api_consumer.dart';
import 'package:posts_app/core/api/end_points.dart';
import 'package:posts_app/core/api/status_code.dart';
import 'package:posts_app/core/errors/exceptions.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;
  DioConsumer({required this.dio}) {
    dio.options
      ..baseUrl = EndPoints.baseUrl
      ..responseType = ResponseType.plain;
  }

  @override
  Future get({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get(path, queryParameters: queryParameters);
      return _handleResponseAsJson(response);
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future post({
    required String path,
    Map<String, dynamic>? body,
    bool formDataIsEnabled = false,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.post(
        path,
        queryParameters: queryParameters,
        data: formDataIsEnabled ? FormData.fromMap(body!) : body,
      );
      return _handleResponseAsJson(response);
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future put({
    required String path,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.put(path, queryParameters: queryParameters);
      return _handleResponseAsJson(response);
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future delete({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.delete(path, queryParameters: queryParameters);
      return _handleResponseAsJson(response);
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  dynamic _handleResponseAsJson(Response<dynamic> response) {
    final responseJson = jsonDecode(response.data.toString());
    return responseJson;
  }

  dynamic _handleDioError(DioError error) {
    switch (error.type) {
      case DioErrorType.badCertificate:
      case DioErrorType.unknown:
      case DioErrorType.connectionTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
      case DioErrorType.cancel:
        throw const FetchDataException();
      case DioErrorType.connectionError:
        throw const NoInternetConnectionException();
      case DioErrorType.badResponse:
        switch (error.response?.statusCode) {
          case StatusCode.badRequest:
            throw const BadRequestException();
          case StatusCode.unauthorized:
          case StatusCode.forbidden:
            throw const UnauthorizedException();
          case StatusCode.notFound:
            throw const NotFoundException();
          case StatusCode.confilct:
            throw const ConflictException();
          case StatusCode.internalServerError:
            throw const InternalServerErrorException();
        }
    }
  }
}
