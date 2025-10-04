import 'package:nasa_app/futures/upload/data/models/upload_css/upload_csv_response.dart';
import 'package:nasa_app/futures/upload/data/models/upload_predect_real/upload_predect_real_response.dart';

class ResultArguments {
  final UploadCsvFileResponse? uploadCsvFileResponse;
  final PredictionRealResponse? predictionRealResponse;

  ResultArguments({
     this.uploadCsvFileResponse,
     this.predictionRealResponse,
  });
}
