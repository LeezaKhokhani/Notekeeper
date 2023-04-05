import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../hepler/firebase_auth_helper.dart';


class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  final GlobalKey<FormState> updateFormKey = GlobalKey<FormState>();

  TextEditingController updateTitleController = TextEditingController();
  TextEditingController updateDescController = TextEditingController();

  String title = "";
  String description = "";

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    User user = ModalRoute.of(context)!.settings.arguments as User;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        toolbarHeight: 60,
        centerTitle: true,
        title: Text("Note Keeper",style: TextStyle(color:  Colors.black,fontSize: 27,fontWeight: FontWeight.w800),),
        backgroundColor: Colors.white,
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 80,),
            CircleAvatar(
              radius: 80,
              backgroundImage: (user.photoURL != null)
                  ? NetworkImage(user.photoURL as String)
                  : null,
            ),
            SizedBox(height: 20,),
            Divider(height: 6,color: Colors.grey,),
            SizedBox(height: 20,),
            (user.isAnonymous)
                ? Text("Anonymos user",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w800,color:  Colors.black,),)
                : (user.displayName == null)
                ? Container()
                : Text("${user.displayName}",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w800,color:  Colors.black,),),
            SizedBox(height: 10,),
            (user.isAnonymous)? Container()
                : Text("Email : ${user.email}"),
          ],
        ),
      ),


      body: Center(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("notes").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("ERROR: ${snapshot.error}"),
              );
            } else if (snapshot.hasData) {
              QuerySnapshot<Map<String, dynamic>> data =
              snapshot.data as QuerySnapshot<Map<String, dynamic>>;

              List<QueryDocumentSnapshot<Map<String, dynamic>>> allDocs =
                  data.docs;

              return ListView.builder(
                itemCount: allDocs.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: 160,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    SizedBox(width: 30,),
                                    Text("Title : ",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w800),),
                                    Text("${allDocs[i].data()['title']}",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w800),),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 30),
                                  child: Text("${allDocs[i].data()['description']}",style: TextStyle(color: Colors.white,fontSize: 19,fontWeight: FontWeight.w800),),
                                ),
                                Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(onPressed: (){
                                      updateData(context, id: allDocs[i].id, updateTitle: allDocs[i].data()['title'], updateDesc: allDocs[i].data()['description']);

                                    }, icon: Icon(Icons.edit,size: 30,color: Colors.blue,)),
                                    IconButton(onPressed: (){
                                      deleteData(id: allDocs[i].id);
                                    }, icon: Icon(Icons.delete,size: 30,color: Colors.red),),
                                    SizedBox(width: 10,),
                                  ],
                                ),
                                SizedBox(height: 10,),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );

                },
              );
            }
            return Container();
          },
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('notepage');
        },
        shape: const CircleBorder(),

        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          color: Colors.blue,
          size: 40,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 60,
        ),
      ),
      backgroundColor: Colors.white,
    );
  }





  updateData(BuildContext context, {required String id, required String updateTitle, required String updateDesc}) {
    updateTitleController.text = updateTitle;
    updateDescController.text = updateDesc;

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.purple.shade100,
            title:  Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Update",style: TextStyle(color: Colors.black,fontSize: 45,fontWeight: FontWeight.w900)),

              ],
            ),
            content: Form(
              key: updateFormKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: updateTitleController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter title";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        setState(() {
                          title = val!;
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Title",
                        hintText: "Enter title",
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      maxLines: 5,
                      controller: updateDescController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter description";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        setState(() {
                          description = val!;
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Description",
                        alignLabelWithHint: true,
                        hintText: "Enter description...",
                        hintStyle: TextStyle(color: Color(0xff513B60)),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () async {
                  if (updateFormKey.currentState!.validate()) {
                    updateFormKey.currentState!.save();

                    Map<String,dynamic>  record = {
                      "title" : updateTitle,
                      "description" : updateDesc,
                    };

                    await FirestoreDBHelper.firestoreDBHelper.update(id: id, data: record);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Record insert Successfull...."),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    Navigator.of(context).pop();

                  }
                  updateTitleController.clear();
                  updateDescController.clear();

                  setState(() {
                    title = "";
                    description = "";
                  });
                  Navigator.pop(context);
                },
                child: const Text("Update",style: TextStyle(color: Color(0xff513B60)),),
              ),
              OutlinedButton(
                onPressed: () {
                  updateTitleController.clear();
                  updateDescController.clear();

                  setState(() {
                    title = "";
                    description = "";
                  });

                  Navigator.pop(context);
                },
                child: const Text("cancel",style: TextStyle(color: Color(0xff513B60)),),
              ),
            ],
          );
        });
  }



  deleteData({required String id}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        alignment: Alignment.center,
        title: const Text("Delete Data",style: TextStyle(color: Colors.red),),
        content: const Text(
          "Are you sure for delete",
        ),
        actions: [
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              FirestoreDBHelper.firestoreDBHelper.delete(id: id);
              Navigator.of(context).pop();
            },
            child: const Text("Ok"),
          ),
        ],
      ),
    );
  }

}