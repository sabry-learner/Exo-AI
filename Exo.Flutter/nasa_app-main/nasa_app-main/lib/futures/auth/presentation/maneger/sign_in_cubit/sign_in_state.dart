part of 'sign_in_cubit.dart';

@immutable
sealed class SignInState {}

final class SignInInitial extends SignInState {}

//sinIn Stasts
final class SignInLoading extends SignInState {}

final class SignInFailure extends SignInState {
  final String errorMassege;

  SignInFailure({required this.errorMassege});
}

final class SignInSuccess extends SignInState {}
