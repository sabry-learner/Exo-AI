import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_app/core/functions/navigate_extension.dart';
import 'package:nasa_app/core/routes/routes.dart';
import 'package:nasa_app/futures/auth/presentation/view/widgets/sign_up_bloc_listener.dart';
import 'package:nasa_app/futures/upload/data/models/result_argument/result_argument.dart';
import 'package:nasa_app/futures/upload/presentation/managers/upload_csv_cubit/upload_csv_cubit.dart';

class UploadCsvBlocListener extends StatelessWidget {
  const UploadCsvBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UploadCsvCubit, UploadCsvState>(
      listener: (context, state) {
        if (state is UploadCsvSuccess) {
          context.pop();
          context.pushNamed(
            Routes.resultView,
            arguments: ResultArguments(
              uploadCsvFileResponse: state.uploadCsvFileResponse,
            ),
          );
        } else if (state is UploadCsvFailure) {
          context.pop();
          setUpErrorState(context, state.message);
        } else {
          setUpLoadingState(context);
        }
      },
      child: SizedBox.shrink(),
    );
  }
}
