import 'package:flutter/material.dart';
import 'package:nasa_app/core/widgets/coustem_drawer.dart';
import 'package:nasa_app/futures/result/presentation/view/widgets/result_view_body.dart';
import 'package:nasa_app/futures/upload/data/models/result_argument/result_argument.dart';

class ResultView extends StatelessWidget {
  const ResultView({super.key, required this.resultArguments});
  final ResultArguments resultArguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CoustemDrawer(),
      body: SafeArea(child: ResultViewBody(resultArguments: resultArguments)),
    );
  }
}
