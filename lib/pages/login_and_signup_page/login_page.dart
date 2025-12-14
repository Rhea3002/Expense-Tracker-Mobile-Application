//importing package

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

//importing pages
import 'package:expense_tracker_app_v1/components/my_textfiled.dart';
import 'package:expense_tracker_app_v1/components/my_button.dart';
import 'package:expense_tracker_app_v1/components/square_tile.dart';
import 'forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //sign user in method-----------------------------------------------------------------------STARTS-------------------------
  void signUserIn() async {
    //show loading circle
    showDialog(
      context: this.context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    //try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      //

      //pop the loading circle
      Navigator.pop(this.context);

      //
    } on FirebaseAuthException catch (e) {
      //pop the loading circle
      Navigator.pop(this.context);
      //
      //show error message
      showErrorMessage(e.code);
    }
  }
  //sign user in method--------------------------------------------------------------------------ENDS-------------------------

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
  }

  /*
  //
  //wrong password message popup
  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Incorrect Password'),
        );
      },
    );
  }
  */

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[10],
      body: SafeArea(
        //we have used SafeArea - widget here because it avoids the area in the notch area
        child: Center(
          //used Center widget to align everything in center of the screen
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // it was here the error where I wrote const keyword after children --- which created so much errors
              children: [
                SizedBox(height: 5),

                //logo
                Icon(
                  Icons.monetization_on_rounded,
                  size: 100,
                ),

                //
                SizedBox(height: 40),

                //
                Text(
                  'Hello Again',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),

                //
                SizedBox(height: 20),

                //
                Text(
                  'Welcome back you\'ve been missed!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),

                SizedBox(height: 25),

                //

                //username textfield - email
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                //We have commented this thing is because we want to use this thing same foe user name and password
                //So, we created a seprate file whre ewe will be just accessing the components

                // Commented -- Below
                /*
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    decoration: InputDecoration(
                      // enabledBorder
          
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
          
                      // foucesdBorder
          
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
          
                      // filling colour
                      fillColor: Colors.yellow,
                      filled: true,
                    ),
                  ),
                ),
                */ // Commented -- Above

                //

                SizedBox(height: 10),

                //password textfiled
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                //

                SizedBox(height: 10),

                // forgot password

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ForgotPasswordPage();
                              },
                            ),
                          );
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //

                SizedBox(height: 25),

                //sig-in button
                MyButton(
                  text: "Sign In",
                  onTap: signUserIn,
                ),

                SizedBox(height: 25),

                //or continue with

                //

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                //

                SizedBox(height: 25),

                //google + apple sign in buttons

                //

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    //google button
                    SquareTile(imagePath: 'images/google_logo.png'),

                    SizedBox(width: 25),

                    //Apple Icon
                    SquareTile(imagePath: 'images/apple_logo.png'),
                  ],
                ),

                SizedBox(height: 10),

                //not a member -- Register Now

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Register Now',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),

                //
              ],
            ),
          ),
        ),
      ),
    );
  }
}
