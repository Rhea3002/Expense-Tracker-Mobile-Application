//importing package

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//importing pages
import 'package:expense_tracker_app_v1/components/my_textfiled.dart';
import 'package:expense_tracker_app_v1/components/my_button.dart';
import 'package:expense_tracker_app_v1/components/square_tile.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //

  //text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final ageController = TextEditingController();
  final genderController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final amountController = TextEditingController();

  //

/*   @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    ageController.dispose();
    genderController.dispose();
    phoneNumberController.dispose();
    amountController.dispose();

    super.dispose();
  } */

  //sign user up method-----------------------------------------------------------------------STARTS-------------------------
  Future signUserUp() async {
    //show loading circle
    /*
    showDialog(
      context: this.context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    */

    //try creating the user
    try {
      //
      //checking if password and confoirm password are same
      if (passwordController.text.trim() ==
          confirmPasswordController.text.trim()) {
        //
        //create user - for authentication purposes
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        //add user details OR send it to the addUserdetaisl()
        addUserDetails(
          firstNameController.text.trim(),
          lastNameController.text.trim(),
          genderController.text.trim(),
          int.parse(ageController.text.trim()),
          int.parse(phoneNumberController.text.trim()),
          int.parse(amountController.text.trim()),
          emailController.text.trim(),
        );
      } //if ends
      //if not same
      else {
        //show error message - passwords do not match
        showErrorMessage("Passwords Do Not Match");
      }

      //pop the loading circle
      //Navigator.pop(this.context);

      //
    } //try - ends

    //

    on FirebaseAuthException catch (e) {
      //pop the loading circle
      Navigator.pop(this.context);
      //
      //show error message
      showErrorMessage(e.code);
    }
  }
  //sign user in method--------------------------------------------------------------------------ENDS-------------------------

  addUserDetails(String firstName, String lastName, String gender, int age,
      int phoneNumber, int totalAmount, String email) async {
    //
    print("AdduserDetails method -- is done -- Inside the Function");

    CollectionReference colref =
        FirebaseFirestore.instance.collection('userDataCollection');

    //create Map
    Map<String, dynamic> signup_map = {
      "Email": email,
      "First Name": firstName,
      "Last Name": lastName,
      "Age": age,
      "Gender": gender,
      "Phone Number": phoneNumber,
      "Total Amount": totalAmount,
    };

    colref
        .doc(email)
        .set(signup_map)
        .then((value) => print("User Added"))
        .catchError((error) => print("Falied to add user : $error"));

    //
    final CollectionReference colref2 = FirebaseFirestore.instance
        .collection('userDataCollection')
        .doc(email)
        .collection('Food');
    //Now here when we create a document in our "userDataCollection"
    //we now also create area's for our all 8 categories
    //basically we are creating below 8 Collections inside the current user

    //getting a reference to the document

    /* DocumentReference docRef =
        FirebaseFirestore.instance.collection('userDataCollection').doc(email);
    docRef.collection('Food'); */

    //Creating a collection/ 8 Categories inside the document/user

    /*CollectionReference colRefBills = docRef.collection('Bills');
     CollectionReference colRefEntertainment =
        docRef.collection('Entertainment');
    CollectionReference colRefFood = docRef.collection('Food');
    CollectionReference colRefGrocery = docRef.collection('Grocery');
    CollectionReference colRefMedical = docRef.collection('Medical');
    CollectionReference colRefOther = docRef.collection('Other');
    CollectionReference colRefShopping = docRef.collection('Shopping');
    CollectionReference colRefTransport = docRef.collection('Transport'); */

    //Old Code
    /* colref
        .add(signup_map)
        .then((value) => print("User Added"))
        .catchError((error) => print("Falied to add user : $error")); */

    //
  } //addUserDetails() --- ENDS

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
                const SizedBox(height: 25),

                //logo
                Icon(
                  Icons.security_sharp,
                  size: 50,
                ),

                SizedBox(height: 25),

                //

                Text(
                  'Let\'s create an account for you',
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

                //confirm password textfiled
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confrim Password',
                  obscureText: true,
                ),

                //

                SizedBox(height: 10),

                //First name textfiled
                MyTextField(
                  controller: firstNameController,
                  hintText: 'First Name',
                  obscureText: false,
                ),

                //

                SizedBox(height: 10),

                //Last name textfiled
                MyTextField(
                  controller: lastNameController,
                  hintText: 'Last Name',
                  obscureText: false,
                ),

                //

                SizedBox(height: 10),

                //Age textfiled
                MyTextField(
                  controller: ageController,
                  hintText: 'Age',
                  obscureText: false,
                ),

                //

                SizedBox(height: 10),

                //Gender textfiled
                MyTextField(
                  controller: genderController,
                  hintText: 'Gender',
                  obscureText: false,
                ),

                //

                SizedBox(height: 10),

                //Phone Number textfiled
                MyTextField(
                  controller: phoneNumberController,
                  hintText: 'Phone Number',
                  obscureText: false,
                ),

                //

                SizedBox(height: 10),

                //Toatl Amount textfiled
                MyTextField(
                  controller: amountController,
                  hintText: 'Total Amount',
                  obscureText: false,
                ),

                //

                SizedBox(height: 25),

                //sig-up button
                MyButton(
                  text: "Sign Up",
                  onTap: signUserUp, //this creates data in FireStore
                ),

                //SizedBox(height: 25),

                //or continue with

                //

                /*
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
                */

                //

                //SizedBox(height: 25),

                //google + apple sign in buttons

                //

                /*
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    //google button
                    SquareTile(
                        imagePath:
                            'lib/images/img_login&signup/google_logo.png'),

                    SizedBox(width: 25),

                    //Apple Icon
                    SquareTile(
                        imagePath:
                            'lib/images/img_login&signup/apple_logo.png'),
                  ],
                ),
                */

                SizedBox(height: 25),

                //already have an account -- login Now

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login Now',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 25),

                //
              ],
            ),
          ),
        ),
      ),
    );
  }
}
