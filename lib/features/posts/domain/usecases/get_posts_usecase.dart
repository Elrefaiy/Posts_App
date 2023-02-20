import 'package:posts_app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:posts_app/core/usecase/usecase.dart';
import 'package:posts_app/features/posts/domain/entities/post.dart';
import 'package:posts_app/features/posts/domain/repositories/post_repository.dart';

class GetAllPostsUseCase extends UseCase<List<Post>, NoParams> {
  final PostsRepository postsRepository;

  GetAllPostsUseCase({required this.postsRepository});
  @override
  Future<Either<Failure, List<Post>>> call(NoParams params) {
    return postsRepository.getAllPosts();
  }
}
