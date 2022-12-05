// ignore_for_file: camel_case_types

import 'package:dio/dio.dart';

class Dio_Helper {
  static Dio? dio;
  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers: {'Content-Type': 'application/json'}));
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'lang':lang,
      'Authorization':token,
      'Content-Type': 'application/json'
    };
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> postData(
      {required String url,
      Map<String, dynamic>? query,
      String? lang,
      String? token,
      required Map<String, dynamic> data,}) async {
        dio!.options.headers = {
      'lang':lang,
      'Authorization':token,
      'Content-Type': 'application/json'
    };
    return dio!.post(url, queryParameters: query, data: data);
  }
    static Future<Response> putData(
      {required String url,
      Map<String, dynamic>? query,
      String? lang,
      String? token,
      required Map<String, dynamic> data,}) async {
        dio!.options.headers = {
      'lang':lang,
      'Authorization':token,
      'Content-Type': 'application/json'
    };
    return dio!.put(url, queryParameters: query, data: data);
  }
}
