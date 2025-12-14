import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:expense_tracker_app_v1/pages/user_page/my_profile.dart';
import 'package:expense_tracker_app_v1/pages/user_page/set_goal.dart';
import '../login_and_signup_page/forgot_password_page.dart';

class UserPageBody extends StatefulWidget {
  const UserPageBody({Key? key}) : super(key: key);

  @override
  State<UserPageBody> createState() => _UserPageBodyState();
}

class _UserPageBodyState extends State<UserPageBody> {
  //storing current User
  final user = FirebaseAuth.instance.currentUser!;

  //signUserOut()--------------------------------STARTS------------------
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30),

        Text(
          "Hi, " + user.email!,
          style: TextStyle(
            color: Color.fromARGB(255, 248, 161, 30),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),

        //
        SizedBox(height: 10),

        //Card 1 ---- Starts
        Card(
          color: Color.fromARGB(255, 220, 220, 220),
          elevation: 0,
          margin: const EdgeInsets.all(10),
          child: ListTile(
            leading: Icon(
              Icons.person,
              size: 30,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            title: Text(
              "My Profile",
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 0, 0),
                borderRadius: BorderRadius.circular(15),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return MyProfile();
                      },
                    ),
                  );
                },
                icon: Icon(
                  Icons.arrow_forward,
                  size: 25,
                  color: Colors.amber,
                ),
              ),
            ),
          ),
        ),

        //Card 1 --- Ends

        //Card 2 ---- Starts
        Card(
          color: Color.fromARGB(255, 220, 220, 220),
          elevation: 0,
          margin: const EdgeInsets.all(10),
          child: ListTile(
            leading: Icon(
              Icons.security,
              size: 30,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            title: Text(
              "Change Password",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 0, 0),
                borderRadius: BorderRadius.circular(15),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ForgotPasswordPage();
                      },
                    ),
                  );
                },
                icon: Icon(
                  Icons.arrow_forward,
                  color: Colors.amber,
                  size: 25,
                ),
              ),
            ),
          ),
        ),

        //Card 2 --- Ends

        //Card 3 ---- Starts
        Card(
          color: Color.fromARGB(255, 220, 220, 220),
          elevation: 0,
          margin: const EdgeInsets.all(10),
          child: ListTile(
            leading: Icon(
              Icons.flag,
              size: 30,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            title: Text(
              "Set Goal",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 0, 0),
                borderRadius: BorderRadius.circular(15),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SetGoal(title: 'Set Goal');
                      },
                    ),
                  );
                },
                icon: Icon(
                  Icons.arrow_forward,
                  color: Colors.amber,
                  size: 25,
                ),
              ),
            ),
          ),
        ),

        //Card 3 --- Ends

        //Card 4 ---- Starts
        Card(
          color: Color.fromARGB(255, 220, 220, 220),
          elevation: 0,
          margin: const EdgeInsets.all(10),
          child: ListTile(
            title: Text(
              "Logout",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 0, 0),
                borderRadius: BorderRadius.circular(15),
              ),
              child: IconButton(
                onPressed: signUserOut,
                icon: Icon(
                  Icons.logout,
                  color: Colors.red,
                  size: 25,
                ),
              ),
            ),
          ),
        ),

        //Card 4 --- Ends
      ],
    );
  }
}
