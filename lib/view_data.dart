import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasksync/HomePage.dart';
import 'Themedata.dart';

class ViewData extends StatefulWidget {
   const ViewData({super.key,  required this.document, required this.id});
  final Map<String,dynamic> document;
  final String id;

  @override
  State<ViewData> createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  late TextEditingController titleController ;
  late TextEditingController descriptionController;
  late String type ;
  late String category =" ";
  bool edit =false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String title = widget.document["Title"] ==null ?
        "Hey there"
    :widget.document["Title"];
    titleController =TextEditingController(text: title);

    String Descrption =widget.document["Descrption"] == null ?"There is no " :widget.document["Descrption"];
    descriptionController = TextEditingController(text: Descrption);

    type =widget.document["Task"];

    category =widget.document["Category"];

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                colors: [
                  Colors.grey.shade800,
                  //Colors.black45,
                  Colors.black87
                ]
            )
        ),
        child:  SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                  },
                    icon: const Icon(
                      CupertinoIcons.arrow_left,
                      color: Colors.white,
                      size: 30,
                    ),),

                  Row(
                    children: [
                      IconButton(onPressed: (){
                        FirebaseFirestore.instance.collection("TODO").doc(widget.id).delete().then((value) => 
                        {Navigator.pop(context)});
                      },
                        icon:  const Icon(
                          Icons.delete,
                          color: Colors.red ,
                          size: 30,
                        ),),
                      IconButton(onPressed: (){
                          setState(() {
                            edit = !edit;
                          });
                      },
                        icon:  Icon(
                          Icons.edit,
                          color: edit ? Colors.green : Colors.white,
                          size: 30,
                        ),),
                    ],
                  ),
                ],
              ),
              Padding(padding: const EdgeInsets.symmetric(
                  horizontal: 25,vertical:5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                      edit ? "Editing" :"View",
                      style: const TextStyle(
                          fontSize: 33,
                          color: AppColors.Textcolors,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 8),),
                    const Text("Your TODO",
                      style: TextStyle(
                          fontSize:25,
                          color: AppColors.Textcolors,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2),),

                    const SizedBox(height: 25,),

                    lable("Task Title",),
                    const SizedBox(height: 20,),
                    Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade700,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextFormField(
                        controller: titleController,
                        enabled: edit,
                        style: const TextStyle(
                          color:Colors.white,
                          fontSize: 17,
                        ),
                        decoration: const InputDecoration(
                            hintText: "Task Title",
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 17),
                            contentPadding: EdgeInsets.only(
                                right: 20,
                                left: 20
                            )
                        ),
                      ),
                    ),
                    const  SizedBox(height: 25,),
                    lable("Task Type"),
                    const  SizedBox(height: 12,),
                    Row(
                      children: [
                        taskType("Important",0xff266d6e),
                        const  SizedBox(width: 20,),
                        taskType("Planned",0xff2bc8d9 )
                      ],
                    ),
                    const SizedBox(height: 25,),
                    lable("Description"),
                    const SizedBox(height: 12,),
                    Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade700,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextFormField(
                        controller: descriptionController,
                        enabled: edit,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,

                        ),
                        maxLines: null,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Descreption",
                            hintStyle: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 17,

                            ),
                            contentPadding: const EdgeInsets.only(left: 20,
                                right: 20)

                        ),
                      ),

                    ),
                    const SizedBox(height: 20,),
                    lable("Category"),
                    const SizedBox(height: 12,
                    ),
                    Wrap(
                      runSpacing: 10,
                      children: [
                        categorySelected("Food", 0xffff6d6e),
                        SizedBox(width: 20,),
                        categorySelected("WorkOut", 0xfff29732),
                        SizedBox(width: 20,),
                        categorySelected("Work", 0xff6557ff),
                        SizedBox(width: 20,),
                        categorySelected("Design", 0xff234ebd),
                        SizedBox(width: 20,),
                        categorySelected("Run", 0xff2bc8d9)
                      ],
                    ),
                    const SizedBox(height: 20,),
                    edit ?button(): Container(),
                    const SizedBox(height: 30,)


                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget taskType(String lable, int color){
    return InkWell(
      onTap: edit? (){
        setState(() {
          type =lable;
        });
      }:null,
      child: Chip(
        backgroundColor:type == lable ? Colors.white : Color(color),
        shape: RoundedRectangleBorder(borderRadius:
        BorderRadius.circular(10)),
        label: Text(lable,
          style: TextStyle(
            color:type == lable ? Colors.black : Colors.white,
            fontSize: 17,
          ),
        ),
        labelPadding: EdgeInsets.symmetric(
            horizontal: 17
            ,vertical: 3.8
        ),
      ),
    );
  }
  Widget categorySelected(String label, int color){
    return InkWell(
      onTap: edit?(){
        setState(() {
          category =label;
          print("categoty is working");
        });
      }:null,
      child: Chip(
        backgroundColor:category == label ? Colors.white : Color(color),
        shape: RoundedRectangleBorder(borderRadius:
        BorderRadius.circular(10)),
        label: Text(label,
          style: TextStyle(
            color:category == label ? Colors.black :Colors.white,
            fontSize: 17,
          ),
        ),
        labelPadding: EdgeInsets.symmetric(
            horizontal: 17
            ,vertical: 3.8
        ),
      ),
    );
  }

  Widget button(){
    return InkWell(
      onTap: (){
        FirebaseFirestore.instance.collection("TODO").doc(widget.id).update({
          "Title" : titleController.text,
          "Task" : type,
          "Descrption" : descriptionController.text,
          "Category" : category
        });
        Navigator.pop(context);
      },
      child: Container(
        height: 55,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                Colors.deepPurple.shade400,
                Colors.deepOrange.shade400
              ],
            )
        ),
        child:const  Center(
          child: Text(
            "Update Todo",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight:
                FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
  Widget lable(String lable){
    return Text(
      lable,
      style: const TextStyle(
        fontSize: 16.5,
        color: AppColors.Textcolors,
        fontWeight: FontWeight.w600,
        letterSpacing:  0.2,

      ),

    );

  }
}
