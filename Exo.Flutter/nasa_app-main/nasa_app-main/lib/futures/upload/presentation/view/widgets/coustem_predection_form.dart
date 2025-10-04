import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasa_app/core/resources/app_colors.dart';
import 'package:nasa_app/futures/upload/presentation/view/widgets/coustem_start_classification.dart';

import '../../managers/prediction_real_cubit/prediction_real_cubit.dart';

class CoustemPredectionForm extends StatelessWidget {
  const CoustemPredectionForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<PredictionRealCubit>().formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 3.h),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 2.r,
                blurRadius: 10.r,
                offset: Offset(0, 5.h),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildRowField(
                "Name",
                context.read<PredictionRealCubit>().kepoiNameController,
                keyboardType: TextInputType.name,
              ),
              _buildRowField(
                "Count",
                context.read<PredictionRealCubit>().koiCountController,
              ),
              _buildRowField(
                "Dicco_msky",
                context.read<PredictionRealCubit>().koiDiccoMskyController,
              ),
              _buildRowField(
                "Dicco_msky_err",
                context.read<PredictionRealCubit>().koiDiccoMskyErrController,
              ),
              _buildRowField(
                "Max_mult_ev",
                context.read<PredictionRealCubit>().koiMaxMultEvController,
              ),
              _buildRowField(
                "Model_snr",
                context.read<PredictionRealCubit>().koiModelSnrController,
              ),
              _buildRowField(
                "Prad",
                context.read<PredictionRealCubit>().koiPradController,
              ),
              _buildRowField(
                "Prad_err1",
                context.read<PredictionRealCubit>().koiPradErr1Controller,
              ),
              _buildRowField(
                "Score",
                context.read<PredictionRealCubit>().koiScoreController,
              ),
              _buildRowField(
                "Kmet_err2",
                context.read<PredictionRealCubit>().koiSmetErr2Controller,
              ),
              const SizedBox(height: 20),
              CoustemStartClassification(
                onTap: () {
                  if (context
                      .read<PredictionRealCubit>()
                      .formKey
                      .currentState!
                      .validate()) {
                    context
                        .read<PredictionRealCubit>()
                        .emitPredicationRealState();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// جدول: Label + TextField
  Widget _buildRowField(
    String label,
    TextEditingController controller, {
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 7,
            child: TextFormField(
              keyboardType: keyboardType ?? TextInputType.number,
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 10,
                ),
              ),
              validator: (value) =>
                  value == null || value.isEmpty ? "Required" : null,
            ),
          ),
        ],
      ),
    );
  }
}
