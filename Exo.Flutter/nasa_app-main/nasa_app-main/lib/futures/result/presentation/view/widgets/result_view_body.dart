import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasa_app/futures/result/presentation/view/widgets/classification_confidince_widget.dart';
import 'package:nasa_app/futures/result/presentation/view/widgets/classification_distribution_widget.dart';
import 'package:nasa_app/futures/result/presentation/view/widgets/coustem_prediction_summaryl_list.dart';
import 'package:nasa_app/futures/result/presentation/view/widgets/coustem_result_app_bar.dart';
import 'package:nasa_app/futures/result/presentation/view/widgets/light_curvr_chart.dart';
import 'package:nasa_app/futures/upload/data/models/result_argument/result_argument.dart';

class ResultViewBody extends StatelessWidget {
  const ResultViewBody({
    super.key,
    required this.resultArguments,
  });
  final ResultArguments resultArguments;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: CoustemResultAppBar()),

          SliverToBoxAdapter(child: PredictionSummaryList()),
          SliverToBoxAdapter(child: SizedBox(height: 10.h)),

          SliverToBoxAdapter(child: ClassificationDistributionWidget()),
          SliverToBoxAdapter(child: SizedBox(height: 10.h)),

          SliverToBoxAdapter(child: SizedBox(height: 10.h)),
          SliverToBoxAdapter(child: ClassificationConfidenceWidget()),

          SliverToBoxAdapter(child: SizedBox(height: 10.h)),
          SliverToBoxAdapter(child: LightCurveChart()),
        ],
      ),
    );
  }
}
