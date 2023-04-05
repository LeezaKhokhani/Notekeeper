import 'package:flutter/material.dart';

import '../../hepler/firebase_helper.dart';

class signuppage extends StatefulWidget {
  const signuppage({Key? key}) : super(key: key);

  @override
  State<signuppage> createState() => _signuppageState();
}

class _signuppageState extends State<signuppage> {

  GlobalKey<FormState> signupKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String email = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),

              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text("      Signup",style: TextStyle(color:Colors.black,fontSize: 40,fontWeight: FontWeight.w700),),
              ),
              SizedBox(height: 40,),
              Form(
                key: signupKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text("Email",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w500),),
                    ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(left: 30,right: 30),
                      child: Container(
                        alignment: Alignment.center,
                        height: 70,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black,width: 2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Enter Email First...";
                              }
                              return null;
                            },
                            onSaved: (val) {
                              email = val!;
                            },
                            controller: emailController,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(fontSize: 18),
                              border: InputBorder.none,
                              hoverColor: Colors.blue.shade800,
                              hintText: "Enter Email",
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40,),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text("Password",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w500),),
                    ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(left: 30,right: 30),
                      child: Container(
                        alignment: Alignment.center,
                        height: 70,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black,width: 2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Enter Password First...";
                              }
                              return null;
                            },
                            onSaved: (val) {
                              password = val!;
                            },
                            controller: passwordController,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(fontSize: 18),
                              border: InputBorder.none,
                              hoverColor: Colors.blue.shade800,
                              hintText: "Enter Password",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),


              SizedBox(height: 60,),

              Padding(
                padding: const EdgeInsets.only(left: 30,right: 30),
                child: InkWell(
                  onTap: () async {
                    if (signupKey.currentState!.validate()) {
                      signupKey.currentState!.save();

                      Map<String, dynamic> data = await FirebaseAuthHelper
                          .firebaseAuthHelper
                          .signUp(email: email, password: password);

                      if (data['user'] != null) {
                        Navigator.of(context).pushReplacementNamed('/',arguments: data['user']);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("signup Successfull...."),
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      } else if (data['error'] != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(data['error']),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("signup Failed...."),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    }
                    email = "";
                    password = "";
                    emailController.clear();
                    passwordController.clear();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 70,
                    width: double.infinity,
                    color: Colors.black,
                    child: Text("CREATE ACCOUNT",style: TextStyle(color: Colors.white,fontSize: 20),),
                  ),
                ),
              ),


              SizedBox(height: 20,),

            ],
          ),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}