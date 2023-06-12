import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rooms_chat/base/base.dart';
import 'package:rooms_chat/data/database/my_database.dart';
import 'package:rooms_chat/data/model/my_user.dart';
import 'package:rooms_chat/view/Auth/sign_up/sign_up_navigator.dart';

class SignUpViewModel extends BaseViewModel<SignUpNavigator> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FirebaseAuth authServices = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  bool obscurePassword = true;

  validateUserInputAndSignUp() {
    if (!formKey.currentState!.validate()) {
      return;
    }else{
      createAccount();
    }
  }

  createAccount() async {
    try {
      navigator?.showLoadingDialog();
      var credential = await authServices.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      MyUser newUser = MyUser(
        id: credential.user?.uid ?? "",
        fullName: fullNameController.text,
        email: emailController.text,
      );
      await MyDatabase.insertUserToDB(newUser).then((value){
        navigator?.hideLoadingDialog();
        navigator?.goToHome(newUser);
        return;
      });
    } on FirebaseAuthException catch (e) {
      navigator?.hideLoadingDialog();
      if (e.code == 'weak-password') {
        navigator?.showMessageDialog("The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        navigator
            ?.showMessageDialog("The account already exists for that email.");
      }
    } catch (e) {
      navigator?.hideLoadingDialog();
      navigator?.showMessageDialog(
          "something went wrong, please try again later,\n${e.toString()}");
    }
  }
}
