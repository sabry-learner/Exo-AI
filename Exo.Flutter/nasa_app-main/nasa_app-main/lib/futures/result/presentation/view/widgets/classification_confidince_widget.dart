import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasa_app/futures/result/data/models/confidince_model.dart';

class ClassificationConfidenceWidget extends StatelessWidget {
  const ClassificationConfidenceWidget({super.key});

  // البيانات الوهمية لمستويات الثقة (كما في الصورة المرفقة)
  static final List<ConfidenceLevelModel> data = [
    ConfidenceLevelModel(
      confidence: 94.7,
      title: 'Confirmed Exoplanet',
      color: const Color(0xFF4CAF50), // أخضر
    ),
    ConfidenceLevelModel(
      confidence: 78.3,
      title: 'Planet Candidate',
      color: const Color(0xFFFFCC00), // أصفر
    ),
    ConfidenceLevelModel(
      confidence: 89.1,
      title: 'False Positive',
      color: const Color(0xFFF44336), // أحمر
    ),
   
  ];

  @override
  Widget build(BuildContext context) {
    final Color widgetBackgroundColor = const Color(0xFF191632);

    return Container(
      width: 1.sw, // عرض الشاشة بالكامل
      padding: EdgeInsets.all(20.w),
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
        mainAxisSize: MainAxisSize.min, // مهم: لتقليص حجم Column للمحتوى
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // العنوان
          Text(
            'Classification Confidence Levels',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 25.h),

          // عرض الشرائط
          ...data.map((item) => ConfidenceBar(item: item)).toList(),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------
// 4. ويدجت شريط الثقة المفرد (Confidence Bar Widget)
// -----------------------------------------------------------
class ConfidenceBar extends StatelessWidget {
  final ConfidenceLevelModel item;

  const ConfidenceBar({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    // حساب عرض الشريط كنسبة مئوية من القيمة القصوى 100
    final double barRatio = item.confidence / 100.0;
    
    // يمثل هذا اللون الأساس الرمادي الباهت للشريط الذي لم يمتلئ
    final Color baseColor = item.color.withOpacity(0.2);

    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // اسم الفئة
              Text(
                item.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              // النسبة المئوية
              Text(
                '${item.confidence.toStringAsFixed(1)}%',
                style: TextStyle(
                  color: item.color,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),

          // شريط التقدم الفعلي
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Container(
              height: 12.h,
              color: baseColor, // الخلفية الرمادية الفاتحة
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: barRatio, // النسبة المئوية للقيمة
                child: Container(
                  decoration: BoxDecoration(
                    color: item.color,
                    borderRadius: BorderRadius.circular(8.r),
                    // يمكن إضافة ظل خفيف أو تدرج لجعله يبدو أكثر جمالاً
                    boxShadow: [
                      BoxShadow(
                        color: item.color.withOpacity(0.5),
                        blurRadius: 4.r,
                        offset: Offset(0, 1.h),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
