import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rooms_chat/core/functions/dialog_utils.dart';
import 'package:rooms_chat/core/functions/validation_utils.dart';
import 'package:rooms_chat/generated/assets.dart';

class SignUpView extends StatefulWidget {
  static const String routeName = 'sign-up';

  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  bool obscurePassword = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
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
            "Create Account",
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                ),
                TextFormField(
                  controller: fullNameController,
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
                  controller: emailController,
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
                  controller: passwordController,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "Please Enter Your Password";
                    }
                    if (text.length < 6) {
                      return "Password Should be at least 6 characters";
                    }
                    return null;
                  },
                  obscureText: obscurePassword,
                  decoration: InputDecoration(
                    labelText: "Password",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                      icon: Icon(
                        obscurePassword
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
                    createAccount();
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                    GestureDetector(
                      onTap: () {
                        emailController.clear();
                        fullNameController.clear();
                        passwordController.clear();
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
    );
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  void createAccount() {
    if (!formKey.currentState!.validate()) {
      return;
    }
    showLoading(context, "Loading....");
    auth
        .createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    )
        .then((userCredential) {
      hideLoading(context);
      showMessage(context,
          (userCredential.user?.uid) ?? 'something went wrong with userId');
    }).onError((error, stackTrace) {
      hideLoading(context);
      showMessage(context, error.toString());
    });
  }
}
