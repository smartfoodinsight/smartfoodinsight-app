import 'package:google_sign_in/google_sign_in.dart';

class GoogleService {
  static final _googleSignIn = GoogleSignIn(
    clientId:
        '107593397554-uau4abj8bc34rpiv24hle40cib87bv46.apps.googleusercontent.com',
    scopes: [
      'openid',
      'email',
    ],
  );

  Future<void> signOutAsync() {
    return _googleSignIn.signOut();
  }

  Future<String?> signInAsync() async {
    final googleSignInAccount = await _googleSignIn.signIn();
    final googleSignInAuthentication =
        await googleSignInAccount?.authentication;
    return googleSignInAuthentication?.idToken;
  }
}
