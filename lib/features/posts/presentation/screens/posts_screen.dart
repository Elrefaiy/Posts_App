import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/config/routes/app_routes.dart';
import 'package:posts_app/core/utils/constants.dart';
import 'package:posts_app/features/posts/presentation/cubit/posts_cubit.dart';
import 'package:posts_app/features/posts/presentation/widgets/error_widget.dart';
import 'package:posts_app/features/posts/presentation/widgets/post_widget.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget loadingWidget() {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    Widget bodyBuilder() {
      return BlocConsumer<PostsCubit, PostsState>(
        listener: (context, state) {
          if (state is PostsLoadedFailed) {
            AppConstants.showSnackBar(
              context: context,
              message: '- check your connection',
              action: 'Refresh',
              onPressed: () => PostsCubit.get(context).getAllPosts(),
            );
          } else if (state is PostDeletedSuccessfully) {
            AppConstants.showSnackBar(
              context: context,
              message: '- post deleted succeffully',
            );
          }
        },
        builder: (context, state) {
          if (state is PostsLoadedSuccessfully) {
            return ListView.separated(
              itemBuilder: (context, index) =>
                  PostWidget(post: state.posts[index]),
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: state.posts.length,
            );
          } else if (state is PostsLoadedFailed) {
            return const NoInternetWidget();
          } else {
            return loadingWidget();
          }
        },
      );
    }

    AppBar appBar = AppBar(
      title: const Text('All Posts'),
      actions: [
        IconButton(
          onPressed: () {
            PostsCubit.get(context).changeTheme();
          },
          icon: const Icon(Icons.brightness_4),
        ),
        const SizedBox(width: 10),
      ],
    );

    FloatingActionButton actionButton = FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, Routes.addPost);
      },
      child: const Icon(Icons.add),
    );

    return RefreshIndicator(
      onRefresh: () {
        return PostsCubit.get(context).getAllPosts();
      },
      child: Scaffold(
        appBar: appBar,
        body: bodyBuilder(),
        floatingActionButton: actionButton,
      ),
    );
  }
}
