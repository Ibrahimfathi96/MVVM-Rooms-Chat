import 'package:flutter/material.dart';
import 'package:rooms_chat/data/model/room_model.dart';
import 'package:rooms_chat/view/chat_starting_page/chat_starting_view.dart';

class CustomRoomWidget extends StatelessWidget {
  final RoomMD roomMD;

  const CustomRoomWidget({super.key, required this.roomMD});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushReplacementNamed(context, ChatStartingView.routeName,arguments: roomMD);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
        ),
        elevation: 14,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/images/${roomMD.categoryID}.png',
              width: 120,
              height: 120,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                roomMD.title,
                overflow: TextOverflow.fade,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,fontWeight: FontWeight.w500
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
