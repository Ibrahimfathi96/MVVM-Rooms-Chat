import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rooms_chat/data/model/my_user.dart';

class MyDatabase {
  static CollectionReference<MyUser> getUserCollection(){
    return FirebaseFirestore.instance.collection(
        MyUser.collectionName)
        .withConverter(
      fromFirestore:(doc, _) => MyUser.fromFireStore(doc.data()!) ,
      toFirestore:(user, options) => user.toFireStore() ,
    );
  }
  static Future<MyUser?> insertUserToDB(MyUser myUser)async {
    var collection = getUserCollection();
    var documentRef = collection.doc(myUser.id);
    var res = await documentRef.set(myUser);
    return  myUser;
  }

  static Future<MyUser?> getUserById(String userId)async{
    var collection  = getUserCollection();
    var documentRef = collection.doc(userId);
    var result      = await documentRef.get();
    return result.data();
  }

}