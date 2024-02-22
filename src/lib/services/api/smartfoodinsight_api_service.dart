import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:smartfoodinsight_app/common/utils/utis.dart';
import 'package:smartfoodinsight_app/features/auth/exceptions/auth_exceptions.dart';
import 'package:smartfoodinsight_app/services/api/dto/dto.dart';
import 'package:smartfoodinsight_app/services/services.dart';
import 'package:smartfoodinsight_app/common/providers/providers.dart';

class SmartFoodInsightApiService extends ISmartFoodIngishtService {
  final ProviderRef ref;

  var options = Options(headers: {"requiresToken": false});
  final dio = Dio(BaseOptions(baseUrl: AppSettings.apiUrl));

  bool isLogin(RequestOptions options) {
    return options.path == '/api/auth/login';
  }

  SmartFoodInsightApiService({required this.ref}) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // get access_token
          final loginResponse =
              await ref.read(authNotifierProvider.notifier).userAsync();
          options.headers['Authorization'] =
              'bearer ${loginResponse?.accessToken}';
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          if (!isLogin(e.requestOptions)) {
            if (e.response?.statusCode == 401 ||
                e.response?.statusCode == 403) {
              // get referesh_token
              final loginResponse =
                  await ref.read(authNotifierProvider.notifier).userAsync();

              final tokenResponse = await tokenAsync(TokenRequest(
                  id: loginResponse!.user.id,
                  token: loginResponse.refreshToken));

              final newLoginResponse = loginResponse.copyWith(
                  accessToken: tokenResponse.accessToken,
                  refreshToken: tokenResponse.refreshToken);

              await ref
                  .read(authNotifierProvider.notifier)
                  .saveUserAsync(newLoginResponse);

              e.requestOptions.headers['Authorization'] =
                  'bearer ${tokenResponse.accessToken}';
              return handler.resolve(await dio.fetch(e.requestOptions));
            }
          }
          return handler.next(e);
        },
      ),
    );
  }

  @override
  Future<UserResponse> updateUserAsync(UserRequest userRequest) async {
    try {
      final userJson = userRequest.toJson();
      final response = await dio.patch(AppSettings.apiUser, data: userJson);
      final apiResponse = ApiUtils.parseData(
          response.data, (json) => UserResponse.fromJson(json));
      return apiResponse;
    } catch (e) {
      throw WrongCredentials();
    }
  }

  @override
  Future<LoginResponse> loginAsync(LoginRequest loginRequest) async {
    try {
      final loginJson = loginRequest.toJson();
      final response = await dio.post(AppSettings.apiLogin,
          data: loginJson, options: options);
      final apiResponse = ApiUtils.parseData(
          response.data, (json) => LoginResponse.fromJson(json));
      return apiResponse;
    } catch (e) {
      throw WrongCredentials();
    }
  }

  @override
  Future<void> registerAsync(RegisterRequest registerRequest) async {
    try {
      final registerJson = registerRequest.toJson();
      await dio.post(AppSettings.apiRegister,
          data: registerJson, options: options);
    } catch (e) {
      throw WrongRegistration();
    }
  }

  @override
  Future<TokenResponse> tokenAsync(TokenRequest tokenRequest) async {
    try {
      final tokenJson = tokenRequest.toJson();
      final response = await dio.post(AppSettings.apiToken,
          data: tokenJson, options: options);
      final apiResponse = ApiUtils.parseData(
          response.data, (json) => TokenResponse.fromJson(json));
      return apiResponse;
    } catch (e) {
      throw WrongCredentials();
    }
  }
}
