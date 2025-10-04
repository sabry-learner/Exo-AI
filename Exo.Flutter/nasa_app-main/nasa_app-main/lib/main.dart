import 'package:flutter/material.dart';
import 'package:nasa_app/core/app/nasa_space_app.dart';
import 'package:nasa_app/core/database/my_cache_helper.dart';
import 'package:nasa_app/core/database/prefs_constants.dart';
import 'package:nasa_app/core/di/set_up_get_it.dart';
bool isLoggedIn = false;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await isLoggedInChecker();
  setUpGetIt();
  runApp(const NasaSpace());
}


isLoggedInChecker() async {
  final String? token = await SharedPrefHelper.getString(
    PrefsConstants.token,
  );
  if (token== null || token.isEmpty) {
    isLoggedIn = false;
  } else {
    isLoggedIn = true;
  }
}