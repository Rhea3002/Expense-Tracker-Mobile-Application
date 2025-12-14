import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage2 extends StatelessWidget {
  // const IntroPage2({super.key});

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
                    'https://assets6.lottiefiles.com/packages/lf20_yfsxyqxp.json'),

                //
                //Slogan
                Text(
                  'Towards a better financial future',
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
