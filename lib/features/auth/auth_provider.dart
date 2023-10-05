import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smartfoodinsight_app/common/providers/providers.dart';
import 'package:smartfoodinsight_app/features/auth/auth_state.dart';
import 'package:smartfoodinsight_app/services/api/dto/dto.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  @override
  FutureOr<AuthState> build() {
    return const AuthState();
  }

  Future<void> logoutAsync() async {
    state = await AsyncValue.guard(() async {
      final keyStorageService = ref.read(keyStorageServiceProvider);
      await keyStorageService.removeKey('token');
      return const AuthState(
          authStatus: AuthStatus.notAuthenticated, loginResponse: null);
    });
  }

  Future<void> loginAsync(LoginRequest loginRequest) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final apiService = ref.read(apiServiceProvider);
      final keyStorageService = ref.read(keyStorageServiceProvider);
      final response = await apiService.loginAsync(loginRequest);
      String json = jsonEncode(response.toJson());
      await keyStorageService.setKeyValue('auth', json);
      return AuthState(
          authStatus: AuthStatus.authenticated, loginResponse: response);
    });
  }
}
