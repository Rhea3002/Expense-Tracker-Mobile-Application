import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/my_button.dart';
import '../../components/my_textfiled.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPage();
}

class _ForgotPasswordPage extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();

  //
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  //
  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      //so now we will use the showErrorMesagger() - to tell user that a password link has been sent to him
      showErrorMessage('Password Reset Link sent! Check your email');

      //
    } on FirebaseAuthException catch (e) {
      print(e); //in my system cnsole
      showErrorMessage(e.code);
    }
  } //passwordRest() --- ENDS

  //

  //error message to user
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.yellow,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        );
      },
    );
  } //showErrorMessage() --- ENDS

  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              'Enter you Email and we will send you a password reset link',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
          ),

          //
          SizedBox(height: 25),

          //username textfield - email
          MyTextField(
            controller: emailController,
            hintText: 'Email',
            obscureText: false,
          ),

          //
          SizedBox(height: 10),

          //sig-in button
          MyButton(
            text: "Reset Password",
            onTap: passwordReset,
          ),

          //
        ],
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
    );
  }
}
