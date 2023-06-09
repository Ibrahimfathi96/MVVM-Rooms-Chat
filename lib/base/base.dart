import 'package:flutter/material.dart';
import 'package:rooms_chat/core/functions/dialog_utils.dart';

//interface class
abstract class BaseNavigator {
  void showLoadingDialog({String message = 'Loading....'});

  void hideLoadingDialog();

  void showMessageDialog(String message,
      {String? posActionName,
      String? negActionName,
      VoidCallback? posAction,
      VoidCallback? negAction,
      bool? isCancelable = true});
}

class BaseViewModel<Nav extends BaseNavigator> extends ChangeNotifier {
  Nav? navigator;
}

abstract class BaseState<T extends StatefulWidget, VM extends BaseViewModel>
    extends State<T> implements BaseNavigator {
  late VM viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = initViewModel();
    viewModel.navigator = this;
  }

  VM initViewModel();

  @override
  void hideLoadingDialog() {
    MyDialogUtils.hideLoading(context);
  }

  @override
  void showLoadingDialog({String message = 'Loading....'}) {
    MyDialogUtils.showLoading(context, message);
  }

  @override
  void showMessageDialog(String message,
      {String? posActionName,
      String? negActionName,
      VoidCallback? posAction,
      VoidCallback? negAction,
      bool? isCancelable = true}) {
    MyDialogUtils.showMessage(context, message,
        posAction: posAction,
        posActionName: posActionName,
        negAction: negAction,
        negActionName: negActionName,
        isCancelable: isCancelable);
  }
}
