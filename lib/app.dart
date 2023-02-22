import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/config/themes/light_theme.dart';
import 'package:posts_app/features/posts/presentation/cubit/posts_cubit.dart';
import 'package:posts_app/features/posts/presentation/screens/posts_screen.dart';
import 'injection_conainer.dart' as di;

class PostsApp extends StatelessWidget {
  const PostsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<PostsCubit>()..getAllPosts(),
      child: BlocBuilder<PostsCubit, PostsState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Posts Application',
            debugShowCheckedModeBanner: false,
            theme: lightTheme(),
            home: const PostsScreen(),
          );
        },
      ),
    );
  }
}
