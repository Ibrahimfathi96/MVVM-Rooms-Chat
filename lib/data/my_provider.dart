import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:rooms_chat/data/database/my_database.dart';
import 'package:rooms_chat/data/model/my_user.dart';

class MyProvider extends ChangeNotifier {
  MyUser? user;
  User? firebaseUser;

  MyProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    if(firebaseUser != null){
      initMyUser();
    }
  }

  void initMyUser() async {
    user = await MyDatabase.getUserById(firebaseUser?.uid ?? '');
  }
}
