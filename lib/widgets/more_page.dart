import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:study_buddy/widgets/highlighted_button.dart';
import 'package:url_launcher/url_launcher.dart';

class MorePage extends StatelessWidget {
  MorePage({Key? key}) : super(key: key);
  final quizFont =
      GoogleFonts.bebasNeue(textStyle: const TextStyle(color: Colors.white));
  final Map<String, String> quizzes = {
    "AI":
        "https://docs.google.com/forms/d/1K42nqhJiYKCb-XBH29YHe4bET2oHqLMQ6N5jZLayrZ0/edit",
    "MC":
        "https://docs.google.com/forms/d/1FXwSXIpgPXE8wboCKr3i_OTmCRasiY_-LJLWl3ACuwE/edit",
    "SPCC":
        "https://docs.google.com/forms/d/1v8S4MmtyyFNadLs-yZpl3s6vgQ77VMkcMcA_tPfV7hY/edit",
    "CSS":
        "https://docs.google.com/forms/d/12sWJPPjkdDOVShTxS5MWnl5LzisscpQNtQ4bIDwWIb4/edit",
    "CCL":
        "https://docs.google.com/forms/d/1zm9smZcbexK9IDXmeGZQYetjp2E7ulQqFd7c1ao15eE/edit"
  };

  final Map<String, String> textBooks = {
    "AI":
    "https://docs.google.com/forms/d/1K42nqhJiYKCb-XBH29YHe4bET2oHqLMQ6N5jZLayrZ0/edit",
    "MC":
    "https://docs.google.com/forms/d/1FXwSXIpgPXE8wboCKr3i_OTmCRasiY_-LJLWl3ACuwE/edit",
    "SPCC":
    "https://docs.google.com/forms/d/1v8S4MmtyyFNadLs-yZpl3s6vgQ77VMkcMcA_tPfV7hY/edit",
    "CSS":
    "https://docs.google.com/forms/d/12sWJPPjkdDOVShTxS5MWnl5LzisscpQNtQ4bIDwWIb4/edit",
    "CCL":
    "https://docs.google.com/forms/d/1zm9smZcbexK9IDXmeGZQYetjp2E7ulQqFd7c1ao15eE/edit"
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1B17),
      body: SafeArea(
        bottom: false,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (Platform.isAndroid) const SizedBox(height: 24),
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
                                "MORE",
                                style: GoogleFonts.bebasNeue(
                                    fontSize: 30, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        HighlightedButton(
                            icon: const Icon(CupertinoIcons.xmark),
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                              Navigator.pop(context);
                            })
                      ]),
                ),
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "QUIZZES",
                          style: GoogleFonts.bebasNeue(
                              fontSize: 30, color: Colors.white),
                        ),
                        const SizedBox(height: 24),
                        ...[
                          for (var subject in quizzes.keys) ...[
                            GestureDetector(
                              onTap: () async {
                                await launchUrl(Uri.parse(quizzes[subject]!));
                              },
                              child: Container(
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.white)),
                                height: 52,
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 24.0),
                                  child: Text(subject, style: quizFont),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            )
                          ]
                        ],
                        Text(
                          "RESOURCES",
                          style: GoogleFonts.bebasNeue(
                              fontSize: 30, color: Colors.white),
                        ),
                        const SizedBox(height: 24),
                        ...[
                          for (var subject in textBooks.keys) ...[
                            GestureDetector(
                              onTap: () async {
                                await launchUrl(Uri.parse(textBooks[subject]!));
                              },
                              child: Container(
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.white)),
                                height: 52,
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 24.0),
                                  child: Text(subject, style: quizFont),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            )
                          ]
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
