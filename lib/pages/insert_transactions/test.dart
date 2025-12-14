import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:date_field/date_field.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:expense_tracker_app_v1/pages/transaction_page/transactionHistory.dart';

// class MyApp extends StatelessWidget {
//   MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Finance Tracker',
//       debugShowCheckedModeBanner: false,
//       home: MyHomePage(title: "Add Transaction"),
//       theme: ThemeData(
//           primarySwatch: Colors.amber,
//           appBarTheme: AppBarTheme(
//             iconTheme: IconThemeData(color: Colors.white),
//             foregroundColor: Colors.white, //<-- SEE HERE
//           )),
//     );
//   }
// }

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Stepper counter
  int currentStep = 0;

  //form
  final _formKey = GlobalKey<FormState>();

  // Storing the type of transaction
  late String selectedRadio;
  @override
  void initState() {
    super.initState();
    selectedRadio = "Expense";
  }

  // Changes the selected value on 'onChanged' click on each radio button
  setSelectedRadio(String val) {
    setState(() {
      selectedRadio = val;
    });
  }

  //Storing the category of transaction
  String? selectedItem;
  final List<String> _item = [
    'Grocery',
    'Entertainment',
    'Bills',
    'Transportation',
    'Food',
    'Medical',
    'Shopping',
    'Miscellaneous',
  ];

  //Date and time selected
  DateTime? selectedDate;

  //amount
  int? amount;

  //note
  late String note;

  getNote(note) {
    this.note = note;
  }

  Future<void> _onsubmit() async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('transactions').doc();
    Map<String, dynamic> myForm = {
      'type': selectedRadio,
      'category': selectedItem,
      'amount': amount,
      'note': note,
      'date': selectedDate,
    };
    documentReference.set(myForm).whenComplete(() {
      if (kDebugMode) {
        print("$note added");
      }

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TransactionListPage()),
      );
    });
  }

  //Stepper
  List<Step> getSteps() => [
        Step(
          isActive: currentStep >= 0,
          title: Text('Step 1'),
          content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // RadioListTile(
                //   title: const Text('Income'),
                //   value: TypeOfTransact.Income,
                //   groupValue: _transactType,
                //   onChanged: (TypeOfTransact? value) {
                //     setState(() {
                //       _transactType = value;
                //     });
                //   },
                // ),
                // RadioListTile(
                //   title: const Text('Expense'),
                //   value: TypeOfTransact.Expense,
                //   groupValue: _transactType,
                //   onChanged: (TypeOfTransact? value) {
                //     setState(() {
                //       _transactType = value;
                //     });
                //   },
                // ),

                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Income"),
                    Radio(
                      value: "Income",
                      groupValue: selectedRadio,
                      activeColor: Colors.amber,
                      onChanged: (val) {
                        print("Radio $val");
                        setSelectedRadio(val!);
                      },
                    ),
                    Text("Expense"),
                    Radio(
                      value: "Expense",
                      groupValue: selectedRadio,
                      activeColor: Colors.amber,
                      onChanged: (val) {
                        print("Radio $val");
                        setSelectedRadio(val!);
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      width: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 2, color: Colors.black)),
                      child: DropdownButton<String>(
                        value: selectedItem,
                        onChanged: ((value) {
                          setState(() {
                            selectedItem = value!;
                          });
                        }),
                        items: _item
                            .map((e) => DropdownMenuItem(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 40,
                                          child: Image.asset('images/${e}.png'),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          e,
                                          style: TextStyle(fontSize: 18),
                                        )
                                      ],
                                    ),
                                  ),
                                  value: e,
                                ))
                            .toList(),
                        selectedItemBuilder: (BuildContext context) => _item
                            .map((e) => Row(
                                  children: [
                                    Container(
                                      width: 42,
                                      child: Image.asset('images/${e}.png'),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(e)
                                  ],
                                ))
                            .toList(),
                        hint: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text(
                            'Choose Category',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        dropdownColor: Colors.white,
                        isExpanded: true,
                        underline: Container(),
                      ),
                    )),
              ]),
        ),
        Step(
          isActive: currentStep >= 1,
          title: Text('Step 2'),
          content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Enter Amount'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the amount';
                    }
                  },
                  onChanged: (value) {
                    amount = int.tryParse(value);
                    print('$amount');
                  },
                ),
              ]),
        ),
        Step(
          isActive: currentStep >= 2,
          title: Text('Step 3'),
          content: DateTimeField(
              decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.black45),
                  errorStyle: TextStyle(color: Colors.redAccent),
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.event_note),
                  labelText: 'Choose date and time'),
              selectedDate: selectedDate,
              onDateSelected: (DateTime value1) {
                setState(() {
                  selectedDate = value1;
                });
              }),
        ),
        Step(
          isActive: currentStep >= 3,
          title: const Text('Complete'),
          content: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Note',
              prefixIcon: Align(
                widthFactor: 1.0,
                heightFactor: 1.0,
                child: Icon(
                  Icons.note_alt,
                ),
              ),
            ),
            onChanged: (String note) {
              getNote(note);
            },
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: GestureDetector(
            child: Icon(Icons.arrow_back),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          title: Text(widget.title),
          actions: [
            // Icon(Icons.check),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 14),
            // )
          ],
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: Container(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Stepper(
                              steps: getSteps(),
                              currentStep: currentStep,
                              onStepContinue: () {
                                if (currentStep >= 3) {
                                  currentStep = currentStep;
                                } else
                                  setState(() => currentStep++);
                              },
                              onStepCancel: () => setState(() {
                                if (currentStep == 0) {
                                  currentStep = currentStep;
                                } else
                                  currentStep--;
                              }),
                              onStepTapped: (int _currentStep) =>
                                  setState(() => currentStep = _currentStep),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.amber,
                                  minimumSize: const Size.fromHeight(50)),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _onsubmit();
                                  print('Type of transaction: $selectedRadio');
                                  print(
                                      'Category of transaction: $selectedItem');
                                  print('Amount: $amount');
                                  print('Date & Time: $selectedDate');
                                  print('Note: $note');
                                  _formKey.currentState!.reset();
                                  //resetFormFields();
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           TransactionHistory()),
                                  // );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Please enter all details')),
                                  );
                                }
                              },
                              child: const Text(
                                'ADD TRANSACTION',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ]),
                    )))));
  }
}
