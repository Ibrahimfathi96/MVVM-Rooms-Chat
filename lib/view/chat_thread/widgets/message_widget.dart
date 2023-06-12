import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rooms_chat/core/functions/date_utils.dart';
import 'package:rooms_chat/data/model/user_message_model.dart';
import 'package:rooms_chat/data/my_provider.dart';

class SentMessage extends StatelessWidget {
  final int dateTime;
  final String content;

  const SentMessage({super.key, required this.dateTime, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
              bottomLeft: Radius.circular(24),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                content,
                style: const TextStyle(color: Colors.white,fontSize: 16),
              ),
              Text(
                formatMessageDate(
                  dateTime,
                ),
                textAlign: TextAlign.end,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ReceivedMessage extends StatelessWidget {
  final String senderName;
  final int dateTime;
  final String content;

  const ReceivedMessage(
      {super.key,
      required this.senderName,
      required this.dateTime,
      required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: Color(0xFFF8F8F8),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                senderName,
                style: const TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.w500,fontSize: 16),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                content,
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
              Text(
                formatMessageDate(dateTime),
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MessageWidget extends StatelessWidget {
  final UserMessage message;

  const MessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return provider.user!.id == message.senderId
        ? SentMessage(dateTime: message.dateTime, content: message.content)
        : ReceivedMessage(
            senderName: message.senderName,
            dateTime: message.dateTime,
            content: message.content,
          );
  }
}
