import 'package:dartz/dartz.dart';
import 'package:posts_app/core/errors/failure.dart';
import 'package:posts_app/core/usecase/usecase.dart';

abstract class AddNewPostRepository {
  Future<Either<Failure, void>> addNewPost({required AddPostParams params});
}
