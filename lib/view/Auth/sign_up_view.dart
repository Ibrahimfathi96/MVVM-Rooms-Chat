import 'package:flutter/material.dart';
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
            child: ListView(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                ),
                TextFormField(
                  validator: (text){
                    if(text == null||text.trim().isEmpty){
                      return "Please Enter Your Full Name";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: "Full Name",
                  ),
                ),
                TextFormField(
                  validator: (text){
                    if(text == null||text.trim().isEmpty){
                      return "Please Enter Your User Name";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: "User Name",
                  ),
                ),
                TextFormField(
                  validator: (email){
                    if(email == null||email.trim().isEmpty){
                      return "Please Enter Your E-mail Address";
                    }
                    if(!ValidationUtils.isValidEmail(email)){
                      return "Please Enter Valid E-mail Address";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: "E-mail Address",
                  ),
                ),
                TextFormField(
                  validator: (text){
                    if(text == null||text.trim().isEmpty){
                      return "Please Enter Your Password";
                    }
                    if(text.length < 6){
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  void createAccount() {
    if (!formKey.currentState!.validate()) {
      return;
    }
  }
}
