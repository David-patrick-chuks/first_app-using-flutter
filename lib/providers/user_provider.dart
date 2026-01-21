import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../utils/api_service.dart';

final apiServiceProvider = Provider((ref) => ApiService());

final usersProvider = FutureProvider<List<User>>((ref) async {
  final apiService = ref.watch(apiServiceProvider);
  return await apiService.fetchUsers();
});
