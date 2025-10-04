import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_app/futures/upload/data/models/upload_predect_real/upload_predect_real_request.dart';
import 'package:nasa_app/futures/upload/data/models/upload_predect_real/upload_predect_real_response.dart';
import 'package:nasa_app/futures/upload/data/repo/upload_repo_impl.dart';

part 'prediction_real_state.dart';

class PredictionRealCubit extends Cubit<PredictionRealState> {
  PredictionRealCubit(this._uploadRepoImpl) : super(PredictionRealInitial());
  final UploadRepoImpl _uploadRepoImpl;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController kepoiNameController = TextEditingController();
    final TextEditingController koiCountController = TextEditingController();
    final TextEditingController koiDiccoMskyController =
        TextEditingController();
    final TextEditingController koiDiccoMskyErrController =
        TextEditingController();
    final TextEditingController koiMaxMultEvController =
        TextEditingController();
    final TextEditingController koiModelSnrController = TextEditingController();
    final TextEditingController koiPradController = TextEditingController();
    final TextEditingController koiPradErr1Controller = TextEditingController();
    final TextEditingController koiScoreController = TextEditingController();
    final TextEditingController koiSmetErr2Controller = TextEditingController();
  void emitPredicationRealState() async {

    emit(PredictionRealLoading());
    var result = await _uploadRepoImpl.uploadPredectReal(
      predictionRealRequest: PredictionRealRequest(
        kepoiName: kepoiNameController.text.trim(),
        koiCount: int.parse(koiCountController.text.trim()),
        koiDiccoMsky: double.parse(koiDiccoMskyController.text.trim()),
        koiDiccoMskyErr: double.parse(koiDiccoMskyErrController.text.trim()),
        koiMaxMultEv: double.parse(koiMaxMultEvController.text.trim()),
        koiModelSnr: double.parse(koiModelSnrController.text.trim()),
        koiPrad: double.parse(koiPradController.text.trim()),
        koiPradErr1: double.parse(koiPradErr1Controller.text.trim()),
        koiScore: double.parse(koiScoreController.text.trim()),
        koiSmetErr2: double.parse(koiSmetErr2Controller.text.trim()),
      ),
    );
    result.fold(
      (failure) {
        emit(PredictionRealFailure(message: failure.message));
      },
      (predictionRealResponse) {
        emit(
          PredictionRealSuccess(predictionRealResponse: predictionRealResponse),
        );
      },
    );
  }
}
