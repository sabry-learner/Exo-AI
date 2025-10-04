import 'package:nasa_app/core/networking/api_constants.dart';

class SignUpResponseBody {
  final String id;
  final String firstName;
  final String email;
  final String lastName;
  SignUpResponseBody({
    required this.id,
    required this.firstName,
    required this.email,
    required this.lastName,
  });

  factory SignUpResponseBody.fromJson(Map<String, dynamic> json) {
    return SignUpResponseBody(
      id: json[ApiConstants.id],
      firstName: json[ApiConstants.firstNameResponse],
      email: json[ApiConstants.email],
      lastName: json[ApiConstants.lastNameResponse],
    );
  }
}
