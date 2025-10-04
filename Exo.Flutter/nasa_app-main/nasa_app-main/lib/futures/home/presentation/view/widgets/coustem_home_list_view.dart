import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasa_app/futures/home/presentation/view/widgets/couustem_classification_card.dart';

class CoustemHomeList extends StatelessWidget {
  const CoustemHomeList({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      slivers: [
        // البطاقة 1: Total Classifications (اللون الأزرق)
        SliverToBoxAdapter(
          child: ClassificationCard(
            title: 'Total Classifications',
            totalCount: '12,847',
            percentageChange: '+12.5%',
            changeDescription: 'from last week',
            iconData: Icons.language,
            iconBackgroundColor: Colors.blue.shade700, // تمرير اللون مباشرة
          ),
        ),

         SliverToBoxAdapter(
          child: SizedBox(height: 16.h),
        ), // فاصل بين البطاقات
        // البطاقة 2: Confirmed Exoplanets (اللون الأخضر)
        SliverToBoxAdapter(
          child: ClassificationCard(
            title: 'Confirmed Exoplanets',
            totalCount: '3,421',
            percentageChange: '+8.2%',
            changeDescription: 'accuracy improved',
            iconData: Icons.check_circle,
            iconBackgroundColor: Colors.green.shade600, // تمرير اللون مباشرة
          ),
        ),

         SliverToBoxAdapter(
          child: SizedBox(height: 16.h),
        ),
        // البطاقة 3: Model Accuracy (اللون البنفسجي)
        SliverToBoxAdapter(
          child: ClassificationCard(
            title: 'Model Accuracy',
            totalCount: '94.7%',
            percentageChange: '+2.1%',
            changeDescription: 'this month',
            iconData: Icons.psychology_outlined,
            iconBackgroundColor: Colors.deepPurple, // تمرير اللون مباشرة
          ),
        ),

          SliverToBoxAdapter(
          child: SizedBox(height: 16.h),
        ),

        // البطاقة 4: Processing Queue (اللون البرتقالي)
        SliverToBoxAdapter(
          child: ClassificationCard(
            title: 'Processing Queue',
            totalCount: '156',
            percentageChange: '~2.3h',
            changeDescription: 'estimated time',
            iconData: Icons.access_time,
            iconBackgroundColor: Colors.deepOrange, // تمرير اللون مباشرة
          ),
        ),

          SliverToBoxAdapter(
          child: SizedBox(height: 24.h),
        ),
      ],
    );
  }
}
