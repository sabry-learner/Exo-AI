import 'package:nasa_app/core/networking/api_constants.dart';

class SignInRequestBody {
  final String email;
  final String password;

  SignInRequestBody({required this.email, required this.password});
  toJson() => {ApiConstants.email: email, ApiConstants.password: password};
}
