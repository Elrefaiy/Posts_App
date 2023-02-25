import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/errors/failure.dart';
import 'package:posts_app/core/usecase/usecase.dart';
import 'package:posts_app/core/utils/app_strings.dart';
import 'package:posts_app/features/posts/domain/entities/post.dart';
import 'package:posts_app/features/posts/domain/usecases/add_post_usecase.dart';
import 'package:posts_app/features/posts/domain/usecases/delete_post_usecase.dart';
import 'package:posts_app/features/posts/domain/usecases/get_posts_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  final GetAllPostsUseCase getAllPostsUseCase;
  final AddNewPostUseCase addNewPostUseCase;
  final DeletePostUseCase deletePostUseCase;
  final SharedPreferences sharedPreferences;
  PostsCubit({
    required this.getAllPostsUseCase,
    required this.addNewPostUseCase,
    required this.deletePostUseCase,
    required this.sharedPreferences,
  }) : super(PostsInitial());

  static PostsCubit get(context) => BlocProvider.of(context);

  bool isDark = false;
  void changeTheme({mode}) {
    emit(PostsInitial());
    if (mode != null) {
      isDark = mode;
    } else {
      isDark = !isDark;
    }
    sharedPreferences.setBool(AppStrings.cachedTheme, isDark);
    emit(ChangeAppTheme());
    getAllPosts();
  }

  Future<void> getAllPosts() async {
    emit(PostsIsLoading());
    Either<Failure, List<Post>> response =
        await getAllPostsUseCase.call(NoParams());
    emit(
      response.fold(
        (failure) => PostsLoadedFailed(message: mapFailureToMessage(failure)),
        (posts) => PostsLoadedSuccessfully(posts: posts),
      ),
    );
  }

  var userId = TextEditingController();
  var postTitle = TextEditingController();
  var postBody = TextEditingController();

  Future<void> addNewPost({
    required int userId,
    required String title,
    required String body,
  }) async {
    emit(AddingPostLoading());
    Either<Failure, void> request = await addNewPostUseCase.call(
      AddPostParams(
        userId: userId,
        title: title,
        body: body,
      ),
    );
    emit(
      request.fold(
        (failure) => AddingPostFailed(message: mapFailureToMessage(failure)),
        (right) => PostAddedSuccessfully(),
      ),
    );
    getAllPosts();
  }

  Future<void> deletePost({
    required int postId,
  }) async {
    emit(DeletePostLodaing());
    Either<Failure, void> request = await deletePostUseCase.call(postId);
    emit(
      request.fold(
        (failure) => DeletingPostFailed(message: mapFailureToMessage(failure)),
        (right) => PostDeletedSuccessfully(),
      ),
    );
    getAllPosts();
  }

  String mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case CacheFailure:
        return 'Cache Failure Occured';
      case ServerFailure:
        return 'Server Failure Occured';
      default:
        return 'Unexpected Failure';
    }
  }
}
