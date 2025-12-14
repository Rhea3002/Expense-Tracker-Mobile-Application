import 'package:flutter/material.dart';

class InsertTransactionsPage extends StatefulWidget {
  const InsertTransactionsPage({Key? key}) : super(key: key);

  @override
  State<InsertTransactionsPage> createState() => _InsertTransactionsPage();
}

class _InsertTransactionsPage extends State<InsertTransactionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      appBar: AppBar(
        automaticallyImplyLeading: false, // to remove the default left icon
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'Insert Transaction Page',
          textAlign: TextAlign.center,
        ),
      ),

      //

      //BODY
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
