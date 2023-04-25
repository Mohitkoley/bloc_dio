import 'package:bloc_dio/data/model/post_model.dart';
import 'package:bloc_dio/data/repositories/api/api.dart';
import 'package:dio/dio.dart';

class PostRepositories {
  final API _api = API();
  Future<List<PostModel>> fetchPosts() async {
    try {
      Response response = await _api.sendRequest.get("/posts");
      List<dynamic> posts = response.data;
      return posts.map((e) => PostModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
