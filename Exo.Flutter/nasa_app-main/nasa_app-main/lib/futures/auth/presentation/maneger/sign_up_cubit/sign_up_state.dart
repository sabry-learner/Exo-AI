part of 'sign_up_cubit.dart';

@immutable
sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}
final class SignUpLoading extends SignUpState {}
final class SignUpFailure extends SignUpState {
  final String errorMassege;
  SignUpFailure({required this.errorMassege});
}
final class SignUpSuccess extends SignUpState {}
