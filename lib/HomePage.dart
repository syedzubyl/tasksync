import 'package:flutter/material.dart';
import 'package:tasksync/AddTodopage.dart';
import 'package:tasksync/Modules/AddOnCard.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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

          IconButton(onPressed: (){}, icon: const Icon(
            Icons.person,
            size: 40,
          ),color: Colors.white,
          hoverColor: Colors.white,),
        ],
        bottom:const  PreferredSize(
          preferredSize: Size.fromHeight(35),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 22),
              child: Text(
                "Monday 21",
                style: TextStyle(
                  fontSize: 33,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
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
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>const AddTodopage()));
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
                child: const  Icon(
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

      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
          child:  const Column(
            children: [
              AddOnCard(
                title: "wake up me",
                check: false,
                iconBgColor: Colors.white,
                iconColor: Colors.red,
                iconData: Icons.alarm,
                time: "11 pm",

              ),
              SizedBox(height: 10,),
              AddOnCard(title: "work", iconData: Icons.work, iconColor: Colors.blue, iconBgColor: Colors.grey, check: true, time: "12 pm"),
              SizedBox(height: 10,),
              AddOnCard(
                title: "wake up me",
                check: false,
                iconBgColor: Colors.white,
                iconColor: Colors.red,
                iconData: Icons.alarm,
                time: "11 pm",

              ),
              SizedBox(height: 10,),
              AddOnCard(title: "work", iconData: Icons.work, iconColor: Colors.blue, iconBgColor: Colors.grey, check: true, time: "12 pm"),
              AddOnCard(
                title: "wake up me",
                check: false,
                iconBgColor: Colors.white,
                iconColor: Colors.red,
                iconData: Icons.alarm,
                time: "11 pm",

              ),
              SizedBox(height: 10,),
              AddOnCard(title: "work", iconData: Icons.work, iconColor: Colors.blue, iconBgColor: Colors.grey, check: true, time: "12 pm"),
              SizedBox(height: 10,),
              AddOnCard(
                title: "wake up me",
                check: false,
                iconBgColor: Colors.white,
                iconColor: Colors.red,
                iconData: Icons.alarm,
                time: "11 pm",

              ),
              SizedBox(height: 10,),
              AddOnCard(title: "work", iconData: Icons.work, iconColor: Colors.blue, iconBgColor: Colors.grey, check: true, time: "12 pm")


            ],
          ),
        ),
      ),
    );
  }
}
