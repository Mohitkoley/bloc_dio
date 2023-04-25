import 'package:bloc/bloc.dart';
import 'package:bloc_dio/data/model/post_model.dart';
import 'package:bloc_dio/data/repositories/post_repositories.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostLoadingState());

  PostRepositories postRepositories = PostRepositories();

  void fetchPosts() async {
    try {
      emit(PostLoadingState());
      List<PostModel> posts = await postRepositories.fetchPosts();
      emit(PostLoadedState(posts));
    } on DioError catch (e) {
      emit(PostErrorState(e.message.toString()));
    }
  }
}
