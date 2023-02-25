import 'package:flutter/material.dart';
import 'package:posts_app/features/posts/domain/entities/post.dart';
import 'package:posts_app/features/posts/presentation/screens/add_post_screen.dart';
import 'package:posts_app/features/posts/presentation/screens/posts_screen.dart';
import 'package:posts_app/features/posts/presentation/screens/update_post_screen.dart';

class Routes {
  static const String home = '/';
  static const String addPost = '/add_post';
  // static const String updatePost = '/update_post';
}

class AppRoutes {
  static Route onGeneratedRoute(RouteSettings route) {
    switch (route.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (context) => const PostsScreen());
      case Routes.addPost:
        return MaterialPageRoute(builder: (context) => const AddPostScreen());
      // case Routes.updatePost:
      //   return MaterialPageRoute(
      //       builder: (context) => const UpdatePostScreen(post: ,));
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
