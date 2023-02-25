import 'package:dartz/dartz.dart';
import 'package:posts_app/core/errors/failure.dart';
import 'package:posts_app/features/posts/domain/usecases/update_post_usecase.dart';

abstract class UpdatePostRepository {
  Future<Either<Failure, dynamic>> updatePost(UpdatePostParams params);
}
