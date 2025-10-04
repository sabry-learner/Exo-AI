import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasa_app/core/resources/app_colors.dart';

class LightCurveChart extends StatelessWidget {
  const LightCurveChart({super.key});

  // مثال لبيانات منحنى الضوء
  // يمثل المحور الأفقي (x) الوقت (Time)
  // ويمثل المحور الرأسي (y) السطوع النسبي (Relative Brightness)
  final List<FlSpot> transitData = const [
    FlSpot(-2, 0.999),
    FlSpot(-1, 0.999),
    FlSpot(0, 0.995), // بداية هبوط السطوع (العبور)
    FlSpot(1, 0.990),
    FlSpot(2, 0.985), // أعمق نقطة في العبور
    FlSpot(3, 0.990),
    FlSpot(4, 0.995), // نهاية العبور والعودة للسطوع الطبيعي
    FlSpot(5, 0.999),
    FlSpot(6, 0.999),
  ];

  @override
  Widget build(BuildContext context) {
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
      child: AspectRatio(
        aspectRatio: 1.7,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LineChart(
            LineChartData(
              gridData: const FlGridData(show: true),
              titlesData: const FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: true, reservedSize: 30),
                ),
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(
                show: true,
                border: Border.all(color: const Color(0xff37434d), width: 1),
              ),
              minX: -2,
              maxX: 6,
              minY: 0.980,
              maxY: 1.000,
              lineBarsData: [
                LineChartBarData(
                  spots: transitData,
                  isCurved: true, // لجعل الخط منحنيًا وأكثر نعومة
                  barWidth: 3,
                  color: Colors.blue,
                  dotData: const FlDotData(show: false), // إخفاء النقاط على الخط
                  belowBarData: BarAreaData(show: true, color: Colors.blue.withOpacity(0.3)), // تظليل أسفل الخط
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}