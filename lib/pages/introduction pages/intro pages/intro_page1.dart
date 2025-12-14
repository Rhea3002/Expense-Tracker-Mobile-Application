import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage1 extends StatelessWidget {
  // const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //
                //wecome text
                Text(
                  'Welcome',
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),

                //
                //Welcome - Animation
                Lottie.network(
                    'https://assets3.lottiefiles.com/packages/lf20_puciaact.json'),

                //
                //To
                Text(
                  'To the',
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),

                //
                SizedBox(height: 10),

                //
                //App Name
                Text(
                  'Expense Tracker',
                  style: GoogleFonts.acme(
                    color: Colors.yellow,
                    fontSize: 35,
                  ),
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
