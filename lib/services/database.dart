import "package:cloud_firestore/cloud_firestore.dart";
import 'package:scheduleme/services/brew.dart';
import 'package:scheduleme/services/user.dart';

class DatabaseService {
  // String userid = "";
  final String? userid;
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection("brews");

  DatabaseService({this.userid});

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      userid: userid,
      name: snapshot.get('name'),
      department: snapshot.get("department"),
      surname: snapshot.get('surname'),
      courses: snapshot.get('courses'),
      groups: snapshot.get('groups'),
      plans: snapshot.get('plans'),
    );
  }

  registerUserData(String name, String surname) async {
    return await brewCollection.doc(userid).set(
      {
        'name': name,
        'surname': surname,
        'department': "Bilgisayar Mühendisliği",
        'courses': {},
        'groups': {},
        'plans': {
          "Pazartesi": {
            "06:00 - 07:00": "Plan yok.",
            "07:00 - 08:00": "Plan yok.",
            "08:00 - 09:00": "Plan yok.",
            "09:00 - 10:00": "Plan yok.",
            "10:00 - 11:00": "Plan yok.",
            "11:00 - 12:00": "Plan yok.",
            "12:00 - 13:00": "Plan yok.",
            "13:00 - 14:00": "Plan yok.",
            "14:00 - 15:00": "Plan yok.",
            "15:00 - 16:00": "Plan yok.",
            "16:00 - 17:00": "Plan yok.",
            "17:00 - 18:00": "Plan yok.",
            "18:00 - 19:00": "Plan yok.",
            "19:00 - 20:00": "Plan yok.",
            "20:00 - 21:00": "Plan yok.",
            "21:00 - 22:00": "Plan yok.",
            "22:00 - 23:00": "Plan yok.",
            "23:00 - 00:00": "Plan yok.",
          },
          "Salı": {
            "06:00 - 07:00": "Plan yok.",
            "07:00 - 08:00": "Plan yok.",
            "08:00 - 09:00": "Plan yok.",
            "09:00 - 10:00": "Plan yok.",
            "10:00 - 11:00": "Plan yok.",
            "11:00 - 12:00": "Plan yok.",
            "12:00 - 13:00": "Plan yok.",
            "13:00 - 14:00": "Plan yok.",
            "14:00 - 15:00": "Plan yok.",
            "15:00 - 16:00": "Plan yok.",
            "16:00 - 17:00": "Plan yok.",
            "17:00 - 18:00": "Plan yok.",
            "18:00 - 19:00": "Plan yok.",
            "19:00 - 20:00": "Plan yok.",
            "20:00 - 21:00": "Plan yok.",
            "21:00 - 22:00": "Plan yok.",
            "22:00 - 23:00": "Plan yok.",
            "23:00 - 00:00": "Plan yok.",
          },
          "Çarşamba": {
            "06:00 - 07:00": "Plan yok.",
            "07:00 - 08:00": "Plan yok.",
            "08:00 - 09:00": "Plan yok.",
            "09:00 - 10:00": "Plan yok.",
            "10:00 - 11:00": "Plan yok.",
            "11:00 - 12:00": "Plan yok.",
            "12:00 - 13:00": "Plan yok.",
            "13:00 - 14:00": "Plan yok.",
            "14:00 - 15:00": "Plan yok.",
            "15:00 - 16:00": "Plan yok.",
            "16:00 - 17:00": "Plan yok.",
            "17:00 - 18:00": "Plan yok.",
            "18:00 - 19:00": "Plan yok.",
            "19:00 - 20:00": "Plan yok.",
            "20:00 - 21:00": "Plan yok.",
            "21:00 - 22:00": "Plan yok.",
            "22:00 - 23:00": "Plan yok.",
            "23:00 - 00:00": "Plan yok.",
          },
          "Perşembe": {
            "06:00 - 07:00": "Plan yok.",
            "07:00 - 08:00": "Plan yok.",
            "08:00 - 09:00": "Plan yok.",
            "09:00 - 10:00": "Plan yok.",
            "10:00 - 11:00": "Plan yok.",
            "11:00 - 12:00": "Plan yok.",
            "12:00 - 13:00": "Plan yok.",
            "13:00 - 14:00": "Plan yok.",
            "14:00 - 15:00": "Plan yok.",
            "15:00 - 16:00": "Plan yok.",
            "16:00 - 17:00": "Plan yok.",
            "17:00 - 18:00": "Plan yok.",
            "18:00 - 19:00": "Plan yok.",
            "19:00 - 20:00": "Plan yok.",
            "20:00 - 21:00": "Plan yok.",
            "21:00 - 22:00": "Plan yok.",
            "22:00 - 23:00": "Plan yok.",
            "23:00 - 00:00": "Plan yok.",
          },
          "Cuma": {
            "06:00 - 07:00": "Plan yok.",
            "07:00 - 08:00": "Plan yok.",
            "08:00 - 09:00": "Plan yok.",
            "09:00 - 10:00": "Plan yok.",
            "10:00 - 11:00": "Plan yok.",
            "11:00 - 12:00": "Plan yok.",
            "12:00 - 13:00": "Plan yok.",
            "13:00 - 14:00": "Plan yok.",
            "14:00 - 15:00": "Plan yok.",
            "15:00 - 16:00": "Plan yok.",
            "16:00 - 17:00": "Plan yok.",
            "17:00 - 18:00": "Plan yok.",
            "18:00 - 19:00": "Plan yok.",
            "19:00 - 20:00": "Plan yok.",
            "20:00 - 21:00": "Plan yok.",
            "21:00 - 22:00": "Plan yok.",
            "22:00 - 23:00": "Plan yok.",
            "23:00 - 00:00": "Plan yok.",
          },
          "Cumartesi": {
            "06:00 - 07:00": "Plan yok.",
            "07:00 - 08:00": "Plan yok.",
            "08:00 - 09:00": "Plan yok.",
            "09:00 - 10:00": "Plan yok.",
            "10:00 - 11:00": "Plan yok.",
            "11:00 - 12:00": "Plan yok.",
            "12:00 - 13:00": "Plan yok.",
            "13:00 - 14:00": "Plan yok.",
            "14:00 - 15:00": "Plan yok.",
            "15:00 - 16:00": "Plan yok.",
            "16:00 - 17:00": "Plan yok.",
            "17:00 - 18:00": "Plan yok.",
            "18:00 - 19:00": "Plan yok.",
            "19:00 - 20:00": "Plan yok.",
            "20:00 - 21:00": "Plan yok.",
            "21:00 - 22:00": "Plan yok.",
            "22:00 - 23:00": "Plan yok.",
            "23:00 - 00:00": "Plan yok.",
          },
          "Pazar": {
            "06:00 - 07:00": "Plan yok.",
            "07:00 - 08:00": "Plan yok.",
            "08:00 - 09:00": "Plan yok.",
            "09:00 - 10:00": "Plan yok.",
            "10:00 - 11:00": "Plan yok.",
            "11:00 - 12:00": "Plan yok.",
            "12:00 - 13:00": "Plan yok.",
            "13:00 - 14:00": "Plan yok.",
            "14:00 - 15:00": "Plan yok.",
            "15:00 - 16:00": "Plan yok.",
            "16:00 - 17:00": "Plan yok.",
            "17:00 - 18:00": "Plan yok.",
            "18:00 - 19:00": "Plan yok.",
            "19:00 - 20:00": "Plan yok.",
            "20:00 - 21:00": "Plan yok.",
            "21:00 - 22:00": "Plan yok.",
            "22:00 - 23:00": "Plan yok.",
            "23:00 - 00:00": "Plan yok.",
          },
        },
      },
    );
  }

  Future addAndChangeCourse(
    String? name,
    String? surname,
    Map<String, dynamic>? courses,
    Map<String, dynamic>? groups,
    Map<String, dynamic>? plans,
  ) async {
    return await brewCollection.doc(userid).set(
      {
        'name': name,
        'surname': surname,
        'courses': courses,
        'groups': groups,
        'plans': plans,
      },
    );
  }

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(
        name: doc['name'] ?? '',
        sugars: doc['sugars'] ?? '100',
        strength: doc['strength'] ?? 0,
      );
    }).toList();
  }

  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  Stream<UserData> get userData {
    return brewCollection.doc(userid).snapshots().map(_userDataFromSnapshot);
  }
}
