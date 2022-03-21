import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final userStream = FirebaseAuth.instance.authStateChanges();
  final a = FirebaseAuth.instance.currentUser;

  Future<void> googleLogin() async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) return;

      final googleAuth = await googleUser.authentication;

      final authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential =
          await FirebaseAuth.instance.signInWithCredential(authCredential);

      // we must store the userCredentials for the future use in the provider
      print('------------------------------------------------');
      print('User Uid: ${UserCredential.user?.uid}');
      print('User Email: ${UserCredential.user?.email}');
      print('User Name: ${UserCredential.user?.displayName}');
      print('User Photo: ${UserCredential.user?.photoURL}');
      print('User Auth Token: ${await UserCredential.user?.getIdToken()}');
      print('------------------------------------------------');
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
