import 'package:dartz/dartz.dart';
import 'package:nasa_app/core/networking/api_failure.dart';
import 'package:nasa_app/futures/auth/data/models/sign_in/sign_in_request_body.dart';
import 'package:nasa_app/futures/auth/data/models/sign_in/sign_in_response_body.dart';
import 'package:nasa_app/futures/auth/data/models/sign_up/sign_up_request_body.dart';
import 'package:nasa_app/futures/auth/data/models/sign_up/sign_up_response_body.dart';

abstract class AuthRepo {
  Future<Either<Failure, SignInResponseBody>> signInUser({
    required SignInRequestBody signInRequestBody,
  });
  Future<Either<Failure, SignUpResponseBody>> sinUpUser({
    required SignUpRequestBody signUpRequestModel,
  });
}
