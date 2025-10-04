import 'package:nasa_app/core/resources/app_assets.dart';

class OnBordingModel {
  final String imagePath;
  final String titel;
  final String subTitel;

  OnBordingModel({
    required this.imagePath,
    required this.titel,
    required this.subTitel,
  });
}

List<OnBordingModel> onBordingData = [
  OnBordingModel(
    imagePath: Assets.assetsImagesOnBordingOne,
    titel: 'Explore\nThe Universty',
    subTitel:
        'Discover the amaring space\nand the history of spice travel\nlendteape and rescivering as-\ntrophysics',
  ),
  OnBordingModel(
    imagePath: Assets.assetsImagesNBordingTwo,
    titel: 'Launch',
    subTitel:
        'Discover the amaring space\nand the history of spice travel\nlendteape and rescivering as-\ntrophysics',
  ),
];
