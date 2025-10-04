import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_app/core/functions/navigate_extension.dart';
import 'package:nasa_app/core/routes/routes.dart';
import 'package:nasa_app/futures/auth/presentation/view/widgets/sign_up_bloc_listener.dart';
import 'package:nasa_app/futures/upload/data/models/result_argument/result_argument.dart';
import 'package:nasa_app/futures/upload/presentation/managers/prediction_real_cubit/prediction_real_cubit.dart';

class PredicationRealBlocListener extends StatelessWidget {
  const PredicationRealBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PredictionRealCubit, PredictionRealState>(
      listener: (context, state) {
        if (state is PredictionRealSuccess) {
          context.pop();
          context.pushNamed(
            Routes.resultView,
            arguments: ResultArguments(
              
              predictionRealResponse: state.predictionRealResponse,
            ),
          );
        } else if (state is PredictionRealFailure) {
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
