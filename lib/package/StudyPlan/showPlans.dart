// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

// import '../../services/database.dart';
// import '../../services/user.dart';
// import '../Courses/deleteCourse.dart';

// class CourseList {
//   final String key;
//   final String value;

//   CourseList(this.key, this.value);
// }

// class ShowPlans extends StatefulWidget {
//   const ShowPlans({Key? key}) : super(key: key);

//   @override
//   State<ShowPlans> createState() => _ShowPlansState();
// }

// class _ShowPlansState extends State<ShowPlans> {
//   List<String> timeList = [
//     "06:00 - 07:00",
//     "07:00 - 08:00",
//     "08:00 - 09:00",
//     "09:00 - 10:00",
//     "10:00 - 11:00",
//     "11:00 - 12:00",
//     "12:00 - 13:00",
//     "13:00 - 14:00",
//     "14:00 - 15:00",
//     "15:00 - 16:00",
//     "16:00 - 17:00",
//     "17:00 - 18:00",
//     "18:00 - 19:00",
//     "19:00 - 20:00",
//     "20:00 - 21:00",
//     "21:00 - 22:00",
//     "22:00 - 23:00",
//     "23:00 - 00:00",
//   ];
//   late String data;

//   @override
//   Widget build(BuildContext context) {
//     // print(data);
//     final user = Provider.of<FUser>(context);

//     TextEditingController controller_ = TextEditingController();

//     return StreamBuilder<UserData>(
//         stream: DatabaseService(userid: user.userid).userData,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             UserData? userData = snapshot.data;
//             Map<String, dynamic>? planList = userData!.plans;
//             Map<String, dynamic> liste = userData.plans![data];
//             var sortedKey = liste.keys.toList()..sort();

//             return Scaffold(
//               body: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     IconButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       icon: Icon(Icons.arrow_back_rounded),
//                     ),
//                     Column(
//                       children: [
//                         ListView.separated(
//                           physics: const NeverScrollableScrollPhysics(),
//                           scrollDirection: Axis.vertical,
//                           shrinkWrap: true,
//                           separatorBuilder: (BuildContext context, int index) =>
//                               const Divider(),
//                           itemBuilder: (context, index) {
//                             return ListTile(
//                               title: Text(sortedKey[index]),
//                               subtitle: Text(planList![data][sortedKey[index]]),
//                             );
//                           },
//                           itemCount: 18,
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }

//           return const Scaffold(
//               body: Center(child: SpinKitWave(color: Colors.red, size: 30)));
//         });
//   }
// }
