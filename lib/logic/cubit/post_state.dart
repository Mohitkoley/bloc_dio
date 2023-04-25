part of 'post_cubit.dart';

@immutable
abstract class PostState {}

class PostInitial extends PostState {}

class PostLoadingState extends PostState {}

class PostLoadedState extends PostState {
  final List<PostModel> posts;

  PostLoadedState(this.posts);
}

class PostErrorState extends PostState {
  final String error;

  PostErrorState(this.error);
}
