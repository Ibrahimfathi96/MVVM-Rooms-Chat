import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:rooms_chat/base/base.dart';
import 'package:rooms_chat/data/database/my_database.dart';
import 'package:rooms_chat/data/model/room_model.dart';
import 'package:rooms_chat/data/model/user_message_model.dart';
import 'package:rooms_chat/data/shared_data.dart';
import 'package:rooms_chat/view/chat_thread/chat_thread_navigator.dart';

class ChatThreadViewModel extends BaseViewModel<ChatThreadNavigator> {
  late RoomMD roomMD;
  TextEditingController messageController = TextEditingController();

  leaveRoom(){}
  Stream<QuerySnapshot<UserMessage>> getMessagesFromDB() {
    return MyDatabase.getUserMessagesCollection(roomMD.id!)
    //sorting messages by time
        .orderBy(
          'dateTime',descending: true
        )
        .snapshots();
  }

  void sendMessage() {
    if(messageController.text.trim().isEmpty) return;
    UserMessage userMessage = UserMessage(
      content: messageController.text,
      dateTime: DateTime.now().millisecondsSinceEpoch,
      senderId: SharedData.user?.id,
      senderName: SharedData.user?.fullName,
      roomId: roomMD.id,
    );
    MyDatabase.insertMessageIntoFirebase(roomMD.id!, userMessage).then((value) {
      messageController.clear();
    }).onError(
      (error, stackTrace) {
        navigator?.showMessageDialog(
          "Something went wrong, try again later.",
          posActionName: "try again",
          posAction: () {
            sendMessage();
          },
          negActionName: "Cancel",
        );
      },
    );
  }
}
