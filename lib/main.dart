import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rooms_chat/firebase_options.dart';
import 'package:rooms_chat/view/Auth/sign_in/sign_in_view.dart';
import 'package:rooms_chat/view/Auth/sign_up/sign_up_view.dart';
import 'package:rooms_chat/view/home/home_view.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const RoomsChat());
}

class RoomsChat extends StatelessWidget {
  const RoomsChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SignInView.routeName,
      routes: {
         SignUpView.routeName : (_)=>const SignUpView(),
         SignInView.routeName : (_)=>const SignInView(),
         HomeView.routeName   : (_)=>const HomeView(),
      },
    );
  }
}

