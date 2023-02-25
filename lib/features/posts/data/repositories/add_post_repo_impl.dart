import 'package:posts_app/core/api/api_consumer.dart';
import 'package:posts_app/core/api/end_points.dart';
import 'package:posts_app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:posts_app/core/network/network_info.dart';
import 'package:posts_app/core/usecase/usecase.dart';
import 'package:posts_app/features/posts/domain/repositories/add_post_repository.dart';

class AddNewPostRepositoryImpl implements AddNewPostRepository {
  final NetworkInfo networkInfo;
  final ApiConsumer apiConsumer;

  AddNewPostRepositoryImpl({
    required this.networkInfo,
    required this.apiConsumer,
  });

  @override
  Future<Either<Failure, dynamic>> addNewPost(
      {required AddPostParams params}) async {
    if (await networkInfo.isConnected) {
      try {
        final request = await apiConsumer.post(
          path: EndPoints.posts,
          body: params.toMap(),
        );
        return Right(request);
      } catch (error) {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
