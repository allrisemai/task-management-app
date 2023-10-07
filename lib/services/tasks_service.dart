import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:task_management_app/models/task_info_model.dart';
import 'package:task_management_app/services/dio_client.dart';
import 'package:task_management_app/services/dio_exception.dart';

class TasksService {
  DioClient dio = DioClient();

  Future<TaskInfo?> getTaskList({
    int? offset,
    int? limit,
    String? status,
    String? sortBy,
    bool? isAsc,
  }) async {
    try {
      final params = status != null
          ? <String, dynamic>{
              "offset": offset ?? 0,
              "limit": limit ?? 10,
              'sortBy': sortBy ?? 'createdAt',
              "isAsc": isAsc ?? true,
              "status": status
            }
          : <String, dynamic>{
              "offset": offset ?? 0,
              "limit": limit ?? 10,
              'sortBy': sortBy ?? '',
              "isAsc": isAsc ?? true,
            };
      final response = await dio.get('/todo-list', queryParameters: params);
      return TaskInfo.fromJson(response);
    } on DioException catch (err) {
      final errorMessage = CustomDioException.fromDioError(err).toString();
      if (kDebugMode) {
        print(err.response?.data['message']);
        print(errorMessage);
      }
      return null;
    } catch (e) {
      if (kDebugMode) print(e);
      throw e.toString();
    }
  }
}
