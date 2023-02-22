import 'package:flutter/material.dart';
import 'package:posts_app/core/network/network_info.dart';
import 'package:posts_app/features/posts/data/datasources/remote_datasource.dart';
import 'package:posts_app/features/posts/domain/entities/post.dart';
import 'package:posts_app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:posts_app/features/posts/domain/repositories/post_repository.dart';

class PostsRepositoryImpl implements PostsRepository {
  final NetworkInfo networkInfo;
  final PostsRemoteDatasource postsRemoteDatasource;

  PostsRepositoryImpl({
    required this.postsRemoteDatasource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await postsRemoteDatasource.getAllPosts();
        return Right(remotePosts);
      } on ServerFailure {
        return Left(ServerFailure());
      }
    } else {
      debugPrint('There Is No Internet Connection');
      return Left(ServerFailure());
    }
  }
}
