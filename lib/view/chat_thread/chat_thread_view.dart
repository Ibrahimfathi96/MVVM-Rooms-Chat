import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rooms_chat/base/base.dart';
import 'package:rooms_chat/data/model/room_model.dart';
import 'package:rooms_chat/generated/assets.dart';
import 'package:rooms_chat/view/chat_thread/chat_thread_navigator.dart';
import 'package:rooms_chat/view/chat_thread/chat_thread_viewmodel.dart';
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
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pushReplacementNamed(context, HomeView.routeName);
              },
            ),
            actions: [
              IconButton(
                onPressed: () {},
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
            height: MediaQuery.of(context).size.height * 0.9,
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 22),
              color: Colors.white,
              elevation: 16,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        color: Colors.red,
                        child: const Text(
                          "TODAY",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: viewModel.messageController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey, width: 2),
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
                          onTap: (){
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
}
