import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smartfoodinsight_app/common/providers/providers.dart';
import 'package:smartfoodinsight_app/features/auth/auth_state.dart';
import 'package:smartfoodinsight_app/services/api/dto/dto.dart';

part 'auth_provider.g.dart';

@Riverpod()
class AuthNotifier extends _$AuthNotifier {
  @override
  FutureOr<AuthState> build() {
    //_persistenceRefreshLogic();
    return const AuthState();
  }

  Future<void> logoutAsync() async {
    state = await AsyncValue.guard(() async {
      await _clearTokenAsync();
      return const AuthState(authenticated: false, loginResponse: null);
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
      return AuthState(authenticated: true, loginResponse: response);
    });
  }

  // void _persistenceRefreshLogic() {
  //   ref.listenSelf((_, next) async {
  //     if (next.isLoading) return;
  //     if (next.hasError) {
  //       await _clearTokenAsync();
  //       return;
  //     }
  //   });
  // }

  Future<void> _clearTokenAsync() async {
    final keyStorageService = ref.read(keyStorageServiceProvider);
    await keyStorageService.removeKey('token');
  }
}
