import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folder/helper/show_snack_bar.dart';
import 'package:folder/pages/chat_page.dart';
import 'package:folder/pages/cubits/register_cubit.dart';
import 'package:folder/pages/cubits/register_state.dart';
import 'package:folder/widget/constant.dart';
import 'package:folder/widget/custom_button.dart';
import 'package:folder/widget/custom_text_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatelessWidget {
  String? email;
  static String id = 'RegisterPage';

  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          isLoading = false;
          Navigator.pushNamed(context, ChatPage.id, arguments: email);
        } else if (state is RegisterFailure) {
          isLoading = false;
          showSnachBar(context, state.errorMessage);
        }
      },
      builder: (context, state) => ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  SizedBox(height: 75),
                  Image.asset(kLogo, height: 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'ScolarChat',
                        style: TextStyle(
                          fontSize: 32,
                          fontFamily: 'Pacifico',
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 75),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Register',
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  CustomTextFormField(
                    onChanged: (data) {
                      email = data;
                    },
                    hintText: 'Email',
                  ),
                  SizedBox(height: 10),
                  CustomTextFormField(
                    onChanged: (data) {
                      password = data;
                    },
                    hintText: 'Password',
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<RegisterCubit>(
                          context,
                        ).registerUser(email: email!, password: password!);
                      } else {}
                    },
                    title: 'Register',
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
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

  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
