import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_app/core/di/set_up_get_it.dart';
import 'package:nasa_app/core/widgets/coustem_drawer.dart';
import 'package:nasa_app/futures/upload/data/repo/upload_repo_impl.dart';
import 'package:nasa_app/futures/upload/presentation/managers/prediction_real_cubit/prediction_real_cubit.dart';
import 'package:nasa_app/futures/upload/presentation/managers/upload_csv_cubit/upload_csv_cubit.dart';
import 'package:nasa_app/futures/upload/presentation/view/widgets/upload_view_body.dart';

class UploadView extends StatelessWidget {
  const UploadView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PredictionRealCubit(
            getIt<UploadRepoImpl>(instanceName: 'DataRepo'),
          ),
        ),
        BlocProvider(
          create: (context) =>
              UploadCsvCubit(getIt<UploadRepoImpl>(instanceName: 'DataRepo')),
        ),
      ],
      child: Scaffold(
        drawer: CoustemDrawer(),
        body: SafeArea(child: UploadViewBody()),
      ),
    );
  }
}
