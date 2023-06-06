import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rooms_chat/base/base.dart';
import 'package:rooms_chat/data/model/room_category_model.dart';
import 'package:rooms_chat/generated/assets.dart';
import 'package:rooms_chat/view/add_room/add_room_navigator.dart';
import 'package:rooms_chat/view/add_room/add_room_viewmodel.dart';
import 'package:rooms_chat/view/home/home_view.dart';

class AddRoomView extends StatefulWidget {
  static const String routeName = 'add-room';

  const AddRoomView({super.key});

  @override
  State<AddRoomView> createState() => _AddRoomViewState();
}

class _AddRoomViewState extends BaseState<AddRoomView, AddRoomViewModel>
    implements AddRoomNavigator {
  @override
  void goBack() {
    Navigator.pushReplacementNamed(context, HomeView.routeName);
  }
  @override
  AddRoomViewModel initViewModel() {
    return AddRoomViewModel();
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
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text("Add New Room"),
          ),
          body: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SizedBox(
              height: MediaQuery.of(context).size.height  * 0.7,
              child: Card(
                margin: const EdgeInsets.only(top: 80,right: 22,left: 22),
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: viewModel.formKey,
                    child: ListView(
                      children: [
                        const Text(
                          "Create New Room",
                          style:
                              TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        Image.asset(Assets.imagesAddRoom),
                        TextFormField(
                          controller: viewModel.titleController,
                          validator: (text){
                            if(text == null || text.trim().isEmpty){
                              return "Please Enter room title";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: "Room Name",
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownButton<RoomCategoryMD>(
                          isExpanded: true,
                          borderRadius: BorderRadius.circular(16),
                          underline: const SizedBox(),
                          itemHeight: 70,
                          alignment: Alignment.center,
                          value: viewModel.selectedRoom,
                          items: viewModel.allCategories
                              .map(
                                (category) => DropdownMenuItem<RoomCategoryMD>(
                                  value: category,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/${category.roomImage}',
                                        height: 48,
                                        width: 48,
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Text(
                                        category.roomName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (item) {
                            if (item == null) return;
                            viewModel.selectedRoom = item;
                            setState(() {});
                          },
                        ),
                        TextFormField(
                          minLines: 1,
                          maxLines: 4,
                          controller: viewModel.descriptionController,
                          validator: (text){
                            if(text == null || text.trim().isEmpty){
                              return "Please Enter room description";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: "Room Description",
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            elevation: 6,
                            padding: const EdgeInsets.all(14)
                          ),
                          onPressed: () {
                            viewModel.createRoom();
                          },
                          child: const Text(
                            "Create",
                            style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
