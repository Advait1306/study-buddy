

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:study_buddy/helpers/database_helper.dart';
import 'package:study_buddy/models/user_details.dart';
import 'package:study_buddy/widgets/highlighted_button.dart';

class UserDataCollector extends StatelessWidget {
  UserDataCollector({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _classController = TextEditingController();
  final _bioController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  final _inputDecorationStyle = const InputDecoration(
    hintStyle: TextStyle(
      color: Colors.white,
    ),
  );

  final _inputTextStyle = const TextStyle(color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF1A1B17),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                if(Platform.isAndroid) const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Account info",
                          style: GoogleFonts.bebasNeue(
                              fontSize: 30, color: Colors.white),
                        ),
                        HighlightedButton(
                            icon: const Icon(CupertinoIcons.check_mark_circled),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                saveUserDetails(UserDetails(
                                        name:
                                            _nameController.text.toLowerCase(),
                                        division:
                                            _classController.text.toLowerCase(),
                                        bio: _bioController.text.toLowerCase(),
                                        subjects: [],
                                        phoneNumber:
                                            _phoneNumberController.text))
                                    .then((value) => Navigator.pop(context));
                              }
                            })
                      ]),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            style: _inputTextStyle,
                            decoration: _inputDecorationStyle.copyWith(
                                hintText: "Name"),
                            controller: _nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter a value";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            style: _inputTextStyle,
                            decoration: _inputDecorationStyle.copyWith(
                                hintText: "Class"),
                            controller: _classController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter a value";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            style: _inputTextStyle,
                            decoration:
                                _inputDecorationStyle.copyWith(hintText: "Bio"),
                            controller: _bioController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter a value";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            style: _inputTextStyle,
                            decoration: _inputDecorationStyle.copyWith(
                                hintText: "Phone number"),
                            controller: _phoneNumberController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter a value";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
