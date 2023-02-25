import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/utils/app_colors.dart';
import 'package:posts_app/core/utils/constants.dart';
import 'package:posts_app/features/posts/presentation/cubit/posts_cubit.dart';
import 'package:posts_app/features/posts/presentation/widgets/error_widget.dart';
import 'package:posts_app/features/posts/presentation/widgets/input_field.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget bodyBuilder() {
      return BlocConsumer<PostsCubit, PostsState>(
        listener: (context, state) {
          if (state is PostAddedSuccessfully) {
            AppConstants.showSnackBar(
              context: context,
              message: '- new post has been added successfully !',
            );
            PostsCubit.get(context).userId.text = '';
            PostsCubit.get(context).postTitle.text = '';
            PostsCubit.get(context).postBody.text = '';

            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is AddingPostLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AddingPostFailed) {
            return const NoInternetWidget();
          } else {
            return Center(
              child: Container(
                color: PostsCubit.get(context).isDark
                    ? AppColors.darkContainer()
                    : AppColors.lightContainer(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                margin: const EdgeInsets.only(bottom: 50),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DefaultInputField(
                      controller: PostsCubit.get(context).userId,
                      prefixText: 'User ID : ',
                      autofocus: true,
                      textStyle: Theme.of(context).textTheme.headline1!,
                      keyboardType: TextInputType.number,
                    ),
                    DefaultInputField(
                      controller: PostsCubit.get(context).postTitle,
                      hintText: 'Post Header ..',
                      maxLines: 2,
                      textStyle: Theme.of(context).textTheme.headline1!,
                    ),
                    DefaultInputField(
                      controller: PostsCubit.get(context).postBody,
                      hintText: 'what\'s in your mind ? ..',
                      maxLines: 10,
                      textStyle: Theme.of(context).textTheme.bodyText1!,
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        PostsCubit.get(context).addNewPost(
                          userId:
                              int.parse(PostsCubit.get(context).userId.text),
                          title: PostsCubit.get(context).postTitle.text,
                          body: PostsCubit.get(context).postBody.text,
                        );
                      },
                      child: const Text(
                        'Post',
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
        title: const Text('Add New Post'),
        centerTitle: true,
      ),
      body: bodyBuilder(),
    );
  }
}
