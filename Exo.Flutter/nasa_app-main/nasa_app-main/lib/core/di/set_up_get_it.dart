import 'package:get_it/get_it.dart';
import 'package:nasa_app/core/networking/api_endpoints.dart';
import 'package:nasa_app/core/networking/api_services.dart';
import 'package:nasa_app/core/networking/dio_factory.dart';
import 'package:nasa_app/futures/auth/data/repo/auth_repo_impl.dart';
import 'package:nasa_app/futures/upload/data/repo/upload_repo_impl.dart';

final GetIt getIt = GetIt.instance;

void setUpGetIt() {
  // Auth
  final authDio = DioFactory.createDio(baseUrl: ApiEndPoint.authBaseUrl);
  getIt.registerLazySingleton<ApiService>(
    () => ApiService(authDio),
    instanceName: "AuthApi",
  );
  getIt.registerLazySingleton<AuthRepoImpl>(
    () => AuthRepoImpl(getIt<ApiService>(instanceName: "AuthApi")),
    instanceName: "AuthRepo",
  );

  // Data
  final dataDio = DioFactory.createDio(baseUrl: ApiEndPoint.dataBaseUrl);
  getIt.registerLazySingleton<ApiService>(
    () => ApiService(dataDio),
    instanceName: "DataApi",
  );
  getIt.registerLazySingleton<UploadRepoImpl>(
    () => UploadRepoImpl(getIt<ApiService>(instanceName: "DataApi")),
    instanceName: "DataRepo",
  );
}
