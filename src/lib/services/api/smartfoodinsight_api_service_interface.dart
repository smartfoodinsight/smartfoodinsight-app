import 'package:smartfoodinsight_app/services/api/dto/dto.dart';

abstract class ISmartFoodIngishtService {
  Future<LoginResponse> loginGoogleAsync(LoginGoogleRequest loginGoogleRequest);
  Future<List<SupermarketResponse>> supermarketsAsync();
  Future<List<SupermarketProductResponse>> supermarketsProductsAsync(
      SupermarketRequest supermarketRequest);
  Future<TokenResponse> tokenAsync(TokenRequest tokenRequest);
  Future<UserResponse> updateUserAsync(UserRequest userRequest);
  Future<void> resetPasswordAsync(UserEmailRequest userEmailRequest);
  Future<void> registerAsync(RegisterRequest registerRequest);
  Future<LoginResponse> loginAsync(LoginRequest loginRequest);
}
