import 'package:posts_app/core/api/api_consumer.dart';
import 'package:posts_app/core/api/end_points.dart';
import 'package:posts_app/core/errors/exceptions.dart';
import 'package:posts_app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:posts_app/core/network/network_info.dart';
import 'package:posts_app/features/posts/domain/repositories/delete_post_repository.dart';

class DeletePostRepositoryImpl implements DeletePostRepository {
  final NetworkInfo networkInfo;
  final ApiConsumer apiConsumer;

  DeletePostRepositoryImpl({
    required this.networkInfo,
    required this.apiConsumer,
  });
  @override
  Future<Either<Failure, void>> deletePost(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final request = await apiConsumer.delete(path: EndPoints.postId(id));
        return Right(request);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
