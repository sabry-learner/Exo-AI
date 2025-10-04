import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasa_app/futures/upload/presentation/view/widgets/coustem_save_templet.dart';
import 'package:nasa_app/futures/upload/presentation/view/widgets/coustem_start_classification.dart';

class ClassificationParametersWidget extends StatefulWidget {
  const ClassificationParametersWidget({super.key});

  @override
  State<ClassificationParametersWidget> createState() =>
      _ClassificationParametersWidgetState();
}

class _ClassificationParametersWidgetState
    extends State<ClassificationParametersWidget> {
  final Color widgetBackgroundColor = const Color(0xFF191632);
  final Color primaryGreen = const Color(0xFF4CAF50);

  void _startClassification() {
    print('Starting Classification...');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Classification started...'),
        backgroundColor: Colors.indigo,
      ),
    );
  }

  void _saveAsTemplate() {
    print('Saving as Template...');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Template saved successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400.w,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: widgetBackgroundColor,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Classification',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 40.h),

          // Start Classification Button
          CoustemStartClassification(onTap: _startClassification),
          SizedBox(height: 15.h),
          CoustemSaveTemplate(onTap: _saveAsTemplate),
          // Save as Template Button
        ],
      ),
    );
  }
}
