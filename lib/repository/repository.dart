import 'package:dio/dio.dart';
import 'package:your_recipe/repository/abstract_repository.dart';

class Repository extends AbstractRepository {
  Repository({required this.dio});

  final Dio dio;

}