import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  DioFactory._();

  static Dio createDio({required String baseUrl}) {
    Duration defaultTimeout = const Duration(seconds: 30);

    Dio dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: defaultTimeout,
        receiveTimeout: defaultTimeout,
        sendTimeout: defaultTimeout,
      ),
    );

    // Logging interceptor
    dio.interceptors.add(
      PrettyDioLogger(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
      ),
    );

    return dio;
  }
}
