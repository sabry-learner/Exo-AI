import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasa_app/core/resources/app_colors.dart';
import 'package:nasa_app/futures/result/presentation/view/widgets/coustem_prediction_summary_item.dart';

class PredictionSummaryList extends StatelessWidget {
  const PredictionSummaryList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> data = [
      {'count': 3421, 'label': 'Confirmed Exoplanets', 'color': const Color(0xFF4CAF50), 'icon': Icons.check},
      {'count': 2847, 'label': 'Planet Candidates', 'color': const Color(0xFFE4AD1E), 'icon': Icons.help_outline},
      {'count': 4129, 'label': 'False Positives', 'color': const Color(0xFFF44336), 'icon': Icons.close},
      ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF191632),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Prediction Summary',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.h),
          ...data.map((item) => Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: PredictionSummaryWidget(
                  count: item['count'] as int,
                  label: item['label'] as String,
                  baseColor: item['color'] as Color,
                  icon: item['icon'] as IconData,
                ),
              )),
        ],
      ),
    );
  }
}
