import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rooms_chat/base/base.dart';
import 'package:rooms_chat/core/functions/validation_utils.dart';
import 'package:rooms_chat/data/model/my_user.dart';
import 'package:rooms_chat/data/my_provider.dart';
import 'package:rooms_chat/generated/assets.dart';
import 'package:rooms_chat/view/Auth/sign_up/sign_up_navigator.dart';
import 'package:rooms_chat/view/Auth/sign_up/sign_up_viewmodel.dart';
import 'package:rooms_chat/view/home/home_view.dart';

class SignUpView extends StatefulWidget {
  static const String routeName = 'sign-up';

  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends BaseState<SignUpView, SignUpViewModel>
    implements SignUpNavigator {

  @override
  SignUpViewModel initViewModel() {
    return SignUpViewModel();
  }
  @override
  goToHome(MyUser myUser) {
    MyProvider provider = Provider.of<MyProvider>(context,listen: false);
    Navigator.pushReplacementNamed(context, HomeView.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
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
            centerTitle: true,
            title: const Text(
              "Create Account",
            ),
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Form(
              key: viewModel.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.25,
                  ),
                  TextFormField(
                    controller: viewModel.fullNameController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return "Please Enter Your Full Name";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: "Full Name",
                    ),
                  ),
                  TextFormField(
                    controller: viewModel.emailController,
                    validator: (email) {
                      if (email == null || email.trim().isEmpty) {
                        return "Please Enter Your E-mail Address";
                      }
                      if (!ValidationUtils.isValidEmail(email)) {
                        return "Please Enter Valid E-mail Address";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: "E-mail Address",
                    ),
                  ),
                  TextFormField(
                    controller: viewModel.passwordController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return "Please Enter Your Password";
                      }
                      if (text.length < 6) {
                        return "Password Should be at least 6 characters";
                      }
                      return null;
                    },
                    obscureText: viewModel.obscurePassword,
                    decoration: InputDecoration(
                      labelText: "Password",
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            viewModel.obscurePassword = !viewModel.obscurePassword;
                          });
                        },
                        icon: Icon(
                          viewModel.obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.blue,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 40,
                      ),
                      elevation: 6,
                    ),
                    onPressed: () {
                      viewModel.validateUserInputAndSignUp();
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Create Account",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Icon(
                          Icons.arrow_forward,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?  ",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                      GestureDetector(
                        onTap: () {
                          viewModel.emailController.clear();
                          viewModel.fullNameController.clear();
                          viewModel.passwordController.clear();
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
