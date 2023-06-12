import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rooms_chat/base/base.dart';
import 'package:rooms_chat/data/database/my_database.dart';
import 'package:rooms_chat/data/model/room_model.dart';
import 'package:rooms_chat/data/model/user_message_model.dart';
import 'package:rooms_chat/data/my_provider.dart';
import 'package:rooms_chat/generated/assets.dart';
import 'package:rooms_chat/view/chat_thread/chat_thread_navigator.dart';
import 'package:rooms_chat/view/chat_thread/chat_thread_viewmodel.dart';
import 'package:rooms_chat/view/chat_thread/widgets/message_widget.dart';
import 'package:rooms_chat/view/home/home_view.dart';

class ChatThreadView extends StatefulWidget {
  static const String routeName = 'chat-thread';

  const ChatThreadView({super.key});

  @override
  State<ChatThreadView> createState() => _ChatThreadViewState();
}

class _ChatThreadViewState
    extends BaseState<ChatThreadView, ChatThreadViewModel>
    implements ChatThreadNavigator {
  @override
  ChatThreadViewModel initViewModel() {
    return ChatThreadViewModel();
  }

  @override
  Widget build(BuildContext context) {
    viewModel.roomMD = ModalRoute.of(context)?.settings.arguments as RoomMD;
    MyProvider provider = Provider.of<MyProvider>(context);
    viewModel.myUser = provider.user!;
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              Assets.imagesBgPattern,
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  showPopupMenu();
                },
                icon: const Icon(
                  Icons.more_vert_outlined,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ],
            elevation: 0,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text(
              viewModel.roomMD.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
          body: SizedBox(
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
              color: Colors.white,
              elevation: 16,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: StreamBuilder<QuerySnapshot<UserMessage>>(
                        stream: viewModel.getMessagesFromDB(),
                        builder: (context, asyncSnapShot) {
                          var messages = asyncSnapShot.data?.docs
                              .map((doc) => doc.data())
                              .toList();
                          if (asyncSnapShot.hasError) {
                            return const Center(
                              child: Text("Something went wrong."),
                            );
                          } else if (asyncSnapShot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (asyncSnapShot.hasData) {
                            return ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              reverse: true,
                              padding: const EdgeInsets.all(4),
                              separatorBuilder: (_, __) {
                                return const SizedBox(
                                  height: 8,
                                );
                              },
                              itemCount: messages?.length ?? 0,
                              itemBuilder: (context, index) {
                                return MessageWidget(message: messages![index]);
                              },
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: viewModel.messageController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(18),
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 6,
                              ),
                              hintText: "Type a message...",
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            viewModel.sendMessage();
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 8),
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 16,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Row(
                              children: [
                                Text(
                                  "Send",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Icon(
                                  Icons.send_outlined,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  showPopupMenu() {
    showMenu<String>(
      context: context,
      position: const RelativeRect.fromLTRB(25.0, 25.0, 0.0, 0.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      items: [
        PopupMenuItem<String>(
          value: '1',
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text(
                      'Delete Room',
                      textAlign: TextAlign.center,
                    ),
                    content: const Text(
                      'Are you sure you want to delete the room?',
                      textAlign: TextAlign.center,
                    ),
                    actions: [
                      TextButton(
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.red),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text(
                          'delete Room',
                          style: TextStyle(color: Colors.red),
                        ),
                        onPressed: () {
                          MyDatabase.deleteDocumentAndCollection(viewModel.roomMD);
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            HomeView.routeName,
                                (Route<dynamic> route) => false,
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: const Center(
              child: Text(
                'Delete Room',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        PopupMenuItem<String>(
          value: '2',
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text(
                      'Leave Room',
                      textAlign: TextAlign.center,
                    ),
                    content: const Text(
                      'Are you sure you want to leave the room?',
                      textAlign: TextAlign.center,
                    ),
                    actions: [
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Leave Room'),
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            HomeView.routeName,
                            (Route<dynamic> route) => false,
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: const Center(
              child: Text(
                'Leave Room',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
      elevation: 8.0,
    );
  }
}
