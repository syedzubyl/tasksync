import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tasksync/AddTodopage.dart';
import 'package:tasksync/Modules/AddOnCard.dart';
import 'package:tasksync/view_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Stream<QuerySnapshot> stream =
  FirebaseFirestore.instance.collection("TODO").snapshots();

  List<Select> selected = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text(
          "Today's Schedule",
          style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold
          ),
        ),
        actions: [

          IconButton(onPressed: () {}, icon: const Icon(
            Icons.person,
            size: 40,
          ), color: Colors.white,
            hoverColor: Colors.white,),
        ],
        bottom:const  PreferredSize(
          preferredSize: Size.fromHeight(35),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                children: [
                   Text(
                    "Monday 21",
                    style: TextStyle(
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black87,
        items: [
          const BottomNavigationBarItem(icon: Icon(
            Icons.home,
            size: 32,
            color: Colors.white,
          ),
            label: "",

          ),
          BottomNavigationBarItem(

            icon: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const AddTodopage()));
              },
              child: Container(
                height: 52,
                width: 52,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        colors: [
                          Colors.indigoAccent,
                          Colors.purple
                        ]
                    )
                ),
                child: const Icon(
                  Icons.add,
                  size: 32,
                  color: Colors.white,
                ),
              ),
            ),
            label: "the",
          ),

          const BottomNavigationBarItem(icon: Icon(
            Icons.settings,
            size: 32,
            color: Colors.white,
          ),
            label: "the",
          ),
        ],
      ),

      body: StreamBuilder(
          stream: stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  IconData iconData;
                  Color iconColor;
                  Map<String, dynamic> document =
                  snapshot.data?.docs[index].data() as Map<String, dynamic>;
                  String id =
                  snapshot.data?.docs[index].id as String;
                  switch (document["Category"]) {
                    case"Work":
                      iconColor = Colors.pink;
                      iconData = Icons.work_outline;
                      break;
                    case"Food" :
                      iconData = Icons.food_bank_outlined;
                      iconColor = Colors.green;
                      break;
                    case"WorkOut" :
                      iconData = Icons.alarm;
                      iconColor = Colors.yellow;
                      break;
                    case"Design" :
                      iconData = Icons.design_services;
                      iconColor = Colors.purple;
                      break;
                    case"Run" :
                      iconData = Icons.run_circle;
                      iconColor = Colors.blueAccent;
                      break;
                    default:
                      iconData = Icons.run_circle_outlined;
                      iconColor = Colors.red;
                  }
                  selected.add(Select(id: id, checkValue: false));
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (builder) =>
                            ViewData(
                              document: document,
                              id: id,
                            ),
                      ),
                      );
                    },
                    child: AddOnCard(
                      title: document["Title"] ?? "Hey there",
                      check: selected[index].checkValue,
                      iconBgColor: Colors.white,
                      iconColor: iconColor,
                      iconData: iconData,
                      time: "11 pm",
                      index: index,
                      onChange: onChange,

                    ),
                  );
                });
          }
      ),
    );
  }

  void onChange(int index){
    setState(() {
      selected[index].checkValue = !selected[index].checkValue;
    });
  }
}
class Select{
  String id;
  bool checkValue = false;
  Select({required this.id,required this.checkValue});
}