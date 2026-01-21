import 'package:dio/dio.dart';
import '../models/user_model.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://jsonplaceholder.typicode.com',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  ));

  Future<List<User>> fetchUsers() async {
    try {
      final response = await _dio.get('/users');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception('failed to load users');
      }
    } catch (err) {
      throw Exception('err fetching users: $err');
    }
  }

  Future<String> login(String email, String password) async {
    // added delay to look real
    await Future.delayed(const Duration(seconds: 1));

    if (email == 'chuks@gmail.com' && password == '1234') {
      return 'fake_session_token_${DateTime.now().millisecondsSinceEpoch}';
    } else {
      throw Exception('Invalid email or password');
    }
  }
}
