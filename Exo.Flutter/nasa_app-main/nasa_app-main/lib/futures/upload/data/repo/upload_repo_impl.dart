import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nasa_app/core/networking/api_endpoints.dart';
import 'package:nasa_app/core/networking/api_failure.dart';
import 'package:nasa_app/core/networking/api_services.dart';
import 'package:nasa_app/futures/upload/data/models/upload_css/upload_csv_request.dart';
import 'package:nasa_app/futures/upload/data/models/upload_css/upload_csv_response.dart';
import 'package:nasa_app/futures/upload/data/models/upload_predect_real/upload_predect_real_request.dart';
import 'package:nasa_app/futures/upload/data/models/upload_predect_real/upload_predect_real_response.dart';
import 'package:nasa_app/futures/upload/data/repo/upload_repo.dart';

class UploadRepoImpl implements UploadRepo {
  final ApiService _apiService;

  UploadRepoImpl(this._apiService);
  @override
  Future<Either<Failure, UploadCsvFileResponse>> uploadCsv({
    required UploadCsvFileRequest uploadCsvFileRequest,
  }) async{
    try {
      var result = await _apiService.post(
        endpoint: ApiEndPoint.uploadCsv,
        data: await uploadCsvFileRequest.toFormData(),
      );
      var data = UploadCsvFileResponse.fromJson(result);
      return right(data);
    }on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    }catch (e) {
      return left(ServerFailure('something went wrong'));
    }
  }

  @override
  Future<Either<Failure, PredictionRealResponse>> uploadPredectReal({
    required PredictionRealRequest predictionRealRequest,
  })async {
    try {
      var result = await _apiService.post(
        endpoint: ApiEndPoint.predictReal,
        data: predictionRealRequest.toJson(), 
      );
      var data = PredictionRealResponse.fromJson(result);
      return right(data);
    }on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure('something went wrong'));
    }
  }
}
