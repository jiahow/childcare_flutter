import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _signin = GoogleSignIn();

Future<FirebaseUser> SignInUser() async {
  final GoogleSignInAccount GoogleAccount = await _signin.signIn();
  final GoogleSignInAuthentication GoogleAuthentication = await GoogleAccount.authentication;

  final AuthCredential credential = await GoogleAuthProvider.getCredential(
      idToken: GoogleAuthentication.idToken , accessToken: GoogleAuthentication.accessToken);

  final AuthResult _result = await _auth.signInWithCredential(credential);
  final FirebaseUser _user = _result.user;

  assert(!_user.isAnonymous);
  assert(await _user.getIdToken() != null);

  final FirebaseUser currentuser = await _auth.currentUser();
  assert(currentuser.uid == _user.uid);

  return _user;
}