import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/errors/failure.dart';
import 'package:posts_app/core/usecase/usecase.dart';
import 'package:posts_app/features/posts/domain/entities/post.dart';
import 'package:posts_app/features/posts/domain/usecases/get_posts_usecase.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  final GetAllPostsUseCase getAllPostsUseCase;
  PostsCubit({required this.getAllPostsUseCase}) : super(PostsInitial());

  static PostsCubit get(context) => BlocProvider.of(context);

  bool isDark = false;
  void changeTheme() {
    emit(PostsInitial());
    isDark = !isDark;
    emit(ChangeAppTheme());
    getAllPosts();
  }

  Future<void> getAllPosts() async {
    emit(PostsIsLoading());
    Either<Failure, List<Post>> response =
        await getAllPostsUseCase.call(NoParams());
    emit(
      response.fold(
        (failure) => const PostsLoadedFailed(message: 'Posts Loaded Failed'),
        (posts) => PostsLoadedSuccessfully(posts: posts),
      ),
    );
  }
}
