import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/storage_service.dart';
import 'user_provider.dart';
import '../utils/api_service.dart';

final storageServiceProvider = Provider((ref) => StorageService());

final authProvider = StateNotifierProvider<AuthNotifier, bool>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  final apiService = ref.watch(apiServiceProvider);
  return AuthNotifier(storageService, apiService);
});

class AuthNotifier extends StateNotifier<bool> {
  final StorageService _storageService;

  AuthNotifier(this._storageService, this._apiService) : super(false) {
    _checkAuth();
  }

  final ApiService _apiService;

  Future<void> _checkAuth() async {
    final token = await _storageService.getToken();
    state = token != null;
  }

  Future<void> login(String email, String password) async {
    try {
      final token = await _apiService.login(email, password);
      await _storageService.saveToken(token);
      state = true;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    await _storageService.deleteToken();
    state = false;
  }
}
