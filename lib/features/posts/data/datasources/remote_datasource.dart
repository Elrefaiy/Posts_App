import 'package:posts_app/core/api/api_consumer.dart';
import 'package:posts_app/core/api/end_points.dart';
import 'package:posts_app/features/posts/data/models/post_model.dart';

abstract class PostsRemoteDatasource {
  Future<List<PostModel>> getAllRemotePosts();
}

class PostsRemoteDatasourceImpl implements PostsRemoteDatasource {
  final ApiConsumer apiConsumer;

  PostsRemoteDatasourceImpl({required this.apiConsumer});

  @override
  Future<List<PostModel>> getAllRemotePosts() async {
    List response = await apiConsumer.get(path: EndPoints.posts);
    return Future.value(
      List.generate(
        response.length,
        (index) => PostModel.fromJson(response[index]),
      ),
    );
  }
}
