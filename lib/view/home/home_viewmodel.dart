import 'package:rooms_chat/base/base.dart';
import 'package:rooms_chat/data/database/my_database.dart';
import 'package:rooms_chat/data/model/room_model.dart';
import 'package:rooms_chat/view/home/home_navigator.dart';

class HomeViewModel extends BaseViewModel<HomeNavigator>{
  Stream<List<RoomMD>>? getRoomsFromDB(){
    return MyDatabase.loadRoomsFromDB();
  }
}