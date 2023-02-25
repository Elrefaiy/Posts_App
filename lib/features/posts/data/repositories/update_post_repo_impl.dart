import 'package:posts_app/core/api/api_consumer.dart';
import 'package:posts_app/core/api/end_points.dart';
import 'package:posts_app/core/errors/exceptions.dart';
import 'package:posts_app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:posts_app/core/network/network_info.dart';
import 'package:posts_app/features/posts/domain/repositories/update_post_repository.dart';
import 'package:posts_app/features/posts/domain/usecases/update_post_usecase.dart';

class UpdatePostRepositoryImpl implements UpdatePostRepository {
  final NetworkInfo networkInfo;
  final ApiConsumer apiConsumer;

  UpdatePostRepositoryImpl({
    required this.networkInfo,
    required this.apiConsumer,
  });
  @override
  Future<Either<Failure, dynamic>> updatePost(UpdatePostParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final request = await apiConsumer.put(
          path: EndPoints.postId(params.postId),
          body: params.toMap(),
        );
        return Right(request);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
