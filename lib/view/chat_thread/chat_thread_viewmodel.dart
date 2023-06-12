import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:rooms_chat/base/base.dart';
import 'package:rooms_chat/data/database/my_database.dart';
import 'package:rooms_chat/data/model/my_user.dart';
import 'package:rooms_chat/data/model/room_model.dart';
import 'package:rooms_chat/data/model/user_message_model.dart';
import 'package:rooms_chat/view/chat_thread/chat_thread_navigator.dart';

class ChatThreadViewModel extends BaseViewModel<ChatThreadNavigator> {
  late RoomMD roomMD;
  late MyUser myUser;
  TextEditingController messageController = TextEditingController();

  Stream<QuerySnapshot<UserMessage>> getMessagesFromDB() {
    return MyDatabase.loadMessagesFromFireStore(roomMD.id);
  }

  void sendMessage() {
    if(messageController.text.trim().isEmpty) return;
    UserMessage userMessage = UserMessage(
      content: messageController.text,
      dateTime: DateTime.now().millisecondsSinceEpoch,
      senderId: myUser.id,
      senderName: myUser.fullName,
      roomId: roomMD.id,
    );
    MyDatabase.addMessageToFireStore(userMessage).then((value) {
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
