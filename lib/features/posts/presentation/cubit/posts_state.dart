part of 'posts_cubit.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

class PostsInitial extends PostsState {}

class PostsIsLoading extends PostsState {}

class PostsLoadedSuccessfully extends PostsState {
  final List<Post> posts;

  const PostsLoadedSuccessfully({required this.posts});

  @override
  List<Object> get props => [posts];
}

class PostsLoadedFailed extends PostsState {
  final String message;

  const PostsLoadedFailed({required this.message});

  @override
  List<Object> get props => [message];
}

class ChangeAppTheme extends PostsState {}

class AddingPostLoading extends PostsState {}

class PostAddedSuccessfully extends PostsState {}

class AddingPostFailed extends PostsState {
  final String message;

  const AddingPostFailed({required this.message});

  @override
  List<Object> get props => [message];
}
