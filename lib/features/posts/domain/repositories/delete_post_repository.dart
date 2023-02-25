import 'package:dartz/dartz.dart';
import 'package:posts_app/core/errors/failure.dart';

abstract class DeletePostRepository {
  Future<Either<Failure, dynamic>> deletePost(int id);
}
