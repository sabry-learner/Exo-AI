import 'package:nasa_app/core/networking/api_constants.dart';

class SignInResponseBody {
  final String id;
  final String firstName;
  final String email;
  final String lastName;
  SignInResponseBody({
    required this.id,
    required this.firstName,
    required this.email,
    required this.lastName,
  });

  factory SignInResponseBody.fromJson(Map<String, dynamic> json) {
    return SignInResponseBody(
      id: json[ApiConstants.id],
      firstName: json[ApiConstants.firstNameResponse],
      email: json[ApiConstants.email],
      lastName: json[ApiConstants.lastNameResponse],
    );
  }
}
