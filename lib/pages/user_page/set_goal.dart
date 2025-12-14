import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_app_v1/components/my_button.dart';
//import 'package:login_and_signup/user_page/my_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class SetGoal extends StatefulWidget {
  const SetGoal({super.key, required this.title});

  final String title;

  @override
  State<SetGoal> createState() => _SetGoal();
}

class _SetGoal extends State<SetGoal> {
  final TextEditingController totalAmountC = TextEditingController();
  double grocerysl = 10;
  double entersl = 10;
  double billsl = 10;
  double transtsl = 10;
  double foodsl = 10;
  double medicalsl = 10;
  double shoppsl = 10;
  double miscsl = 10;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    double percentageValue = 40000;
    double sliderPercentageValue = percentageValue / 8;
    grocerysl = sliderPercentageValue;
    entersl = sliderPercentageValue;
    billsl = sliderPercentageValue;
    transtsl = sliderPercentageValue;
    foodsl = sliderPercentageValue;
    medicalsl = sliderPercentageValue;
    shoppsl = sliderPercentageValue;
    miscsl = sliderPercentageValue;
    _loadSlider();
  }

  void _loadSlider() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      grocerysl = prefs.getDouble('groceryvalue') ?? 5000;
      entersl = prefs.getDouble('entertvalue') ?? 5000;
      billsl = prefs.getDouble('billvalue') ?? 5000;
      transtsl = prefs.getDouble('transpvalue') ?? 5000;
      foodsl = prefs.getDouble('foodvalue') ?? 5000;
      medicalsl = prefs.getDouble('medicalvalue') ?? 5000;
      shoppsl = prefs.getDouble('shoppvalue') ?? 5000;
      miscsl = prefs.getDouble('miscsvalue') ?? 5000;
    });
  }

  Future<void> _onChanged(int index, double value) async {
    double totalValue = grocerysl +
        entersl +
        billsl +
        transtsl +
        foodsl +
        medicalsl +
        shoppsl +
        miscsl;
    double remainingValue = totalValue - 40000;
    int remainingSliders = 7;
    double remainingAverage = remainingValue / remainingSliders;

    setState(() {
      switch (index) {
        case 0:
          grocerysl = value >= 0 && value <= 40000 ? value : 0;
          prefs.setDouble('groceryvalue', value);
          break;
        case 1:
          entersl = value >= 0 && value <= 40000 ? value : 0;
          prefs.setDouble('entertvalue', value);
          break;
        case 2:
          billsl = value >= 0 && value <= 40000 ? value : 0;
          prefs.setDouble('billvalue', value);
          break;
        case 3:
          transtsl = value >= 0 && value <= 40000 ? value : 0;
          prefs.setDouble('transpvalue', value);
          break;
        case 4:
          foodsl = value >= 0 && value <= 40000 ? value : 0;
          prefs.setDouble('foodvalue', value);
          break;
        case 5:
          medicalsl = value >= 0 && value <= 40000 ? value : 0;
          prefs.setDouble('medicalvalue', value);
          break;
        case 6:
          shoppsl = value >= 0 && value <= 40000 ? value : 0;
          prefs.setDouble('shoppvalue', value);
          break;
        case 7:
          miscsl = value >= 0 && value <= 40000 ? value : 0;
          prefs.setDouble('miscsvalue', value);
          break;
      }

      if (index != 0) {
        grocerysl = grocerysl - remainingAverage;
      }
      if (index != 1) {
        entersl = entersl - remainingAverage;
      }
      if (index != 2) {
        billsl = billsl - remainingAverage;
      }
      if (index != 3) {
        transtsl = transtsl - remainingAverage;
      }
      if (index != 4) {
        foodsl = foodsl - remainingAverage;
      }
      if (index != 5) {
        medicalsl = medicalsl - remainingAverage;
      }
      if (index != 6) {
        shoppsl = shoppsl - remainingAverage;
      }
      if (index != 7) {
        miscsl = miscsl - remainingAverage;
      }
    });

    CollectionReference slidersRef =
        FirebaseFirestore.instance.collection('sliders');
    await slidersRef.doc('_sliderValues').set({
      'grocerysl': grocerysl,
      'entersl': entersl,
      'billsl': billsl,
      'transtsl': transtsl,
      'foodsl': foodsl,
      'medicalsl': medicalsl,
      'shoppsl': shoppsl,
      'miscsl': miscsl
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
          leading: GestureDetector(
            child: Icon(Icons.arrow_back_sharp),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          title: Text(widget.title),
          /* flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[Colors.black, Colors.blue])),
          ), */
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.wallet,
                color: Colors.amber,
              ),
              tooltip: 'Amount in Wallet',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Amount in Wallet: 40000')));
              },
            ),
          ],
        ),

        ///
        ///
        ///
        ///
        ///
        ///
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 20,
                  ),

                  //
                  //
                  //
                  //
                  //
                  //

                  // ---------------------Grocery
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              alignment: Alignment.topLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.local_grocery_store_rounded,
                                    color: Colors.amber,
                                    size: 22.0,
                                    semanticLabel: 'Grocery Goal',
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "Grocery",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black),
                                  ),
                                ],
                              )),
                          Text(
                            ("\u{20B9} ${grocerysl.round()}"),
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                        ]),
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 10.0,
                      trackShape: RoundedRectSliderTrackShape(),
                      activeTrackColor: Colors.black,
                      inactiveTrackColor: Color.fromARGB(255, 245, 242, 149),
                      thumbShape: RoundSliderThumbShape(
                        enabledThumbRadius: 14.0,
                        pressedElevation: 8.0,
                      ),
                      thumbColor: Colors.amber,
                      overlayColor: Colors.black,
                      overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 32.0),
                      tickMarkShape: RoundSliderTickMarkShape(),
                      activeTickMarkColor: Colors.pinkAccent,
                      inactiveTickMarkColor: Colors.white,
                      valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                      valueIndicatorColor: Colors.black,
                      valueIndicatorTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    child: Slider(
                      value: grocerysl,
                      min: 0,
                      max: 40000,
                      divisions: 40000,
                      label: grocerysl.round().toString(),
                      onChanged: (value) => _onChanged(0, value),
                    ),
                  ),

                  //
                  //
                  //
                  //
                  //
                  //
                  // ---------------------Entertainment
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              alignment: Alignment.topLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.theater_comedy_outlined,
                                    color: Colors.amber,
                                    size: 22.0,
                                    semanticLabel: 'Entertainment Goal',
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Entertainment",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black),
                                  ),
                                ],
                              )),
                          Text(
                            "\u{20B9} ${entersl.round()}",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                        ]),
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 10.0,
                      trackShape: RoundedRectSliderTrackShape(),
                      activeTrackColor: Colors.black,
                      inactiveTrackColor: Color.fromARGB(255, 245, 242, 149),
                      thumbShape: RoundSliderThumbShape(
                        enabledThumbRadius: 14.0,
                        pressedElevation: 8.0,
                      ),
                      thumbColor: Colors.amber,
                      overlayColor: Colors.black,
                      overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 32.0),
                      tickMarkShape: RoundSliderTickMarkShape(),
                      activeTickMarkColor: Colors.pinkAccent,
                      inactiveTickMarkColor: Colors.white,
                      valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                      valueIndicatorColor: Colors.black,
                      valueIndicatorTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    child: Slider(
                      value: entersl,
                      min: 0,
                      max: 40000,
                      divisions: 40000,
                      label: entersl.round().toString(),
                      onChanged: (value) => _onChanged(1, value),
                    ),
                  ),
                  //
                  //
                  //
                  //
                  //
                  //

                  // ---------------------Bills
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              alignment: Alignment.topLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.note_add,
                                    color: Colors.amber,
                                    size: 22.0,
                                    semanticLabel: 'Bills Goal',
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "Bills",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black),
                                  ),
                                ],
                              )),
                          Text(
                            "\u{20B9} ${billsl.round()}",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                        ]),
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 10.0,
                      trackShape: RoundedRectSliderTrackShape(),
                      activeTrackColor: Colors.black,
                      inactiveTrackColor: Color.fromARGB(255, 245, 242, 149),
                      thumbShape: RoundSliderThumbShape(
                        enabledThumbRadius: 14.0,
                        pressedElevation: 8.0,
                      ),
                      thumbColor: Colors.amber,
                      overlayColor: Colors.black,
                      overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 32.0),
                      tickMarkShape: RoundSliderTickMarkShape(),
                      activeTickMarkColor: Colors.pinkAccent,
                      inactiveTickMarkColor: Colors.white,
                      valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                      valueIndicatorColor: Colors.black,
                      valueIndicatorTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    child: Slider(
                      value: billsl,
                      min: 0,
                      max: 40000,
                      divisions: 40000,
                      label: billsl.round().toString(),
                      onChanged: (value) => _onChanged(2, value),
                    ),
                  ),

                  //
                  //
                  //
                  //
                  //
                  //

                  // ---------------------Transportation
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              alignment: Alignment.topLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.emoji_transportation,
                                    color: Colors.amber,
                                    size: 22.0,
                                    semanticLabel: 'Transportation Goal',
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "Transportation",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black),
                                  ),
                                ],
                              )),
                          Text(
                            "\u{20B9} ${transtsl.round()}",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                        ]),
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 10.0,
                      trackShape: RoundedRectSliderTrackShape(),
                      activeTrackColor: Colors.black,
                      inactiveTrackColor: Color.fromARGB(255, 245, 242, 149),
                      thumbShape: RoundSliderThumbShape(
                        enabledThumbRadius: 14.0,
                        pressedElevation: 8.0,
                      ),
                      thumbColor: Colors.amber,
                      overlayColor: Colors.black,
                      overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 32.0),
                      tickMarkShape: RoundSliderTickMarkShape(),
                      activeTickMarkColor: Colors.pinkAccent,
                      inactiveTickMarkColor: Colors.white,
                      valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                      valueIndicatorColor: Colors.black,
                      valueIndicatorTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    child: Slider(
                      value: transtsl,
                      min: 0,
                      max: 40000,
                      divisions: 40000,
                      label: transtsl.round().toString(),
                      onChanged: (value) => _onChanged(3, value),
                    ),
                  ),

                  //
                  //
                  //
                  //
                  //
                  //

                  // ---------------------Food
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              alignment: Alignment.topLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.fastfood_outlined,
                                    color: Colors.amber,
                                    size: 22.0,
                                    semanticLabel: 'Food Goal',
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "Food",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black),
                                  ),
                                ],
                              )),
                          Text(
                            "\u{20B9} ${foodsl.round()}",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                        ]),
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 10.0,
                      trackShape: RoundedRectSliderTrackShape(),
                      activeTrackColor: Colors.black,
                      inactiveTrackColor: Color.fromARGB(255, 245, 242, 149),
                      thumbShape: RoundSliderThumbShape(
                        enabledThumbRadius: 14.0,
                        pressedElevation: 8.0,
                      ),
                      thumbColor: Colors.amber,
                      overlayColor: Colors.black,
                      overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 32.0),
                      tickMarkShape: RoundSliderTickMarkShape(),
                      activeTickMarkColor: Colors.pinkAccent,
                      inactiveTickMarkColor: Colors.white,
                      valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                      valueIndicatorColor: Colors.black,
                      valueIndicatorTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    child: Slider(
                      value: foodsl,
                      min: 0,
                      max: 40000,
                      divisions: 40000,
                      label: foodsl.round().toString(),
                      onChanged: (value) => _onChanged(4, value),
                    ),
                  ),
                  //
                  //
                  //
                  //
                  //
                  //

                  // ---------------------Medical
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              alignment: Alignment.topLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.medication,
                                    color: Colors.amber,
                                    size: 22.0,
                                    semanticLabel: 'Medical Goal',
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "Medical",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black),
                                  ),
                                ],
                              )),
                          Text(
                            "\u{20B9} ${medicalsl.round()}",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                        ]),
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 10.0,
                      trackShape: RoundedRectSliderTrackShape(),
                      activeTrackColor: Colors.black,
                      inactiveTrackColor: Color.fromARGB(255, 245, 242, 149),
                      thumbShape: RoundSliderThumbShape(
                        enabledThumbRadius: 14.0,
                        pressedElevation: 8.0,
                      ),
                      thumbColor: Colors.amber,
                      overlayColor: Colors.black,
                      overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 32.0),
                      tickMarkShape: RoundSliderTickMarkShape(),
                      activeTickMarkColor: Colors.pinkAccent,
                      inactiveTickMarkColor: Colors.white,
                      valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                      valueIndicatorColor: Colors.black,
                      valueIndicatorTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    child: Slider(
                      value: medicalsl,
                      min: 0,
                      max: 40000,
                      divisions: 40000,
                      label: medicalsl.round().toString(),
                      onChanged: (value) => _onChanged(5, value),
                    ),
                  ),
                  //
                  //
                  //
                  //
                  //
                  //

                  // ---------------------Shopping
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              alignment: Alignment.topLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.shopping_bag_rounded,
                                    color: Colors.amber,
                                    size: 22.0,
                                    semanticLabel: 'Shopping Goal',
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "Shopping",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black),
                                  ),
                                ],
                              )),
                          Text(
                            "\u{20B9} ${shoppsl.round()}",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                        ]),
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 10.0,
                      trackShape: RoundedRectSliderTrackShape(),
                      activeTrackColor: Colors.black,
                      inactiveTrackColor: Color.fromARGB(255, 245, 242, 149),
                      thumbShape: RoundSliderThumbShape(
                        enabledThumbRadius: 14.0,
                        pressedElevation: 8.0,
                      ),
                      thumbColor: Colors.amber,
                      overlayColor: Colors.black,
                      overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 32.0),
                      tickMarkShape: RoundSliderTickMarkShape(),
                      activeTickMarkColor: Colors.pinkAccent,
                      inactiveTickMarkColor: Colors.white,
                      valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                      valueIndicatorColor: Colors.black,
                      valueIndicatorTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    child: Slider(
                      value: shoppsl,
                      min: 0,
                      max: 40000,
                      divisions: 40000,
                      label: shoppsl.round().toString(),
                      onChanged: (value) => _onChanged(6, value),
                    ),
                  ),
                  //
                  //
                  //
                  //
                  //
                  //

                  // ---------------------Miscellaneous
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              alignment: Alignment.topLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.wallet,
                                    color: Colors.amber,
                                    size: 22.0,
                                    semanticLabel: 'Miscellaneous Goal',
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "Miscellaneous",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black),
                                  ),
                                ],
                              )),
                          Text(
                            "\u{20B9} ${miscsl.round()}",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                        ]),
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 10.0,
                      trackShape: RoundedRectSliderTrackShape(),
                      activeTrackColor: Colors.black,
                      inactiveTrackColor: Color.fromARGB(255, 245, 242, 149),
                      thumbShape: RoundSliderThumbShape(
                        enabledThumbRadius: 14.0,
                        pressedElevation: 8.0,
                      ),
                      thumbColor: Colors.amber,
                      overlayColor: Colors.black,
                      overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 32.0),
                      tickMarkShape: RoundSliderTickMarkShape(),
                      activeTickMarkColor: Colors.pinkAccent,
                      inactiveTickMarkColor: Colors.white,
                      valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                      valueIndicatorColor: Colors.black,
                      valueIndicatorTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    child: Slider(
                      value: miscsl,
                      min: 0,
                      max: 40000,
                      divisions: 40000,
                      label: miscsl.round().toString(),
                      onChanged: (value) => _onChanged(7, value),
                    ),
                  ),
                  //
                  //
                  //
                  //
                  //
                  //
                  MyButton(onTap: saveChanges, text: 'SAVE'),
                  SizedBox(height: 20),
                ]),
          )),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  saveChanges() async {
    if (await confirm(
      context,
      title: const Text('Confirm'),
      content: const Text('Are you sure you want to apply changes?'),
      textOK: const Text('Yes'),
      textCancel: const Text('Cancel'),
    )) {
      return print('pressedOK');
    }
    return print('pressedCancel');
  }
}
