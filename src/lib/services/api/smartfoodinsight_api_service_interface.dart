import 'package:smartfoodinsight_app/services/api/dto/dto.dart';

abstract class ISmartFoodIngishtService {
  Future<List<SupermarketProductResponse>> supermarketsAsync(
      SupermarketRequest supermarketRequest);
  Future<TokenResponse> tokenAsync(TokenRequest tokenRequest);
  Future<UserResponse> updateUserAsync(UserRequest userRequest);
  Future<void> registerAsync(RegisterRequest registerRequest);
  Future<LoginResponse> loginAsync(LoginRequest loginRequest);
}
