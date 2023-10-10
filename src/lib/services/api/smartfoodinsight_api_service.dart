import 'package:smartfoodinsight_app/common/utils/utis.dart';
import 'package:smartfoodinsight_app/features/auth/exceptions/auth_exceptions.dart';
import 'package:smartfoodinsight_app/services/api/dto/dto.dart';
import 'package:smartfoodinsight_app/services/services.dart';
import 'package:dio/dio.dart';

class SmartFoodInsightApiService extends ISmartFoodIngishtService {
  var options = Options(headers: {"requiresToken": false});
  final dio = Dio(BaseOptions(baseUrl: AppSettings.apiUrl));

  SmartFoodInsightApiService() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // get access_token
          options.headers['Authorization'] = 'Bearer your_access_token';
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          if (!isLogin(e.requestOptions)) {
            if (e.response?.statusCode == 401 ||
                e.response?.statusCode == 403) {
              // get referesh_token
              //String newAccessToken = await refreshToken();
              //e.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
              return handler.resolve(await dio.fetch(e.requestOptions));
            }
          }
          return handler.next(e);
        },
      ),
    );
  }

  @override
  Future<LoginResponse> loginAsync(LoginRequest loginRequest) async {
    try {
      final json = loginRequest.toJson();
      final response =
          await dio.post(AppSettings.apiLogin, data: json, options: options);
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
      final json = registerRequest.toJson();
      await dio.post(AppSettings.apiRegister, data: json, options: options);
    } catch (e) {
      throw WrongRegistration();
    }
  }

  bool isLogin(RequestOptions options) {
    return options.path == '/api/auth/login';
  }
}
