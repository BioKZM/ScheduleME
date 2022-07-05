import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../services/auth.dart';
import '../services/brew.dart';
import '../services/brewList.dart';
import '../services/database.dart';

// class Test extends StatelessWidget {
//   final AuthService _auth = AuthService();

//   @override
//   Widget build(BuildContext context) {
//     return StreamProvider<List<Brew>>.value(
//       initialData: [],
//       value: DatabaseService().brews,
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           title: Text("Text"),
//           backgroundColor: Colors.red,
//           elevation: 0.0,
//           actions: <Widget>[
//             TextButton.icon(
//                 icon: Icon(Icons.person),
//                 label: Text("logout"),
//                 onPressed: () async {
//                   await _auth.signOut();
//                 })
//           ],
//         ),
//         body: BrewList(),
//       ),
//     );
//   }
// }
