import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rooms_chat/generated/assets.dart';
import 'package:rooms_chat/view/add_room/add_room_view.dart';
import 'package:rooms_chat/view/home/home_navigator.dart';
import 'package:rooms_chat/view/home/home_viewmodel.dart';

import '../../base/base.dart';

class HomeView extends StatefulWidget {
  static const String routeName = 'home';

  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends BaseState<HomeView, HomeViewModel>
    implements HomeNavigator {
  @override
  HomeViewModel initViewModel() {
    return HomeViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => viewModel,
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
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: const Text("Rooms Chat"),
          ),
          body: Container(),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              Navigator.pushNamed(context, AddRoomView.routeName);
            },
            child: const Icon(Icons.add,size: 36,),
          ),
        ),
      ),
    );
  }
}
