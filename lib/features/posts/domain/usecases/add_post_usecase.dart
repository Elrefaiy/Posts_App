import 'package:posts_app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:posts_app/core/usecase/usecase.dart';
import 'package:posts_app/features/posts/domain/repositories/add_post_repository.dart';

class AddNewPostUseCase extends UseCase<dynamic, AddPostParams> {
  final AddNewPostRepository addNewPostRepository;

  AddNewPostUseCase({required this.addNewPostRepository});
  @override
  Future<Either<Failure, dynamic>> call(AddPostParams params) {
    return addNewPostRepository.addNewPost(params: params);
  }
}
