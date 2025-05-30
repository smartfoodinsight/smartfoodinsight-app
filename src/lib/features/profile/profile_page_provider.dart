import 'package:formz/formz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smartfoodinsight_app/common/providers/providers.dart';
import 'package:smartfoodinsight_app/common/utils/utis.dart';

import 'package:smartfoodinsight_app/common/validations/validations.dart';
import 'package:smartfoodinsight_app/features/profile/forms/profile_state.dart';
import 'package:smartfoodinsight_app/services/api/dto/dto.dart';

part 'profile_page_provider.g.dart';

@riverpod
class ProfilePageNotifier extends _$ProfilePageNotifier {
  late LoginResponse loginResponse;

  @override
  FutureOr<ProfileFormsState> build() async {
    loginResponse = await ref.read(authNotifierProvider.notifier).userAsync()
        as LoginResponse;

    final id = loginResponse.user.id;
    final name = TextFormz.dirty(loginResponse.user.name);
    final email = EmailFormz.dirty(loginResponse.user.email);
    final picture = loginResponse.user.picture;

    return ProfileFormsState(
        id: id, name: name, email: email, picture: picture);
  }

  void onNameChanged(String value) {
    final name = TextFormz.dirty(value);
    state = AsyncValue.data(
        state.value!.copyWith(name: name, isValid: Formz.validate([name])));
  }

  void onEmailChanged(String value) {
    final email = EmailFormz.dirty(value);
    state = AsyncValue.data(
        state.value!.copyWith(email: email, isValid: Formz.validate([email])));
  }

  void onPictureChanged(String value) {
    state = AsyncValue.data(state.value!.copyWith(picture: value));
  }

  void onFormSubmit(String id) async {
    _touchEveryField();

    final formsState = state.value!;

    if (!formsState.isValid) return;

    String picture = Helper().fileCloudinary(formsState.picture!);

    var userRequest = UserRequest(
        id: id,
        name: formsState.name.value,
        email: formsState.email.value,
        picture: picture);

    state = AsyncValue.data(formsState.copyWith(isLoading: true));

    final userResponse =
        await ref.read(apiServiceProvider).updateUserAsync(userRequest);

    final loginResponse =
        await ref.read(authNotifierProvider.notifier).userAsync();

    var newLoginResponse = loginResponse!.copyWith(user: userResponse);

    await ref
        .read(authNotifierProvider.notifier)
        .saveUserAsync(newLoginResponse);

    state = AsyncValue.data(formsState.copyWith(isLoading: false));
  }

  void _touchEveryField() {
    final formsState = state.value!;

    final name = TextFormz.dirty(formsState.name.value);
    final email = EmailFormz.dirty(formsState.email.value);
    final picture = formsState.picture;

    state = AsyncValue.data(formsState.copyWith(
        isFormPosted: true,
        name: name,
        email: email,
        picture: picture,
        isValid: Formz.validate([name, email])));
  }
}
