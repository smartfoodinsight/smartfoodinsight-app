import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:smartfoodinsight_app/common/providers/providers.dart';
import 'package:smartfoodinsight_app/features/auth/auth_state.dart';
import 'package:smartfoodinsight_app/services/api/dto/dto.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  static const _sharedPrefsKey = 'auth';
  @override
  FutureOr<AuthState> build() {
    _persistenceRefreshLogic();
    return _loginRecoveryAttempt();
  }

  Future<AuthState> _loginRecoveryAttempt() async {
    try {
      final loginReponse = await userAsync();
      if (loginReponse == null) return const AuthState();

      return AuthState(
          authStatus: AuthStatus.authenticated, loginResponse: loginReponse);
    } catch (_, __) {
      await _clearUserAsync();
      return const AuthState();
    }
  }

  Future<void> logoutAsync() async {
    state = await AsyncValue.guard(() async {
      await _clearUserAsync();
      return const AuthState();
    });
  }

  Future<void> registerAsync(RegisterRequest registerRequest) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final apiService = ref.read(apiServiceProvider);
      await apiService.registerAsync(registerRequest);
      return const AuthState(authStatus: AuthStatus.registrated);
    });
  }

  Future<void> loginAsync(LoginRequest loginRequest) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final apiService = ref.read(apiServiceProvider);
      final keyStorageService = ref.read(keyStorageServiceProvider);
      final response = await apiService.loginAsync(loginRequest);
      String json = jsonEncode(response.toJson());
      await keyStorageService.writeSecureData(_sharedPrefsKey, json);
      return AuthState(
          authStatus: AuthStatus.authenticated, loginResponse: response);
    });
  }

  void _persistenceRefreshLogic() {
    ref.listenSelf((_, next) async {
      if (next.isLoading) return;
      if (next.hasError) {
        await _clearUserAsync();
        return;
      }
    });
  }

  Future<LoginResponse?> userAsync() async {
    final keyStorageService = ref.read(keyStorageServiceProvider);
    String? json = await keyStorageService.readSecureData(_sharedPrefsKey);
    if (json != null) {
      return LoginResponse.fromJson(jsonDecode(json));
    }
    return null;
  }

  Future<void> _clearUserAsync() async {
    final keyStorageService = ref.read(keyStorageServiceProvider);
    await keyStorageService.deleteSecureData(_sharedPrefsKey);
  }
}
