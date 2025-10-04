import 'package:flutter/material.dart';
import 'package:nasa_app/core/widgets/coustem_drawer.dart';
import 'package:nasa_app/futures/setting/presentation/view/widgets/setteing_view_body.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CoustemDrawer(),
      body: SafeArea(child: SetteingViewBody()),
    );
  }
}
