import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rooms_chat/base/base.dart';
import 'package:rooms_chat/data/database/my_database.dart';
import 'package:rooms_chat/data/model/my_user.dart';
import 'package:rooms_chat/view/Auth/sign_in/sign_in_navigator.dart';

class SignInViewModel extends BaseViewModel<SignInNavigator> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FirebaseAuth authServices = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscurePassword = true;

  validateUserInputAndSignIn() {
    if (!formKey.currentState!.validate()) {
      return;
    }else{
      signIn();
    }
  }

  signIn() async {
    try {
      navigator?.showLoadingDialog();
      var credential = await authServices.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      MyUser? retrievedUser =
          await MyDatabase.getUserById(credential.user?.uid ?? '');
      if (retrievedUser != null) {
        navigator?.hideLoadingDialog();
        navigator!.goToHome(retrievedUser);
      }
      return;
    } on FirebaseAuthException catch (e) {
      navigator?.hideLoadingDialog();
      if (e.code == 'user-not-found') {
        navigator?.showMessageDialog("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        navigator?.showMessageDialog("Wrong password provided for that user.");
      }
    } catch (e) {
      navigator?.showMessageDialog(
          "something went wrong, please try again later,\n${e.toString()}");
    }
  }
}
