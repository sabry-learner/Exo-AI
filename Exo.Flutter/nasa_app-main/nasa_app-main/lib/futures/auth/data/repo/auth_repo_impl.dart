import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nasa_app/core/database/my_cache_helper.dart';
import 'package:nasa_app/core/database/prefs_constants.dart';
import 'package:nasa_app/core/networking/api_endpoints.dart';
import 'package:nasa_app/core/networking/api_failure.dart';
import 'package:nasa_app/core/networking/api_services.dart';
import 'package:nasa_app/futures/auth/data/models/sign_in/sign_in_request_body.dart';
import 'package:nasa_app/futures/auth/data/models/sign_in/sign_in_response_body.dart';
import 'package:nasa_app/futures/auth/data/models/sign_up/sign_up_request_body.dart';
import 'package:nasa_app/futures/auth/data/models/sign_up/sign_up_response_body.dart';
import 'package:nasa_app/futures/auth/data/repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final ApiService _apiService;

  AuthRepoImpl(this._apiService);
  @override
  Future<Either<Failure, SignInResponseBody>> signInUser({
    required SignInRequestBody signInRequestBody,
  }) async {
    try {
      var result = await _apiService.post(
        endpoint: ApiEndPoint.signIn,
        data: signInRequestBody.toJson(),
      );
      var data = SignInResponseBody.fromJson(result);
      SharedPrefHelper.setData(PrefsConstants.token, data.id);
      return right(data);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure('something went wrong'));
    }
  }

  @override
  Future<Either<Failure, SignUpResponseBody>> sinUpUser({
    required SignUpRequestBody signUpRequestModel,
  }) async {
    try {
      var result = await _apiService.post(
        endpoint: ApiEndPoint.signUp,
        data: signUpRequestModel.toJson(),
      );
      var data = SignUpResponseBody.fromJson(result);
      SharedPrefHelper.setData(PrefsConstants.token, data.id);

      return right(data);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure('something went wrong'));
    }
  }
}
