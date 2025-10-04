part of 'upload_csv_cubit.dart';

sealed class UploadCsvState {}

final class UploadCsvInitial extends UploadCsvState {}

final class UploadCsvLoading extends UploadCsvState {}

final class UploadCsvFailure extends UploadCsvState {
  final String message;
  UploadCsvFailure({required this.message});
}
class UploadCsvFilePicked extends UploadCsvState {
  final String fileName;
  UploadCsvFilePicked(this.fileName);
}
final class UploadCsvSuccess extends UploadCsvState {
  final UploadCsvFileResponse uploadCsvFileResponse;
  UploadCsvSuccess({required this.uploadCsvFileResponse});
}
