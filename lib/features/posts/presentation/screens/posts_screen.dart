import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/utils/constants.dart';
import 'package:posts_app/features/posts/presentation/cubit/posts_cubit.dart';
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
              message: 'Check your connection',
              action: 'Refresh',
              onPressed: () => PostsCubit.get(context).getAllPosts(),
            );
          }
        },
        builder: (context, state) {
          if (state is PostsIsLoading) {
            return loadingWidget();
          } else if (state is PostsLoadedSuccessfully) {
            return ListView.separated(
              itemBuilder: (context, index) =>
                  PostWidget(post: state.posts[index]),
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: state.posts.length,
            );
          } else {
            return const Center(child: Text('Unexpected Error'));
          }
        },
      );
    }

    AppBar appBar = AppBar(
      title: const Text('All Posts'),
    );

    FloatingActionButton actionButton = FloatingActionButton(
      onPressed: () {},
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
