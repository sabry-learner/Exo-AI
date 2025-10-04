part of 'prediction_real_cubit.dart';

@immutable
sealed class PredictionRealState {}

final class PredictionRealInitial extends PredictionRealState {}
final class PredictionRealLoading extends PredictionRealState {}
final class PredictionRealFailure extends PredictionRealState {
  final String message;
  PredictionRealFailure({required this.message});
}
final class PredictionRealSuccess extends PredictionRealState {
  final PredictionRealResponse predictionRealResponse;
  PredictionRealSuccess({required this.predictionRealResponse});
}
