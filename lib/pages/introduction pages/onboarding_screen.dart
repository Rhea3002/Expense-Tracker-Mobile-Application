import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:expense_tracker_app_v1/pages/login_and_signup_page/auth_page.dart';
import 'package:expense_tracker_app_v1/pages/introduction%20pages/intro%20pages/intro_page1.dart';
import 'package:expense_tracker_app_v1/pages/introduction%20pages/intro%20pages/intro_page2.dart';
import 'package:expense_tracker_app_v1/pages/introduction%20pages/intro%20pages/intro_page3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  //controller is basically used to keep the track on which page we are on
  PageController _controller = PageController();

  //let us keep a track of whether we are on the last page or not
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //page view
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),

          //dot indicator
          Container(
            alignment: Alignment(0, 0.9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //

                //skip - should take us to sigin page
                GestureDetector(
                  onTap: () {
                    _controller.jumpToPage(2);
                  },
                  child: Text(
                    "Skip",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),

                //dot indicator
                SmoothPageIndicator(controller: _controller, count: 3),

                //

                //next or done
                //we are also using the ternary operator to make the next to done when it reached to last page

                //
                onLastPage
                    ? GestureDetector(
                        onTap: () {
                          //from here we will go to the login page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return AuthPage();
                                //directing to authenticate Page
                              },
                            ),
                          );
                        },
                        child: Text(
                          "Done",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        },
                        child: Text(
                          "Next",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
