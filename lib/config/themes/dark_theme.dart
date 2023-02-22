import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:posts_app/core/utils/app_colors.dart';

ThemeData darkTheme() {
  return ThemeData(
    primaryColor: AppColors.primary(),
    primarySwatch: AppColors.primary(),
    hintColor: AppColors.hint(),
    scaffoldBackgroundColor: AppColors.darkScaffold(),
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.darkScaffold(),
        statusBarIconBrightness: Brightness.light,
      ),
      color: AppColors.darkScaffold(),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      elevation: 0,
      titleSpacing: 20,
    ),
    textTheme: TextTheme(
      headline1: const TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      bodyText1: const TextStyle(
        fontSize: 14,
        color: Colors.white,
      ),
      subtitle1: TextStyle(
        fontSize: 16,
        color: AppColors.hint(),
      ),
    ),
  );
}
