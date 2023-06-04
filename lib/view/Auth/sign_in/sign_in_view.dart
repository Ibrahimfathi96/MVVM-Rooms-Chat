import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rooms_chat/base/base.dart';
import 'package:rooms_chat/core/functions/validation_utils.dart';
import 'package:rooms_chat/generated/assets.dart';
import 'package:rooms_chat/view/Auth/sign_in/sign_in_navigator.dart';
import 'package:rooms_chat/view/Auth/sign_in/sign_in_viewmodel.dart';
import 'package:rooms_chat/view/Auth/sign_up/sign_up_view.dart';

class SignInView extends StatefulWidget {
  static const String routeName = 'sign-in';

  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends BaseState<SignInView,SignInViewModel> implements SignInNavigator {
  @override
  SignInViewModel initViewModel() {
   return SignInViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              Assets.imagesSignUp,
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
              "Login",
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
                  const Text(
                    "Welcome Back!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
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
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      "Forget Password ?",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
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
                      viewModel.signIn();
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sign-In",
                          style: TextStyle(
                            fontSize: 18,
                          ),
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
                  GestureDetector(
                    onTap: () {
                      viewModel.emailController.clear();
                      viewModel.passwordController.clear();
                      Navigator.of(context).pushNamed(SignUpView.routeName);
                    },
                    child: const Text(
                      "Or Create My Account ?",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                      ),
                    ),
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
