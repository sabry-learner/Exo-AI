import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_app/futures/auth/data/models/sign_up/sign_up_request_body.dart';
import 'package:nasa_app/futures/auth/data/repo/auth_repo_impl.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._authRepoImpl) : super(SignUpInitial());
  final AuthRepoImpl _authRepoImpl;

  final GlobalKey<FormState> signUpFormKey = GlobalKey();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  void emitSignUpState() async {
    emit(SignUpLoading());
    var result = await _authRepoImpl.sinUpUser(
      signUpRequestModel: SignUpRequestBody(
        email: emailController.text.trim(),
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        password: passwordController.text.trim(),
      ),
    );
    result.fold(
      (failure) {
        emit(SignUpFailure(errorMassege: failure.message));
      },
      (_) {
        emit(SignUpSuccess());
      },
    );
  }

  @override
  Future<void> close() {
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
