import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poc_cubit/todo_cubit.dart';
import 'package:poc_cubit/todo_state.dart';
import 'package:shimmer/shimmer.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubit = context.read<TodoCubit>();
      cubit.fetchTodo();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Cubit POC'),
      ),
      body: BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state) {
          return switch (state) {
            LoadingTodoState() || InitTodoState() => Shimmer.fromColors(
                baseColor: const Color(0xFFEBEBF4),
                highlightColor: const Color(0xFFF4F4F4),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 60,
                      child: Card(
                        child: Container(),
                      ),
                    );
                  },
                ),
              ),
            ResponseTodoState(todos: final todos) => ListView.builder(
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 60,
                    child: Card(
                      color: index % 2 == 0 ? Colors.grey.shade100 : Colors.blue.shade100,
                      child: Center(child: Text(todos[index].title)),
                    ),
                  );
                },
              ),
            ErrorTodoState(message: final message) => Center(child: Text(message)),
          };

          // if (state is InitTodoState || state is LoadingTodoState) {
          //   return const Center(
          //     child: CircularProgressIndicator(),
          //   );
          // } else if (state is ResponseTodoState) {
          //   final todos = state.todos;
          //   return ListView.builder(
          //     itemBuilder: (context, index) {
          //       return SizedBox(
          //         height: 60,
          //         child: Card(
          //           color: index % 2 == 0 ? Colors.grey.shade100 : Colors.blue.shade100,
          //           child: Center(child: Text(todos[index].title)),
          //         ),
          //       );
          //     },
          //   );
          // } else if (state is ErrorTodoState) {
          //   return Center(child: Text(state.message));
          // }
          // return const SizedBox.shrink();
        },
      ),
    );
  }
}
