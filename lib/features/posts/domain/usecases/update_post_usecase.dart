import 'package:equatable/equatable.dart';
import 'package:posts_app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:posts_app/core/usecase/usecase.dart';
import 'package:posts_app/features/posts/domain/repositories/update_post_repository.dart';

class UpdatePostUseCase extends UseCase<dynamic, UpdatePostParams> {
  final UpdatePostRepository updatePostRepository;

  UpdatePostUseCase({required this.updatePostRepository});
  @override
  Future<Either<Failure, dynamic>> call(UpdatePostParams params) {
    return updatePostRepository.updatePost(params);
  }
}

class UpdatePostParams extends Equatable {
  final int postId;
  final int id;
  final String title;
  final String body;
  final int userId;

  const UpdatePostParams({
    required this.postId,
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'userId': userId,
    };
  }

  @override
  List<Object?> get props => [postId, id, title, body, userId];
}
