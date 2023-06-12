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
    return getRoomsCollection()
        .doc(roomId)
        .collection(UserMessage.collectionName)
        .withConverter<UserMessage>(
          fromFirestore: (snapshot, options) =>
              UserMessage.fromFireStore(snapshot.data()!),
          toFirestore: (message, options) => message.toFireStore(),
        );
  }

  static Future<void> insertUserToDB(MyUser myUser) async {
    return getUserCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> getUserById(String userId) async {
    var collection = getUserCollection();
    var documentRef = collection.doc(userId);
    var result = await documentRef.get();
    var myUser = result.data();
    return myUser;
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

  static Future<void> deleteDocumentAndCollection(RoomMD roomMD) async {
    var roomDoc = getRoomsCollection().doc(roomMD.id);
    var userMessagesCollection = getUserMessagesCollection(roomMD.id);

    // Delete the user messages collection
    var messages = await userMessagesCollection.get();
    for (var messageDoc in messages.docs) {
      await messageDoc.reference.delete();
    }

    // Delete the document
    await roomDoc.delete();
  }

  static Future<void> addMessageToFireStore(UserMessage message) {
    var messageDocument = getUserMessagesCollection(message.roomId).doc();
    message.messageId = messageDocument.id;
    return messageDocument.set(message);
  }

  static Stream<QuerySnapshot<UserMessage>> loadMessagesFromFireStore(
      String roomID) {
    return getUserMessagesCollection(roomID)
        .orderBy('dateTime',descending: true)
        .snapshots();
  }
}
