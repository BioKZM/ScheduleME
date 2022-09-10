import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signIn(String email, String password) async {
    // var user =
    //     _auth.signInWithEmailAndPassword(email: email, password: password);
    // return user.user;
    UserCredential user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.user;
  }

  signOut() async {
    return await _auth.signOut();
  }

  Future<User?> registerENP(String name, String surname, String email,
      String password, String class_) async {
    var plans = [
      {
        'dayName': "Pazartesi",
        "plans": [],
      },
      {
        'dayName': "Salı",
        "plans": [],
      },
      {
        'dayName': "Çarşamba",
        "plans": [],
      },
      {
        'dayName': "Perşembe",
        "plans": [],
      },
      {
        'dayName': "Cuma",
        "plans": [],
      },
      {
        'dayName': "Cumartesi",
        "plans": [],
      },
      {
        'dayName': "Pazar",
        "plans": [],
      },
    ];
    UserCredential user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    await _firestore.collection("brews").doc(user.user?.email).set({
      'name': "${name} ${surname}",
      'email': email,
      "class": class_,
      "courses": [],
      "groups": [],
      "plans": plans,
      "tasks": []
    });
    return user.user;
  }
}
