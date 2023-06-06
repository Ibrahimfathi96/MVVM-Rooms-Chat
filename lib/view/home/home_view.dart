import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rooms_chat/data/model/room_model.dart';
import 'package:rooms_chat/generated/assets.dart';
import 'package:rooms_chat/view/add_room/add_room_view.dart';
import 'package:rooms_chat/view/home/home_navigator.dart';
import 'package:rooms_chat/view/home/home_viewmodel.dart';
import 'package:rooms_chat/view/home/widgets/room_custom_widget.dart';

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
            leading: const SizedBox(),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: const Text(
              "Rooms Chat",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 36),
            child: Column(
              children: [
                Expanded(
                  child: StreamBuilder<List<RoomMD>>(
                    stream: viewModel.getRoomsFromDB(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return GridView.builder(
                          itemCount: snapshot.data!.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 6,
                            crossAxisSpacing: 6,
                          ),
                          itemBuilder: (_, index) {
                            return CustomRoomWidget(
                              roomMD: snapshot.data![index],
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, AddRoomView.routeName);
            },
            child: const Icon(
              Icons.add,
              size: 36,
            ),
          ),
        ),
      ),
    );
  }
}
