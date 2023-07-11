import 'dart:convert';

import 'package:poc_cubit/todo_model.dart';
import 'package:http/http.dart' as http;

class TodoRepository {
  Future<List<TodoModel>> getAll() async {
    const url = 'https://jsonplaceholder.typicode.com/todos';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      final result = json
          .map((e) => TodoModel(
                e['userId'],
                e['id'],
                e['title'],
                e['completed'],
              ))
          .toList();

      await Future.delayed(const Duration(seconds: 3));

      return result;
    } else {
      throw 'Algo inesperado aconteceu... (${response.statusCode})';
    }
  }
}
