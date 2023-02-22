import 'package:flutter/material.dart';
import 'package:posts_app/core/errors/exceptions.dart';
import 'package:posts_app/core/network/network_info.dart';
import 'package:posts_app/features/posts/data/datasources/local_datasource.dart';
import 'package:posts_app/features/posts/data/datasources/remote_datasource.dart';
import 'package:posts_app/features/posts/domain/entities/post.dart';
import 'package:posts_app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:posts_app/features/posts/domain/repositories/post_repository.dart';

class PostsRepositoryImpl implements PostsRepository {
  final NetworkInfo networkInfo;
  final PostsRemoteDatasource postsRemoteDatasource;
  final PostsLocalDatasource postsLocalDatasource;

  PostsRepositoryImpl({
    required this.postsRemoteDatasource,
    required this.postsLocalDatasource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await postsRemoteDatasource.getAllRemotePosts();
        postsLocalDatasource.chachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await postsLocalDatasource.getAllLocalPosts();
        if (localPosts != null) {
          return Right(localPosts);
        } else {
          debugPrint('No Cached Data ,, And There is No Network Connection');
          return left(CacheFailure());
        }
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
