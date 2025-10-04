import 'package:flutter/material.dart';
import 'package:nasa_app/core/widgets/coustem_app_bar.dart';
import 'package:nasa_app/futures/setting/presentation/view/widgets/coustem_model_configration_view.dart';

class SetteingViewBody extends StatelessWidget {
  const SetteingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView(
        children: [
          CoustemAppBar(
            context: context,
            titel: 'Settings & Configuration',
            subTitel: 'Customize model parameters and application preferences',
          ),
        ModelConfigurationView(),

        ],
      ),
    );
  }
}
