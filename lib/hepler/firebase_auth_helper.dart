import 'package:cloud_firestore/cloud_firestore.dart';

class  FirestoreDBHelper {
  FirestoreDBHelper._();
  static final FirestoreDBHelper firestoreDBHelper = FirestoreDBHelper._();

  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> insert({required Map<String,dynamic> data}) async {

    DocumentSnapshot<Map<String,dynamic>> documentSnapshot = await db.collection("counter").doc("note_counter").get();


    int  count = documentSnapshot.data()!['count'];
    int  id = documentSnapshot.data()!['id'];


    await db.collection("notes").doc("${++id}").set(data);


    await db.collection("counter").doc("note_counter").update({"id": id});
    await db.collection("counter").doc("note_counter").update({"count": ++count});


  }
  Future<void> delete({required String id}) async {
    await db.collection("notes").doc(id).delete();


    DocumentSnapshot<Map<String,dynamic>> documentSnapshot = await db.collection("counter").doc("note_counter").get();

    int count = documentSnapshot.data()!['count'];

    await db.collection("counter").doc("note_counter").update({"count": --count});
  }


  Future<void> update({required String id,required Map<String,dynamic> data}) async {
    await db.collection("notes").doc("id").update(data);
  }
}