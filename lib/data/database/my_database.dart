import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rooms_chat/data/model/my_user.dart';
import 'package:rooms_chat/data/model/room_model.dart';
import 'package:rooms_chat/data/model/user_message_model.dart';

class MyDatabase {
  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
          fromFirestore: (doc, _) => MyUser.fromFireStore(doc.data()!),
          toFirestore: (user, options) => user.toFireStore(),
        );
  }

  static CollectionReference<RoomMD> getRoomsCollection() {
    return FirebaseFirestore.instance
        .collection(RoomMD.collectionName)
        .withConverter<RoomMD>(
          fromFirestore: (doc, _) => RoomMD.fromFireStore(doc.data()!),
          toFirestore: (room, options) => room.toFireStore(),
        );
  }

  static CollectionReference<UserMessage> getUserMessagesCollection(
      String roomId) {
    return FirebaseFirestore.instance
        .collection(RoomMD.collectionName)
        .doc(roomId)
        .collection(UserMessage.collectionName)
        .withConverter<UserMessage>(
          fromFirestore: (snapshot, options) =>
              UserMessage.fromFireStore(snapshot.data()!),
          toFirestore: (message, options) => message.toFireStore(),
        );
  }

  static Future<MyUser?> insertUserToDB(MyUser myUser) async {
    var collection = getUserCollection();
    var documentRef = collection.doc(myUser.id);
    var res = await documentRef.set(myUser);
    return myUser;
  }

  static Future<MyUser?> getUserById(String userId) async {
    var collection = getUserCollection();
    var documentRef = collection.doc(userId);
    var result = await documentRef.get();
    return result.data();
  }

  static Future<void> createRoomInFireStore(RoomMD roomMD) {
    var documentRef = getRoomsCollection().doc();
    roomMD.id = documentRef.id;
    return documentRef.set(roomMD);
  }

  static Stream<List<RoomMD>> loadRoomsFromDB() {
    return getRoomsCollection().snapshots().map((querySnapshot) => querySnapshot
        .docs
        .map((queryDocSnapshot) => queryDocSnapshot.data())
        .toList());
  }

  static Future<void> insertMessageIntoFirebase(String  roomId,UserMessage message){
    var messageDocument = getUserMessagesCollection(roomId).doc();
    message.messageId = messageDocument.id;
    return messageDocument.set(message);
  }

  static Future<void> deleteRoom(RoomMD roomMD) {
    var roomDoc = getRoomsCollection().doc(roomMD.id);
    return roomDoc.delete();
  }
}
