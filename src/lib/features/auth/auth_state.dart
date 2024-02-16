import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState(
      {@Default(AuthStatus.nothing) AuthStatus authStatus}) = _AuthState;
}

enum AuthStatus { authenticated, registrated, nothing }
