import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smartfoodinsight_app/services/api/dto/dto.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState(
      {LoginResponse? loginResponse,
      @Default(false) bool authenticated}) = _AuthState;
}
