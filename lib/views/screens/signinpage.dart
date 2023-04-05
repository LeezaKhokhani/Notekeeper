import 'package:flutter/material.dart';
import '../../hepler/firebase_helper.dart';

class signinpage extends StatefulWidget {
  const signinpage({Key? key}) : super(key: key);

  @override
  State<signinpage> createState() => _signinpageState();
}

class _signinpageState extends State<signinpage> {

  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
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
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text("        Login",
                  style: TextStyle(
                      color: Colors.black,fontSize: 40,fontWeight: FontWeight.w500),),
              ),
              SizedBox(height:50,),
              Form(
                key: loginKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text("Email",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w500),),
                    ),
                    SizedBox(height: 10,),
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
                    SizedBox(height: 30,),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text("Password",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w500),),
                    ),
                    SizedBox(height: 10,),
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

              SizedBox(height: 40,),

              Padding(
                padding: const EdgeInsets.only(left: 30,right: 30),
                child: InkWell(
                  onTap: () async {
                    if (loginKey.currentState!.validate()) {
                      loginKey.currentState!.save();

                      Map<String,dynamic> data = await FirebaseAuthHelper.firebaseAuthHelper
                          .signIn(email: email, password: password);

                      if (data['user'] != null) {

                        Navigator.of(context).pushReplacementNamed('/',arguments: data['user']);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("signIn Successfull...."),
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
                      }
                      else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("signIn Failed...."),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    }
                    setState((){
                      email = "";
                      password = "";
                      emailController.clear();
                      passwordController.clear();
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 70,
                    width: double.infinity,
                    color: Colors.black,
                    child: Text("LOGIN",style: TextStyle(color: Colors.white,fontSize: 20),),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don,t have an account?",style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.w800),),
                  InkWell(
                      onTap: (){
                        setState((){
                          Navigator.of(context).pushNamed('signuppage');
                        });
                      },
                      child: Text("  SIGN UP",style: TextStyle(color: Colors.blue,fontSize: 17,fontWeight: FontWeight.w600),)),
                ],
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}