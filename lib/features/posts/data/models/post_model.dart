import 'package:posts_app/features/posts/domain/entities/post.dart';

class PostModel extends Post {
  const PostModel({
    required int userId,
    required id,
    required title,
    required body,
  }) : super(userId: userId, id: id, title: title, body: body);

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };
}
