import 'package:firebase_auth/firebase_auth.dart';
import 'database.dart';
import "user.dart";

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FUser? _userFromFirebaseUser(User user) {
    // ignore: unnecessary_null_comparison
    if (user != null) {
      return FUser(userid: user.uid);
    } else {
      return null;
    }
  }

  Stream<FUser?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user!));
  }

  Future registerENP(
    String email,
    String password,
    String name,
    String surname,
  ) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      await DatabaseService(userid: user!.uid).registerUserData(name, surname);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString);
      return null;
    }
  }

  Future signENP(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString);
      return null;
    }
  }

  // Register

  // Sign Out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
