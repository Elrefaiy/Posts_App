import 'package:flutter/material.dart';
import 'package:posts_app/features/posts/presentation/screens/posts_screen.dart';

class PostsApp extends StatelessWidget {
  const PostsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Posts Application',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PostsScreen(),
    );
  }
}
