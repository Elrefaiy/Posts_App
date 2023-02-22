import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/config/themes/dark_theme.dart';
import 'package:posts_app/config/themes/light_theme.dart';
import 'package:posts_app/features/posts/presentation/cubit/posts_cubit.dart';
import 'package:posts_app/features/posts/presentation/screens/posts_screen.dart';
import 'injection_conainer.dart' as di;

class PostsApp extends StatelessWidget {
  final bool isDark;
  const PostsApp({required this.isDark, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<PostsCubit>()
        ..getAllPosts()
        ..changeTheme(mode: isDark),
      child: BlocBuilder<PostsCubit, PostsState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Posts Application',
            debugShowCheckedModeBanner: false,
            theme: PostsCubit.get(context).isDark ? darkTheme() : lightTheme(),
            home: const PostsScreen(),
          );
        },
      ),
    );
  }
}
