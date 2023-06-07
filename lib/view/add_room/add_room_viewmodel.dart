import 'package:flutter/cupertino.dart';
import 'package:rooms_chat/base/base.dart';
import 'package:rooms_chat/data/database/my_database.dart';
import 'package:rooms_chat/data/model/room_category_model.dart';
import 'package:rooms_chat/data/model/room_model.dart';
import 'package:rooms_chat/view/add_room/add_room_navigator.dart';

class AddRoomViewModel extends BaseViewModel<AddRoomNavigator> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<RoomCategoryMD> allCategories = RoomCategoryMD.getRoomCategory();
  late RoomCategoryMD selectedRoom = allCategories[0];

  validateUserInputsThenCreateRoom() {
    if (!formKey.currentState!.validate()) {
      return;
    }else{
      createRoom();
    }
  }

  createRoom() async {
    navigator?.showLoadingDialog(message: "Creating New Room...");
    try {
      var result = await MyDatabase.createRoomInFireStore(RoomMD(
          title: titleController.text,
          description: descriptionController.text,
          categoryID: selectedRoom.roomId));
      navigator?.hideLoadingDialog();
      navigator?.showMessageDialog(
        "Room Created Successfully.",
        posActionName: "Ok",
        posAction: () {
          navigator?.goBack();
        },
        isCancelable: false,
      );
    } catch (e) {
      navigator?.hideLoadingDialog();
      navigator?.showMessageDialog("Something Went Wrong ${e.toString()}");
    }
  }
}
