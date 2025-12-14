import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage3 extends StatelessWidget {
  // const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //
                //Welcome - Animation
                Lottie.network(
                    'https://assets7.lottiefiles.com/packages/lf20_htdr8jgg.json'),

                //
                //Slogan
                Text(
                  'Enjoy your App!',
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 19,
                  ),
                ),

                SizedBox(height: 100),

                //
              ],
            ),
          ),
        ),
      ),
    );
  }
}
