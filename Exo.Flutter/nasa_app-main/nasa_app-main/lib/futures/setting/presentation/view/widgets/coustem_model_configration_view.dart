import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// تعريف الألوان المستخدمة في التصميم
const Color kPrimaryDarkColor = Color(0xFF1A1A2E); // الخلفية الداكنة
const Color kAccentBlueColor = Color(0xFF007AFF);  // اللون الأزرق لشريط التمرير

class ModelConfigurationView extends StatelessWidget {
  const ModelConfigurationView({super.key});

  @override
  Widget build(BuildContext context) {
    // يجب تهيئة ScreenUtil قبل الاستخدام
    // ScreenUtilInit(designSize: const Size(360, 690), builder: (context, child) => ... );

    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50.h), // مساحة علوية

            // عنوان "Model Configuration"
            Text(
              'Model Configuration',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 30.h),

            // 1. Learning Rate
            _ConfigSlider(
              title: 'Learning Rate',
              min: 0.0001,
              max: 0.01,
              divisions: 30, // لتسهيل الوصول إلى 0.001
              initialValue: 0.001,
              labelFormatter: (value) => value.toStringAsPrecision(1),
            ),

            SizedBox(height: 30.h),

            // 2. Dropout Rate
            _ConfigSlider(
              title: 'Dropout Rate',
              min: 0,
              max: 50,
              divisions: 50, // أقسام لكل نسبة مئوية
              initialValue: 20,
              labelFormatter: (value) => '${value.toInt()}%',
            ),

            SizedBox(height: 30.h),

            // 3. Batch Size
            _ConfigSlider(
              title: 'Batch Size',
              min: 16,
              max: 512,
              divisions: 496, // لضمان إمكانية التمرير بمرونة، أو يمكن اختيار عدد أقسام أقل للقفزات الكبيرة (16, 32, 64, 128, 256, 512)
              initialValue: 64,
              labelFormatter: (value) => value.toInt().toString(),
            ),
            
            SizedBox(height: 30.h),

            // 4. Training Epochs
            _ConfigSlider(
              title: 'Training Epochs',
              min: 10,
              max: 200,
              divisions: 190, // أقسام لكل قيمة
              initialValue: 100,
              labelFormatter: (value) => value.toInt().toString(),
            ),

            SizedBox(height: 50.h),
            
            // يمكنك إضافة زر الحفظ هنا
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // منطق حفظ الإعدادات
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kAccentBlueColor,
                  padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 15.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Text(
                  'Save Configuration',
                  style: TextStyle(fontSize: 16.sp, color: Colors.white),
                ),
              ),
            ),
          ],
        )
     ;
  }
}


// الأداة المساعدة لشريط التمرير
class _ConfigSlider extends StatefulWidget {
  final String title;
  final double min;
  final double max;
  final int divisions;
  final double initialValue;
  final String Function(double) labelFormatter;

  const _ConfigSlider({
    required this.title,
    required this.min,
    required this.max,
    required this.divisions,
    required this.initialValue,
    required this.labelFormatter,
  });

  @override
  State<_ConfigSlider> createState() => __ConfigSliderState();
}

class __ConfigSliderState extends State<_ConfigSlider> {
  late double _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // عنوان الإعداد
        Text(
          widget.title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),

        // شريط التمرير الفعلي
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: kAccentBlueColor,
            inactiveTrackColor: Colors.white12,
            thumbColor: kAccentBlueColor,
            overlayColor: kAccentBlueColor.withOpacity(0.3),
            valueIndicatorColor: kAccentBlueColor,
            valueIndicatorTextStyle: const TextStyle(color: Colors.white),
          ),
          child: Slider(
            value: _currentValue,
            min: widget.min,
            max: widget.max,
            divisions: widget.divisions,
            label: widget.labelFormatter(_currentValue),
            onChanged: (double value) {
              setState(() {
                _currentValue = value;
              });
            },
          ),
        ),

        // عرض القيم الدنيا والقصوى
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.labelFormatter(widget.min),
                style: TextStyle(color: Colors.white60, fontSize: 12.sp),
              ),
              // القيمة المتوسطة (لإعدادات مثل Dropout Rate و Batch Size)
              if (widget.divisions > 5) 
                Text(
                  widget.labelFormatter((widget.min + widget.max) / 2),
                  style: TextStyle(color: Colors.white60, fontSize: 12.sp),
                ),
              Text(
                widget.labelFormatter(widget.max),
                style: TextStyle(color: Colors.white60, fontSize: 12.sp),
              ),
            ],
          ),
        ),
      ],
    );
  }
}