import 'package:nasa_app/core/networking/api_constants.dart';

class SignUpRequestBody {
  final String firstName;
  final String lastName;
  final String password;
  final String email;

  SignUpRequestBody({
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.email,
  });
  toJson() => {
    ApiConstants.firstNameRequest: firstName,
    ApiConstants.lastNameRequest: lastName,
    ApiConstants.password: password,
    ApiConstants.email: email,
  };
}
