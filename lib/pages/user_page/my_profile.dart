import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:expense_tracker_app_v1/components/my_button.dart';
import 'package:expense_tracker_app_v1/components/my_textfiled.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  //
  String? profilePic;
  //
  final TextEditingController firstNameC = TextEditingController();
  final TextEditingController lastNameC = TextEditingController();
  final TextEditingController emailC = TextEditingController();
  final TextEditingController phoneNumberC = TextEditingController();
  final TextEditingController ageC = TextEditingController();
  final TextEditingController genderC = TextEditingController();
  final TextEditingController totalAmountC = TextEditingController();
  //
  final formkey = GlobalKey<FormState>();
  //String? buttonText;
  String? downloadUrl;
  bool selection = false;

  //
  bool isSaving = false;
  bool isLoading = true;
  //

  //
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (FirebaseAuth.instance.currentUser!.displayName == null) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please Complete the profile first')));
      } else {
        FirebaseFirestore.instance
            .collection('userDataCollection')
            .doc(FirebaseAuth.instance.currentUser!.email)
            .get()
            .then((DocumentSnapshot<Map<String, dynamic>> snapshot) {
          firstNameC.text = snapshot['First Name'];
          // print("----------------User Name = $firstNameC");
          lastNameC.text = snapshot['Last Name'];
          emailC.text = snapshot['Email'];
          phoneNumberC.text = snapshot['Phone Number'];
          ageC.text = snapshot['Age'];
          genderC.text = snapshot['Gender'];
          totalAmountC.text = snapshot['Total Amount'];
          profilePic = snapshot['Profile Image'];
        });
      }
    });
    super.initState();
  }

  //

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 10,
        centerTitle: true,
        title: Text('My Profile'),
      ),

      //
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                        final XFile? pickImage = await ImagePicker().pickImage(
                          source: ImageSource.gallery,
                          imageQuality: 50,
                        );
                        if (pickImage != null) {
                          setState(() {
                            profilePic = pickImage.path;
                            selection = true;
                          });
                        }
                      },
                      child: Container(
                        child: profilePic == null
                            ? CircleAvatar(
                                radius: 70,
                                backgroundImage: NetworkImage(
                                    'https://static.tnn.in/photo/msid-91800643/91800643.jpg'),
                              )
                            : profilePic!.contains('http')
                                ? CircleAvatar(
                                    radius: 70,
                                    backgroundImage: NetworkImage(profilePic!),
                                  )
                                : CircleAvatar(
                                    radius: 70,
                                    backgroundImage:
                                        FileImage(File(profilePic!)),
                                  ),
                      ),
                    ),
                  ),

                  //
                  SizedBox(height: 10),

                  //
                  MyTextField(
                      controller: firstNameC,
                      hintText: 'First Name',
                      obscureText: false),
                  //
                  SizedBox(height: 10),

                  //
                  MyTextField(
                      controller: lastNameC,
                      hintText: 'Last Name',
                      obscureText: false),
                  //
                  SizedBox(height: 10),

                  //
                  MyTextField(
                      controller: emailC,
                      hintText: 'Email',
                      obscureText: false),
                  //
                  SizedBox(height: 10),

                  //
                  MyTextField(
                      controller: phoneNumberC,
                      hintText: 'Phone Number',
                      obscureText: false),
                  //
                  SizedBox(height: 10),

                  //
                  MyTextField(
                      controller: ageC, hintText: 'Age', obscureText: false),
                  //
                  SizedBox(height: 10),

                  //
                  MyTextField(
                      controller: genderC,
                      hintText: 'Gender',
                      obscureText: false),

                  //
                  SizedBox(height: 10),

                  //
                  MyTextField(
                      controller: totalAmountC,
                      hintText: 'Total Amount',
                      obscureText: false),

                  //
                  SizedBox(height: 15),

                  //
                  GestureDetector(
                    onTap: () {
                      if (formkey.currentState!.validate()) {
                        SystemChannels.textInput
                            .invokeMapMethod('TextInput.hide'); //hides keyboard
                        profilePic == null
                            ? ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Select Profile Picture')))
                            : firstNameC.text.isEmpty
                                ? saveInfo()
                                : updateInfo();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(25),
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Center(
                        child: Text(
                          firstNameC.text.isEmpty ? 'SAVE' : 'UPDATE',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  //

                  //
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //String? downloadUrl;
  Future<String?> uploadImage(File filepath, String? reference) async {
    try {
      final finalName =
          '${FirebaseAuth.instance.currentUser!.uid}${DateTime.now().second}';
      //above we craete dthe file name
      final Reference fbStrorage =
          FirebaseStorage.instance.ref(reference).child(finalName);
      //above we are crefeting a reference to teh Cloud Storage of the Firebase ka new pacakage
      final UploadTask uploadTask = fbStrorage.putFile(filepath);
      await uploadTask.whenComplete(() async {
        downloadUrl = await fbStrorage.getDownloadURL();
      });
      print(downloadUrl);
      //
      return downloadUrl;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //
  updateInfo() {
    setState(() {
      isSaving = true;
    });

    if (selection = true) {
      uploadImage(File(profilePic!), 'profile').whenComplete(() {
        Map<String, dynamic> data = {
          'First Name': firstNameC.text,
          'Last Name': lastNameC.text,
          'Email': emailC.text,
          'Phone Number': phoneNumberC.text,
          'Age': ageC.text,
          'Gender': genderC.text,
          'Total Amount': totalAmountC.text,
          //'Profile Image': profilePic,
          'Profile Image': downloadUrl,
        };
        FirebaseFirestore.instance
            .collection('userDataCollection')
            .doc(FirebaseAuth.instance.currentUser!.email)
            .update(data)
            .whenComplete(() {
          FirebaseAuth.instance.currentUser!.updateDisplayName(firstNameC.text);
          setState(() {
            isSaving = false;
          });
        });
      });
    } else {
      Map<String, dynamic> data = {
        'First Name': firstNameC.text,
        'Last Name': lastNameC.text,
        'Email': emailC.text,
        'Phone Number': phoneNumberC.text,
        'Age': ageC.text,
        'Gender': genderC.text,
        'Total Amount': totalAmountC.text,
        //'Profile Image': profilePic,
        'Profile Image': profilePic,
      };
      FirebaseFirestore.instance
          .collection('userDataCollection')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .update(data)
          .whenComplete(() {
        FirebaseAuth.instance.currentUser!.updateDisplayName(firstNameC.text);
        setState(() {
          isSaving = false;
        });
      });
    }
  }

  //

  saveInfo() {
    setState(() {
      isSaving = true;
    });
    uploadImage(File(profilePic!), 'profile').whenComplete(() {
      Map<String, dynamic> data = {
        'First Name': firstNameC.text,
        'Last Name': lastNameC.text,
        'Email': emailC.text,
        'Phone Number': phoneNumberC.text,
        'Age': ageC.text,
        'Gender': genderC.text,
        'Total Amount': totalAmountC.text,
        //'Profile Image': profilePic,
        'Profile Image': downloadUrl,
      };
      FirebaseFirestore.instance
          .collection('userDataCollection')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .set(data)
          .whenComplete(() {
        FirebaseAuth.instance.currentUser!.updateDisplayName(firstNameC.text);
        setState(() {
          isSaving = false;
        });
      });
    });
  }
}
