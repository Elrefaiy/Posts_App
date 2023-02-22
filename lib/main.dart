import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/app.dart';
import 'package:posts_app/core/utils/app_strings.dart';
import 'package:posts_app/injection_conainer.dart' as di;
import 'package:shared_preferences/shared_preferences.dart';
import 'bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await di.init();
  bool isDark =
      di.sl<SharedPreferences>().getBool(AppStrings.cachedTheme) ?? false;
  runApp(PostsApp(isDark: isDark));
}
