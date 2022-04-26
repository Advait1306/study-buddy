import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:study_buddy/helpers/database_helper.dart';
import 'package:study_buddy/widgets/highlighted_button.dart';
import 'package:study_buddy/widgets/more_page.dart';
import 'package:study_buddy/widgets/post_data_collector.dart';
import 'package:study_buddy/widgets/post_list.dart';
import 'package:study_buddy/widgets/user_data_collector.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  void refreshUserDetails() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //Render application
    return Scaffold(
        backgroundColor: const Color(0xFF1A1B17),
        body: SafeArea(
          bottom: false,
            child: Center(
                child: Column(
          children: [
            if (Platform.isAndroid) const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "STUDY BUDDY",
                      style: GoogleFonts.bebasNeue(
                          fontSize: 30, color: Colors.white),
                    ),
                    HighlightedButton(
                        icon: const Icon(CupertinoIcons.plus),
                        onPressed: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                      const PostDataCollector()));
                        })
                  ]),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  HighlightedButton(onPressed: () {
                    Navigator.push(context, CupertinoPageRoute(builder: (context) =>  MorePage()));
                  },icon: const Icon(CupertinoIcons.table_badge_more)),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Row(
            //   children: [
            //     TextButton(
            //         onPressed: refreshUserDetails,
            //         child: const Text("Refresh")),
            //     TextButton(
            //         onPressed: () {
            //           FirebaseAuth.instance.signOut();
            //         },
            //         child: const Text("Log out")),
            //     TextButton(onPressed: () {}, child: const Text("more"))
            //   ],
            // ),
            FutureBuilder(
                future: getUserDetails(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: const PostList());
                    } else {
                      Future.delayed(const Duration(milliseconds: 200), () {
                        Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => UserDataCollector()))
                            .then((value) {
                          setState(() {});
                        });
                      });
                      return const Text("Doesn't have data");
                    }
                  }
                  return const Text("Loading");
                }),
          ],
        ))));
  }
}
