import 'package:flutter/material.dart';
import 'package:posts_app/app.dart';
import 'package:posts_app/injection_conainer.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const PostsApp());
}
