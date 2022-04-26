import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:study_buddy/helpers/database_helper.dart';
import 'package:study_buddy/models/post.dart';
import 'package:study_buddy/models/user_details.dart';
import 'package:study_buddy/widgets/highlighted_button.dart';

class PostDataCollector extends StatefulWidget {
  const PostDataCollector({Key? key}) : super(key: key);

  @override
  State<PostDataCollector> createState() => _PostDataCollectorState();
}

class _PostDataCollectorState extends State<PostDataCollector> {
  final _formKey = GlobalKey<FormState>();

  //Controllers
  final _titleController = TextEditingController();
  final _placeController = TextEditingController();
  final _teacherController = TextEditingController();
  final _daysController = TextEditingController();
  final _groupSizeController = TextEditingController();
  final _descriptionController = TextEditingController();

  Subject _subject = Subject.AI;
  Timing _timing = Timing.MORNING;

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
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                children: [
                  if(Platform.isAndroid) const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.only(right: 32.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 24.0),
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(
                                      CupertinoIcons.xmark_circle,
                                      color: Colors.white,
                                    )),
                                Text(
                                  "CREATE POST",
                                  style: GoogleFonts.bebasNeue(
                                      fontSize: 30, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          HighlightedButton(
                              icon: const Icon(CupertinoIcons.check_mark_circled),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  final user = await getUserDetails();
                                  final post = Post(
                                      phoneNumber: user!.phoneNumber,
                                      title: _titleController.text,
                                      place: _placeController.text,
                                      teacher: _teacherController.text,
                                      days: _daysController.text,
                                      groupSize:
                                          int.parse(_groupSizeController.text),
                                      description: _descriptionController.text,
                                      subject: _subject,
                                      timing: _timing,
                                      authorName: user.name,
                                      authorUid: getUserId()!);

                                  addPost(post)
                                      .then((value) => Navigator.pop(context));
                                }
                              })
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            style: _inputTextStyle,
                            decoration:
                                _inputDecorationStyle.copyWith(hintText: "title"),
                            controller: _titleController,
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
                                _inputDecorationStyle.copyWith(hintText: "place"),
                            controller: _placeController,
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
                                hintText: "description"),
                            controller: _descriptionController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter a value";
                              }
                              return null;
                            },
                          ),
                          DropdownButtonFormField(
                              style: _inputTextStyle,
                              decoration: _inputDecorationStyle.copyWith(
                                  hintText: "subject"),
                              items: Subject.values
                                  .map((subject) => DropdownMenuItem(
                                      value: subject,
                                      child: Text(
                                        subject.name,
                                        style: const TextStyle(
                                            backgroundColor: Color(0xFF1A1B17),
                                            color: Colors.white),
                                      )))
                                  .toList(),
                              onChanged: (Subject? value) {
                                if (value != null) {
                                  setState(() {
                                    _subject = value;
                                  });
                                }
                              }),
                          DropdownButtonFormField(
                              style: _inputTextStyle,
                              decoration: _inputDecorationStyle.copyWith(
                                  hintText: "timing"),
                              items: Timing.values
                                  .map((timing) => DropdownMenuItem(
                                      value: timing,
                                      child: Text(timing.name,
                                          style: const TextStyle(
                                              backgroundColor: Color(0xFF1A1B17),
                                              color: Colors.white))))
                                  .toList(),
                              onChanged: (Timing? value) {
                                if (value != null) {
                                  setState(() {
                                    _timing = value;
                                  });
                                }
                              }),
                          TextFormField(
                            style: _inputTextStyle,
                            decoration: _inputDecorationStyle.copyWith(
                                hintText: "teacher"),
                            controller: _teacherController,
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
                                _inputDecorationStyle.copyWith(hintText: "days"),
                            controller: _daysController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter a value";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            style: _inputTextStyle,
                            decoration: _inputDecorationStyle.copyWith(
                                hintText: "group size"),
                            controller: _groupSizeController,
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
                ],
              ),
            ),
          ),
        ));
  }
}
