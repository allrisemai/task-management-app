import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:task_management_app/models/task_list_model.dart';
import 'package:task_management_app/services/dio_exception.dart';
// import 'package:task_management_app/services/dio_exception.dart';

class DioClient {
  final Dio _dio = Dio(BaseOptions(
      baseUrl: "https://todo-list-api-mfchjooefq-as.a.run.app/todo-list",
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 3000)));

  Future<TaskList?> getTodoList({
    required int id,
    int? offset,
    int? limit,
    String? status,
    String? sortBy,
    bool? isAsc,
  }) async {
    try {
      final response = await _dio.get(
          '?offset=${offset ?? 0}&limit=${limit ?? 10}${sortBy != null ? "&sortBy=$sortBy" : ""}&isAsc=${isAsc ?? true}${status != null ? '&status=$status' : ""}');
      return TaskList.fromJson(response.data);
    } on DioException catch (err) {
      final errorMessage = CustomDioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      if (kDebugMode) print(e);
      throw e.toString();
    }
  }
}
