import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasa_app/futures/result/data/models/pie_char_data_model.dart';

class ClassificationDistributionWidget extends StatelessWidget {
  const ClassificationDistributionWidget({super.key});

  // البيانات الوهمية للمخطط
  static final List<PieChartDataModel> data = [
    PieChartDataModel(value: 30, title: 'Confirmed Exoplanets', color: const Color(0xFF4CAF50)), // أخضر
    PieChartDataModel(value: 25, title: 'Planet Candidates', color: const Color(0xFFFFA500)), // برتقالي
    PieChartDataModel(value: 25, title: 'False Positives', color: const Color(0xFFF44336)), // أحمر
   ];

  @override
  Widget build(BuildContext context) {
    final Color widgetBackgroundColor = const Color(0xFF191632);

    return Container(
      width: 1.sw, 
      height: 500.h,// عرض الشاشة بالكامل
      padding: EdgeInsets.all(20.w),
      margin: EdgeInsets.symmetric(horizontal: 10.w), // إضافة هامش أفقي
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
        mainAxisSize: MainAxisSize.min, // مهم جداً: لتقليص حجم Column للمحتوى
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // العنوان
          Text(
            'Classification Distribution',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15.h),

          // المنطقة التي تحتوي على المخطط والأسطورة (Legend)
          // *الحل:* استخدام SizedBox لتعيين ارتفاع محدد لـ Row الذي يحتوي على Expanded
          Expanded(
            flex: 3,
            child: AspectRatio(
              aspectRatio: 1, // يحافظ على الشكل الدائري
              child: PieChart(
                PieChartData(
                  sectionsSpace: 4.w,
                  centerSpaceRadius: 60.r,
                  sections: data.map((item) {
                    return PieChartSectionData(
                      color: item.color,
                      value: item.value,
                      title: (item.value > 0) ? '${item.value.toStringAsFixed(0)}%' : '', // عرض النسبة داخل القطعة إذا كانت أكبر من صفر
                      radius: 70.r,
                      titleStyle: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          SizedBox(width: 40.w),
                    
          // الأسطورة (Legend)
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: data
                    .map(
                      (item) => _buildIndicator(
                        color: item.color,
                        text: item.title,
                        isSquare: true,
                        percentage: item.value,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ويدجت مساعد لإنشاء عنصر الأسطورة
  Widget _buildIndicator({
    required Color color,
    required String text,
    required bool isSquare,
    required double percentage,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: <Widget>[
          Container(
            width: isSquare ? 16.w : 10.w,
            height: isSquare ? 16.w : 10.w,
            decoration: BoxDecoration(
              shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
              color: color,
              borderRadius: isSquare ? BorderRadius.circular(4.r) : null,
            ),
          ),
          SizedBox(width: 8.w),

          // اسم الفئة
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 8.w),

          // النسبة المئوية
          Text(
            '${percentage.toStringAsFixed(0)}%',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
