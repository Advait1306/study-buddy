import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_buddy/models/post.dart';
import 'package:study_buddy/models/user_details.dart';

final users = FirebaseFirestore.instance.collection('users');
final posts = FirebaseFirestore.instance.collection('posts');

Future<UserDetails?> getUserDetails() async {
  final userId = FirebaseAuth.instance.currentUser!.uid;
  print("getting data for $userId");
  return users.doc(userId).get().then((doc) {
    if (doc.data() == null) {
      print("No data found, returning null");
      return null;
    } else {
      print("user data: ${doc.data()}");
      return UserDetails.fromJson(doc.data()!);
    }
  }).catchError((e) {
    print("caught error");
    print(e);
    return null;
  });
}

Future<void> saveUserDetails(UserDetails userDetails) async {
  final userId = FirebaseAuth.instance.currentUser!.uid;
  await users
      .doc(userId)
      .set(userDetails.toJson())
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
}

Stream<QuerySnapshot> getPostStream() {
  return posts.snapshots();
}

Future<void> addPost(Post post) async {
  await posts.add(post.toJson());
}

String? getUserId(){
  return FirebaseAuth.instance.currentUser?.uid;
}