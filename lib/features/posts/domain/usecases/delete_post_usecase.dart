import 'package:posts_app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:posts_app/core/usecase/usecase.dart';
import 'package:posts_app/features/posts/domain/repositories/delete_post_repository.dart';

class DeletePostUseCase extends UseCase<dynamic, int> {
  final DeletePostRepository deletePostRepository;

  DeletePostUseCase({required this.deletePostRepository});

  @override
  Future<Either<Failure, dynamic>> call(int params) {
    return deletePostRepository.deletePost(params);
  }
}
