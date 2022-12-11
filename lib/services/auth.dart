import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Future<User?> signIn(String email, String password) async {
  //   UserCredential user = await _auth.signInWithEmailAndPassword(
  //       email: email, password: password);
  //   return user.user;
  // }
  Future signIn(String email, String password) async {
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
      "tasks": [],
      "imageURL":
          "https://firebasestorage.googleapis.com/v0/b/scheduleme-adde6.appspot.com/o/placeholder.jpg?alt=media&token=9cfa9b9d-eb60-409b-8a5f-b3b54a5c1b10"
    });
    return user.user;
  }
}
