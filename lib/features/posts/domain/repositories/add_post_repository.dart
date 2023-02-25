import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_app/core/errors/failure.dart';

abstract class AddNewPostRepository {
  Future<Either<Failure, dynamic>> addNewPost({required AddPostParams params});
}

class AddPostParams extends Equatable {
  final int userId;
  final String title;
  final String body;
  const AddPostParams({
    required this.userId,
    required this.title,
    required this.body,
  });
  @override
  List<Object?> get props => [userId, title, body];

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'title': title,
        'body': body,
      };
}
