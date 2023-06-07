import 'package:flutter/material.dart';
import 'package:rooms_chat/base/base.dart';
import 'package:rooms_chat/data/model/room_model.dart';
import 'package:rooms_chat/generated/assets.dart';
import 'package:rooms_chat/view/chat_starting_page/chat_starting_navigator.dart';
import 'package:rooms_chat/view/chat_starting_page/chat_starting_viewmodel.dart';
import 'package:rooms_chat/view/chat_thread/chat_thread_view.dart';

class ChatStartingView extends StatefulWidget {
  static const String routeName = 'chat-starting';

  const ChatStartingView({super.key});

  @override
  State<ChatStartingView> createState() => _ChatStartingViewState();
}

class _ChatStartingViewState
    extends BaseState<ChatStartingView, ChatStartingViewModel>
    implements ChatStartingNavigator {
  @override
  ChatStartingViewModel initViewModel() {
    return ChatStartingViewModel();
  }

  @override
  Widget build(BuildContext context) {
    viewModel.roomMD = ModalRoute.of(context)?.settings.arguments as RoomMD;
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            Assets.imagesBgPattern,
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset:false ,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
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
          height: MediaQuery.of(context).size.height * 0.8,
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 22),
            color: Colors.white,
            elevation: 16,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    "Hello, Welcome to our chat room",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "Join ${viewModel.roomMD.title} !",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Image.asset(
                    "assets/images/${viewModel.roomMD.categoryID}.png",
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      children: [
                        Text(
                          viewModel.roomMD.description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 50,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 90, vertical: 15),
                    child: ElevatedButton(
                      child: const Text(
                        "Join",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          ChatThreadView.routeName,
                          arguments: viewModel.roomMD,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
