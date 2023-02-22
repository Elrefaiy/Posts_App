import 'package:flutter/material.dart';
import 'package:posts_app/core/utils/app_colors.dart';
import 'package:posts_app/features/posts/domain/entities/post.dart';

class PostWidget extends StatelessWidget {
  final Post post;
  const PostWidget({required this.post, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.lightContainer(),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post.id.toString(),
            style: Theme.of(context).textTheme.subtitle1,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              children: [
                Text(
                  post.title.toString(),
                  style: Theme.of(context).textTheme.headline1,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  post.body.toString(),
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
