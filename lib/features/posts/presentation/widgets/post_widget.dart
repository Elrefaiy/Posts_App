import 'package:flutter/material.dart';
import 'package:posts_app/config/routes/app_routes.dart';
import 'package:posts_app/core/utils/app_colors.dart';
import 'package:posts_app/features/posts/domain/entities/post.dart';
import 'package:posts_app/features/posts/presentation/cubit/posts_cubit.dart';
import 'package:posts_app/features/posts/presentation/screens/update_post_screen.dart';

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
          const SizedBox(width: 20),
          Column(
            children: [
              InkWell(
                onTap: () {
                  PostsCubit.get(context).deletePost(postId: post.id);
                },
                child: Icon(
                  Icons.close,
                  size: 20,
                  color: PostsCubit.get(context).isDark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              Container(
                color: AppColors.hint(),
                height: 1,
                width: 20,
                margin: const EdgeInsets.symmetric(vertical: 10),
              ),
              InkWell(
                onTap: () {
                  //! 'll be edited in near future ..
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return UpdatePostScreen(post: post);
                      },
                    ),
                  );
                },
                child: Icon(
                  Icons.edit,
                  size: 18,
                  color: PostsCubit.get(context).isDark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
