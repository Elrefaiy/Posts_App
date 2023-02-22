import 'dart:convert';
import 'dart:math';

import 'package:posts_app/core/errors/exceptions.dart';
import 'package:posts_app/core/utils/app_strings.dart';
import 'package:posts_app/features/posts/data/models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostsLocalDatasource {
  Future<List<PostModel>>? getAllLocalPosts();
  Future<void> chachePosts(List<PostModel> posts);
}

class PostsLocalDatasourceImpl implements PostsLocalDatasource {
  final SharedPreferences sharedPreferences;

  PostsLocalDatasourceImpl({required this.sharedPreferences});

  @override
  Future<List<PostModel>>? getAllLocalPosts() {
    final jsonString = sharedPreferences.getString(AppStrings.cachedPosts);
    if (jsonString != null) {
      List decodedCache = json.decode(jsonString);
      Future<List<PostModel>> cachedPosts = Future.value(
        List.generate(
          decodedCache.length,
          (index) => PostModel.fromJson(decodedCache[index]),
        ),
      );
      return cachedPosts;
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> chachePosts(List<PostModel> posts) {
    return sharedPreferences.setString(
      AppStrings.cachedPosts,
      json.encode(posts),
    );
  }
}
