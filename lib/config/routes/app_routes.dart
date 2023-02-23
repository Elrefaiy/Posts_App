import 'package:flutter/material.dart';
import 'package:posts_app/features/posts/presentation/screens/add_post_screen.dart';
import 'package:posts_app/features/posts/presentation/screens/posts_screen.dart';

class Routes {
  static const String home = '/';
  static const String addPost = '/add_post';
}

class AppRoutes {
  static Route onGeneratedRoute(RouteSettings route) {
    switch (route.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (context) => const PostsScreen());
      case Routes.addPost:
        return MaterialPageRoute(builder: (context) => const AddPostScreen());
      default:
        return unknownRoute();
    }
  }
}

Route unknownRoute() => MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          body: Center(
            child: Text(
              'Error Occured, Unknown Route !',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
        );
      },
    );
