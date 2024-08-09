import 'package:dio/dio.dart';
export 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../utils/constants.dart';

class NetworkClass {
  final Dio _dio = Dio();

  //Get/Fetch
  Future<Response> get(
      {required String endPoint, Map<String, dynamic>? headerData}) async {
    try {
      Map<String, dynamic> headers = headerData ?? await this.headers();
      String url = '${Constants.baseUrl}$endPoint';
      Response response =
          await _dio.get(url, options: Options(headers: headers));
      return response;
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    } catch (e) {
      throw "Unexpected error: $e";
    }
  }

  //Create/Add
  Future<Response> post(
      {required String endPoint,
      Map<String, dynamic>? headerData,
      required Map<String, dynamic> data}) async {
    try {
      Map<String, dynamic> headers = headerData ?? await this.headers();
      String url = '${Constants.baseUrl}$endPoint';
      Response response =
          await _dio.post(url, options: Options(headers: headers), data: data);
      return response;
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    } catch (e) {
      throw "Unexpected error: $e";
    }
  }

  //Update
  Future<Response> put(
      {required String endPoint,
      Map<String, dynamic>? headerData,
      required Map<String, dynamic> data}) async {
    try {
      Map<String, dynamic> headers = headerData ?? await this.headers();
      String url = '${Constants.baseUrl}$endPoint';
      Response response =
          await _dio.put(url, options: Options(headers: headers), data: data);
      return response;
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    } catch (e) {
      throw "Unexpected error: $e";
    }
  }

  //Delete
  Future<Response> delete({
    required String endPoint,
    Map<String, dynamic>? headerData,
  }) async {
    try {
      Map<String, dynamic> headers = headerData ?? await this.headers();
      String url = '${Constants.baseUrl}$endPoint';
      Response response =
          await _dio.delete(url, options: Options(headers: headers));
      return response;
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    } catch (e) {
      throw "Unexpected error: $e";
    }
  }

  //To Retrieve Some header Details From Local Storage or Cache Memory
  Future<Map<String, dynamic>> headers() async {
    Map<String, dynamic> headers = {};
    return headers;
  }

  //To Handle The Dio Exception Like Connection Errors
  void _handleDioError(DioException e) {
    if (e.response != null) {
      debugPrint("Connection Error: ${e.response?.statusCode}, ${e.message}");
      throw "Connection Error: ${e.response?.statusCode}";
    } else {
      debugPrint("Connection Error: ${e.message}");
      throw "Connection Error: Connection Refused";
    }
  }
}
