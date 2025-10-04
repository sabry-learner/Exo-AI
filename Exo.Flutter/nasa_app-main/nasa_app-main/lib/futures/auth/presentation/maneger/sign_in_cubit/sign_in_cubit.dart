import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_app/futures/auth/data/models/sign_in/sign_in_request_body.dart';
import 'package:nasa_app/futures/auth/data/repo/auth_repo_impl.dart';

part 'sign_in_state.dart';

class SingInCubit extends Cubit<SignInState> {
  SingInCubit(this._authRepoImpl) : super(SignInInitial());
  final AuthRepoImpl _authRepoImpl;
  final GlobalKey<FormState> signInFormKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  void emitSignInState() async {
    emit(SignInInitial());
    var result = await _authRepoImpl.signInUser(
      signInRequestBody: SignInRequestBody(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      ),
    );
    result.fold(
      (failure) {
        emit(SignInFailure(errorMassege: failure.message));
      },
      (_) {
        emit(SignInSuccess());
      },
    );
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
