import 'package:dio/dio.dart';
import 'package:prakmob_api/model.dart';

Future<Model> getUser(String id) async {
  Response response = await Dio().get('https://reqres.in/api/users/' + id);
  return Model.fromJson(response.data);
}
