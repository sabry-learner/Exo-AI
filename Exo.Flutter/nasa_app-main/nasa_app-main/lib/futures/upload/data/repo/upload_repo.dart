import 'package:dartz/dartz.dart';
import 'package:nasa_app/core/networking/api_failure.dart';
import 'package:nasa_app/futures/upload/data/models/upload_css/upload_csv_request.dart';
import 'package:nasa_app/futures/upload/data/models/upload_css/upload_csv_response.dart';
import 'package:nasa_app/futures/upload/data/models/upload_predect_real/upload_predect_real_request.dart';
import 'package:nasa_app/futures/upload/data/models/upload_predect_real/upload_predect_real_response.dart';

abstract class UploadRepo {
  Future<Either<Failure, UploadCsvFileResponse>> uploadCsv({
    required UploadCsvFileRequest uploadCsvFileRequest,
  });
  Future<Either<Failure, PredictionRealResponse>> uploadPredectReal({
    required PredictionRealRequest predictionRealRequest,
  });
}
