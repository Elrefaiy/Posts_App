import 'package:flutter/material.dart';
import 'package:posts_app/core/utils/app_colors.dart';
import 'package:posts_app/features/posts/domain/entities/post.dart';
import 'package:posts_app/features/posts/presentation/cubit/posts_cubit.dart';

class PostWidget extends StatelessWidget {
  final Post post;
  const PostWidget({required this.post, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PostsCubit.get(context).isDark
          ? AppColors.darkContainer()
          : AppColors.lightContainer(),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title.toString(),
                  style: Theme.of(context).textTheme.headline1,
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
