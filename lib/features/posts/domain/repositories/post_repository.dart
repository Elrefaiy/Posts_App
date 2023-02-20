import 'package:dartz/dartz.dart';
import 'package:posts_app/core/errors/failure.dart';
import 'package:posts_app/features/posts/domain/entities/post.dart';

abstract class PostsRepository {
  Future<Either<Failure, List<Post>>> getAllPosts();
}
