import 'package:google_sign_in/google_sign_in.dart';

class GoogleService {
  static final _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  Future<void> signOutAsync() {
    return _googleSignIn.signOut();
  }

  Future<GoogleSignInAccount?> signInAsync() {
    return _googleSignIn.signIn();
  }
}
