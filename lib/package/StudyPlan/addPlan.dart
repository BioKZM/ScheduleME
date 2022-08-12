import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../services/database.dart';
import '../../services/user.dart';

class CourseList {
  final String key;
  final String value;

  CourseList(this.key, this.value);
}

class Days {
  final String title;
  const Days(this.title);
}

class AddPlan extends StatefulWidget {
  const AddPlan({Key? key}) : super(key: key);

  @override
  State<AddPlan> createState() => _AddPlanState();
}

class _AddPlanState extends State<AddPlan> {
  List<String> dayList = [
    'Pazartesi',
    'Salı',
    'Çarşamba',
    'Perşembe',
    'Cuma',
    'Cumartesi',
    'Pazar'
  ];
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FUser>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(userid: user.userid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.hasError.toString());
            UserData? userData = snapshot.data;
            return Scaffold(
                body: ListView(
              children: <Widget>[
                Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_rounded)),
                    Column(
                      children: [
                        const SizedBox(
                          child: Text(
                            "Çalışma Programı",
                            style: TextStyle(
                                fontFamily: "NotoSansBold", fontSize: 25),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 250,
                          height: 1,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          height: 120,
                        ),
                        SizedBox(
                          height: 900,
                          width: 400,
                          child: ListView.separated(
                            itemCount: dayList.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(),
                            itemBuilder: (context, index) {
                              return ListTile(
                                onTap: () {
                                  // print(dayList[index]);
                                  // Navigator.pushNamed(context, "/days");
                                  // Navigator.of(context).push(MaterialPageRoute(builder: builder))
                                  // Navigator.of(context).push(route)
                                  Navigator.pushReplacementNamed(
                                      context, "/days",
                                      arguments: dayList[index]);
                                },
                                title: Text(
                                  dayList[index],
                                  style: const TextStyle(
                                      fontFamily: "NotoSansLight",
                                      fontSize: 20),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
                // const ListTile(
                //   title: Text("Pazartesi"),
                // ),
                // const ListTile(
                //   title: Text("Salı"),
                // ),
                // const ListTile(
                //   title: Text("Çarşamba"),
                // ),
                // const ListTile(
                //   title: Text("Perşembe"),
                // ),
                // const ListTile(
                //   title: Text("Cuma"),
                // ),
                // const ListTile(
                //   title: Text("Cumartesi"),
                // ),
                // const ListTile(
                //   title: Text("Pazar"),
                // ),
              ],
            ));
          }

          return const Scaffold(
              body: Center(child: SpinKitWave(color: Colors.red, size: 30)));
        });
  }
}
