import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
GoogleSignIn _googleSignIn;
AuthorizationCredentialAppleID appleCredential;

// Future<void> signInWithGoogle() async {
//   try {
//     await _googleSignIn.signIn();
//   } catch (e) {
//     print(e);
//   }
// }

Future<User> signInWithGoogle() async {
  _googleSignIn = GoogleSignIn();
  GoogleSignInAccount _googleAccount = await _googleSignIn.signIn();
  GoogleSignInAuthentication _googleAuth = await _googleAccount.authentication;
  User user =
      (await firebaseAuth.signInWithCredential(GoogleAuthProvider.credential(
    accessToken: _googleAuth.accessToken,
    idToken: _googleAuth.idToken,
  )))
          .user;

  print(FirebaseAuth.instance.authStateChanges());

  return user;
}

Future<UserCredential> signInWithApple() async {
  appleCredential = await SignInWithApple.getAppleIDCredential(
    scopes: [
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName,
    ],
  );

  final oauthCredential = OAuthProvider("apple.com").credential(
    idToken: appleCredential.identityToken,
    accessToken: appleCredential.authorizationCode,
  );

  return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
}

signOutWithGoogle() {
  firebaseAuth.signOut();

  if (_googleSignIn != null) {
    _googleSignIn.signOut();
  }
}

Future<int> signInWithEmail({String email, String password}) async {
  // 0 : ok
  // 1 : user not found
  // 2 : wrong password
  // 3 : else

  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
      return 1;
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
      return 2;
    } else {
      return 3;
    }
  } catch (e) {
    print(e);
    return 3;
  }
  return 0;
}

Future<int> signUpWithEmail({String email, String password}) async {
  // 0 : ok
  // 1 : weak-password
  // 2 : already exists
  // 3 : else

  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
      return 1;
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
      return 2;
    } else {
      return 3;
    }
  } catch (e) {
    print(e);
    return 3;
  }
  return 0;
}
