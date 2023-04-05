import 'package:flutter/material.dart';
import '../../hepler/firebase_auth_helper.dart';

class notepage extends StatefulWidget {
  const notepage({Key? key}) : super(key: key);

  @override
  State<notepage> createState() => _notepageState();
}

class _notepageState extends State<notepage> {

  GlobalKey<FormState> noteKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String title = "";
  String description = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("NOTES",style: TextStyle(color: Colors.black,fontSize: 45,fontWeight: FontWeight.w900)),

                ],
              ),

              SizedBox(height: 40,),
              Form(
                key: noteKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text("Title",style: TextStyle(color: Colors.black,fontSize: 19,fontWeight: FontWeight.w500),),
                    ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(left: 30,right: 30),
                      child: Container(
                        alignment: Alignment.topLeft,
                        height: 70,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black,width: 2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Enter title First...";
                              }
                              return null;
                            },
                            onSaved: (val) {
                              title = val!;
                            },
                            controller: titleController,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(fontSize: 18),
                              border: InputBorder.none,
                              hoverColor: Colors.blue.shade800,
                              hintText: "Enter title",
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40,),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text("Description",style: TextStyle(color: Colors.black,fontSize: 19,fontWeight: FontWeight.w500),),
                    ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(left: 30,right: 30),
                      child: Container(
                        alignment: Alignment.center,
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black,width: 2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: TextFormField(
                            keyboardType: TextInputType.name,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Enter description First...";
                              }
                              return null;
                            },
                            onSaved: (val) {
                              description = val!;
                            },
                            controller: descriptionController,
                            decoration: InputDecoration(
                              alignLabelWithHint: true,
                              hintStyle: TextStyle(fontSize: 18),
                              border: InputBorder.none,
                              hoverColor: Colors.blue.shade800,
                              hintText: "Enter description",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),


              SizedBox(height: 40,),

              Container(
                alignment: Alignment.center,
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.black,
                ),
                child: Container(
                  alignment: Alignment.center,
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color:  Colors.black,
                  ),

                  child: InkWell(
                    onTap: () async {
                      if (noteKey.currentState!.validate()) {
                        noteKey.currentState!.save();

                        Map<String,dynamic>  record = {
                          "title" : title,
                          "description" : description,
                        };

                        await FirestoreDBHelper.firestoreDBHelper.insert(data: record);


                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Record insert Successfull...."),
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        Navigator.of(context).pop();
                      }
                      setState((){
                        title = "";
                        description  = "";
                        titleController.clear();
                        descriptionController.clear();
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          color:  Colors.black,
                          shape: BoxShape.circle
                      ),
                      child:  Icon(Icons.done,color: Colors.white,size: 50),
                    ),
                  ),
                ),


              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}