import 'package:dio/dio.dart';

class ApiService {
  final Dio dio;

  ApiService(this.dio);

  Future<dynamic> get(
      {required String endpoint, Map<String, dynamic>? queryParameters}) async {
    final response = await dio.get(endpoint, queryParameters: queryParameters);
    return response.data;
  }

  Future<dynamic> post(
      {required String endpoint, required dynamic data}) async {
    final response = await dio.post(endpoint, data: data);
    return response.data;
  }

  Future<dynamic> put(
      {required String endpoint, dynamic queryParameters, dynamic data}) async {
    final response =
        await dio.put(endpoint, queryParameters: queryParameters, data: data);
    return response.data;
  }

  Future<dynamic> delete(
      {required String endpoint, Map<String, dynamic>? queryParameters}) async {
    final response =
        await dio.delete(endpoint, queryParameters: queryParameters);
    return response.data;
  }
}
