import 'package:rooms_chat/base/base.dart';
import 'package:rooms_chat/data/model/my_user.dart';

abstract class SignUpNavigator extends BaseNavigator{
  goToHome(MyUser myUser);
}