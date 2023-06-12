import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rooms_chat/data/my_provider.dart';
import 'package:rooms_chat/firebase_options.dart';
import 'package:rooms_chat/view/Auth/sign_in/sign_in_view.dart';
import 'package:rooms_chat/view/Auth/sign_up/sign_up_view.dart';
import 'package:rooms_chat/view/chat_starting_page/chat_starting_view.dart';
import 'package:rooms_chat/view/chat_thread/chat_thread_view.dart';
import 'package:rooms_chat/view/home/home_view.dart';

import 'view/add_room/add_room_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider<MyProvider>(
      create: (_) => MyProvider(),
      child: const RoomsChat(),
    ),
  );
}

class RoomsChat extends StatelessWidget {
  const RoomsChat({super.key});

  @override
  Widget build(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: provider.firebaseUser != null
          ? HomeView.routeName
          : SignInView.routeName,
      routes: {
        SignUpView.routeName: (_) => const SignUpView(),
        SignInView.routeName: (_) => const SignInView(),
        HomeView.routeName: (_) => const HomeView(),
        AddRoomView.routeName: (_) => const AddRoomView(),
        ChatStartingView.routeName: (_) => const ChatStartingView(),
        ChatThreadView.routeName: (_) => const ChatThreadView(),
      },
    );
  }
}
