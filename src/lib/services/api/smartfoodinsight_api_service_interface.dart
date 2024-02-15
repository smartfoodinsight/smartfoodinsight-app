import 'package:smartfoodinsight_app/services/api/dto/dto.dart';

abstract class ISmartFoodIngishtService {
  Future<UserResponse> updateUserAsync(UserRequest userRequest);
  Future<LoginResponse> loginAsync(LoginRequest loginRequest);
  Future<void> registerAsync(RegisterRequest registerRequest);
}
