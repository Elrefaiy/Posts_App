import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:posts_app/core/utils/app_colors.dart';

ThemeData lightTheme() {
  return ThemeData(
    primaryColor: AppColors.primary(),
    primarySwatch: AppColors.primary(),
    hintColor: AppColors.hint(),
    scaffoldBackgroundColor: AppColors.lightScaffold(),
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.lightScaffold(),
        statusBarIconBrightness: Brightness.dark,
      ),
      color: AppColors.lightScaffold(),
      titleTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      elevation: 0,
      titleSpacing: 20,
    ),
    textTheme: TextTheme(
      headline1: const TextStyle(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      bodyText1: const TextStyle(
        fontSize: 14,
        color: Colors.black,
      ),
      subtitle1: TextStyle(
        fontSize: 16,
        color: AppColors.hint(),
      ),
    ),
  );
}
