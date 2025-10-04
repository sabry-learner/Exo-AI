import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_app/core/functions/navigate_extension.dart';
import 'package:nasa_app/core/resources/app_text_style.dart' show AppTextStyle;
import 'package:nasa_app/core/routes/routes.dart';
import 'package:nasa_app/futures/auth/presentation/maneger/sign_up_cubit/sign_up_cubit.dart';

class SignUpBlocListener extends StatelessWidget {
  const SignUpBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          context.pop();
          context.pushNamed(Routes.homeView);
        } else if (state is SignUpFailure) {
          context.pop();
          setUpErrorState(context, state.errorMassege);
        } else {
          setUpLoadingState(context);
        }
      },
      child: SizedBox.shrink(),
    );
  }
}

void setUpLoadingState(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Center(child: CircularProgressIndicator(color: Colors.white));
    },
  );
}

void setUpErrorState(context, errMessage) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        icon: Icon(Icons.error, color: Colors.red, size: 32),
        content: Text(
          errMessage,
          style: AppTextStyle.poppinsow300siz16,
          textAlign: TextAlign.center,
          maxLines: 5,
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text(
              'فهمت',
              style: AppTextStyle.poppinsow300siz16.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    },
  );
}
