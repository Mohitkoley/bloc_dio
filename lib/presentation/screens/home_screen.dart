import 'package:bloc_dio/data/model/post_model.dart';
import 'package:bloc_dio/data/repositories/post_repositories.dart';
import 'package:bloc_dio/logic/cubit/post_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PostRepositories postRepositories = PostRepositories();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<PostCubit>(context).fetchPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("API Handling")),
      body: SafeArea(
          child: BlocConsumer<PostCubit, PostState>(
        listener: ((context, state) {
          if (state is PostErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error),
            ));
          }
        }),
        builder: (context, state) {
          if (state is PostLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostLoadedState) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                PostModel post = state.posts[index];
                return ListTile(
                  title: Text(post.title),
                  subtitle: Text(post.body),
                );
              },
            );
          } else if (state is PostErrorState) {
            return const Center(
              child: Text("Error Feching Data"),
            );
          } else {
            return const Center(child: Text("No Data"));
          }
        },
      )),
    );
  }
}
