import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_app/futures/upload/data/models/upload_css/upload_csv_request.dart';
import 'package:nasa_app/futures/upload/data/models/upload_css/upload_csv_response.dart';
import 'package:nasa_app/futures/upload/data/repo/upload_repo_impl.dart';

part 'upload_csv_state.dart';

class UploadCsvCubit extends Cubit<UploadCsvState> {
  UploadCsvCubit(this._uploadRepoImpl) : super(UploadCsvInitial());
  final UploadRepoImpl _uploadRepoImpl;

  void uploadCsv(UploadCsvFileRequest uploadCsvFileRequest) async {
      emit(UploadCsvFilePicked(uploadCsvFileRequest.fileName));
    emit(UploadCsvLoading());
    var result = await _uploadRepoImpl.uploadCsv(
      uploadCsvFileRequest: uploadCsvFileRequest,
    );
    result.fold(
      (failure) {
        emit(UploadCsvFailure(message: failure.message));
      },
      (uploadCsvResponse) {
        emit(UploadCsvSuccess(uploadCsvFileResponse: uploadCsvResponse));
      },
    );
  }
}
