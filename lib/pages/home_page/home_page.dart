//import 'dart:js_util';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/rendering.dart';
import 'package:expense_tracker_app_v1/pages/analytics_page/analytics_page.dart';
import 'package:expense_tracker_app_v1/pages/home_page/home_page_part2.dart';
import 'package:expense_tracker_app_v1/pages/insert_transactions/insert_transactions.dart';
import 'package:expense_tracker_app_v1/pages/insert_transactions/test.dart';
import 'package:expense_tracker_app_v1/pages/transaction_page/transactionHistory.dart';
import 'package:expense_tracker_app_v1/pages/user_page/user_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //storing current User
  final user = FirebaseAuth.instance.currentUser!;

  /*
  //signUserOut()--------------------------------STARTS------------------
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }
  //signUserOut()--------------------------------ENDS------------------
  */

  //
  int index = 0;
  final screens = [
    HomePagePart2(),
    AnalyticsPage(),
    MyHomePage(title: 'Add Transaction'),
    TransactionListPage(),
    UserPage(),
  ];

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      //

      /*
      //-----------------------AppBar----------------------------STARTS----------------------
      appBar: AppBar(
        title: Text(
          'Bottom Nav',
          style: TextStyle(color: Colors.yellow),
        ),
        backgroundColor: Colors.black,
      ),
      //-----------------------AppBar----------------------------ENDS----------------------
      */

      //

      //------------------------------Body------------------------START----------------
      body: screens[index],
      //------------------------------Body------------------------ENDS----------------

      //

      //---------------------------Botton Nav Bar-----------------START-------------

      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        backgroundColor: Colors.white,
        color: Colors.black,
        animationDuration: Duration(milliseconds: 300),
        items: <Widget>[
          Icon(
            Icons.home,
            color: Colors.white,
            size: 30,
          ),
          Icon(
            Icons.auto_graph_outlined,
            color: Colors.white,
            size: 30,
          ),
          Icon(
            Icons.add,
            color: Colors.amber,
            size: 30,
          ),
          Icon(
            Icons.history,
            color: Colors.white,
            size: 30,
          ),
          Icon(
            Icons.person,
            color: Colors.white,
            size: 30,
          ),
        ],
        index: index,

        //

        // ontap() ----- method

        onTap: (index) => setState(() => this.index = index),

        //
      ),

      //---------------------------Botton Nav Bar-----------------ENDS-------------
    );
  }
}
