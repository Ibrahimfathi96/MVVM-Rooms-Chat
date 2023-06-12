class UserMessage {
  static const String collectionName = 'User Messages';
  String messageId;
  String content;
  String senderId;
  String senderName;
  int dateTime;
  String roomId;

  UserMessage(
      {this.messageId = '',
      required this.content,
      required this.senderId,
      required this.senderName,
      required this.dateTime,
      required this.roomId});

  UserMessage.fromFireStore(Map<String, dynamic> data)
      : this(
          messageId: data["messageId"],
          content: data["content"],
          senderId: data["senderId"],
          senderName: data["senderName"],
          dateTime: data["dateTime"],
          roomId: data["roomId"],
        );

  Map<String, dynamic> toFireStore() {
    return {
      "messageId": messageId,
      "content": content,
      "senderId": senderId,
      "senderName": senderName,
      "dateTime": dateTime,
      "roomId": roomId,
    };
  }
}
