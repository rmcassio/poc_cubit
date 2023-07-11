import 'package:poc_cubit/todo_model.dart';

sealed class TodoState {}

class InitTodoState extends TodoState {}

class LoadingTodoState extends TodoState {}

class ErrorTodoState extends TodoState {
  final String message;
  ErrorTodoState(this.message);
}

class ResponseTodoState extends TodoState {
  final List<TodoModel> todos;
  ResponseTodoState(this.todos);
}
