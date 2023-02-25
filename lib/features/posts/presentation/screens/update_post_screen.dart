import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/utils/app_colors.dart';
import 'package:posts_app/core/utils/constants.dart';
import 'package:posts_app/features/posts/domain/entities/post.dart';
import 'package:posts_app/features/posts/presentation/cubit/posts_cubit.dart';
import 'package:posts_app/features/posts/presentation/widgets/error_widget.dart';
import 'package:posts_app/features/posts/presentation/widgets/input_field.dart';

class UpdatePostScreen extends StatelessWidget {
  final Post post;
  const UpdatePostScreen({required this.post, super.key});

  @override
  Widget build(BuildContext context) {
    PostsCubit.get(context).newId.text = post.id.toString();
    PostsCubit.get(context).newUserId.text = post.userId.toString();
    PostsCubit.get(context).newTitle.text = post.title.toString();
    PostsCubit.get(context).newbody.text = post.body.toString();

    Widget bodyBuilder() {
      return BlocConsumer<PostsCubit, PostsState>(
        listener: (context, state) {
          if (state is PostUpdatedSuccessfully) {
            AppConstants.showSnackBar(
              context: context,
              message: '- post has been updated successfully !',
            );
            PostsCubit.get(context).getAllPosts();
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is UpdatePostLodaing) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UpdatingPostFailed) {
            return const NoInternetWidget();
          } else {
            return SingleChildScrollView(
              child: Container(
                color: PostsCubit.get(context).isDark
                    ? AppColors.darkContainer()
                    : AppColors.lightContainer(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                margin: const EdgeInsets.only(top: 80),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DefaultInputField(
                      controller: PostsCubit.get(context).newUserId,
                      prefixText: 'User ID : ',
                      autofocus: true,
                      textStyle: Theme.of(context).textTheme.headline1!,
                      keyboardType: TextInputType.number,
                    ),
                    DefaultInputField(
                      controller: PostsCubit.get(context).newId,
                      prefixText: 'Post ID : ',
                      autofocus: true,
                      textStyle: Theme.of(context).textTheme.headline1!,
                      keyboardType: TextInputType.number,
                    ),
                    DefaultInputField(
                      controller: PostsCubit.get(context).newTitle,
                      hintText: 'Post Header ..',
                      maxLines: 2,
                      textStyle: Theme.of(context).textTheme.headline1!,
                    ),
                    DefaultInputField(
                      controller: PostsCubit.get(context).newbody,
                      hintText: 'what\'s in your mind ? ..',
                      maxLines: 10,
                      textStyle: Theme.of(context).textTheme.bodyText1!,
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        PostsCubit.get(context).updatePost(
                          postId: post.id,
                          newId: int.parse(
                            PostsCubit.get(context).newId.text,
                          ),
                          userId: int.parse(
                            PostsCubit.get(context).newUserId.text,
                          ),
                          title: PostsCubit.get(context).newTitle.text,
                          body: PostsCubit.get(context).newbody.text,
                        );
                      },
                      child: const Text(
                        'Update Post',
                        textScaleFactor: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Post'),
        centerTitle: true,
      ),
      body: bodyBuilder(),
    );
  }
}
