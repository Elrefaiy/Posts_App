class EndPoints {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com/';
  static const String posts = '${baseUrl}posts';
  static String postId(int id) => '$posts/$id';
}
