import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthHelper {
  FirebaseAuthHelper._();
  static final FirebaseAuthHelper firebaseAuthHelper = FirebaseAuthHelper._();

  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  static final GoogleSignIn googleSignIn = GoogleSignIn();

  // TODO : lodinwithAnonymously()

  Future<Map<String,dynamic>> lodinwithAnonymously() async {
    Map<String,dynamic> res = {};

    try{
      UserCredential userCredential= await firebaseAuth.signInAnonymously();

      User? user = userCredential.user;

      res['user'] = user;
    }on FirebaseAuthException catch(e){
      res['error'] = e.code;
    }

    return res;
  }

  // TODO : signup()

  Future<Map<String,dynamic>> signUp({required String email, required String password}) async{
    Map<String,dynamic> res ={};

    try{
      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;
      res['user'] = user;
    }on FirebaseAuthException catch(e){
      res['error'] = e.code;
    }

    return res;
  }

  // TODO : signin()

  Future<Map<String,dynamic>> signIn({required String email, required String password}) async{

    Map<String,dynamic> res ={};
    try{
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      res['user'] = user;
    }on FirebaseAuthException catch(e){
      res['error'] = e.code;
    }

    return res;
  }
  // TODO : signinwithGoogle()

  Future<Map<String,dynamic>> signinwithGoogle({required String email, required String password}) async{

    Map<String,dynamic> res ={};

    final GoogleSignInAccount? googleuser = await googleSignIn.signIn();

    final GoogleSignInAuthentication? googleAuth = await googleuser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken:  googleAuth?.accessToken,
      idToken:  googleAuth?.idToken,
    );

    UserCredential  userCredential = await firebaseAuth.signInWithCredential(credential);

    User? user = userCredential.user;
    res['user'] = user;

    return res;
  }

  Future<void> logout() async {
    await firebaseAuth.signOut();
    await googleSignIn.signOut();
  }
}