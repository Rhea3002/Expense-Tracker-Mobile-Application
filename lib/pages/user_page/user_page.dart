import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:expense_tracker_app_v1/pages/user_page/user_page_body.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPage();
}

class _UserPage extends State<UserPage> {
  //
  //storing current User
  final user = FirebaseAuth.instance.currentUser!;
  //signUserOut()--------------------------------STARTS------------------
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }
  //signUserOut()--------------------------------ENDS------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      appBar: AppBar(
        automaticallyImplyLeading: false, // to remove the default left icon
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        centerTitle: true,
        elevation: 15,
        title: Text(
          'User Page',
          textAlign: TextAlign.center,
        ),

        //
        /* actions: [
            IconButton(
              onPressed: signUserOut,
              icon: Icon(Icons.logout_outlined),
            )

            //
          ] */
      ),

      //

      //BODY
      body: UserPageBody(),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
    );
  }
}
