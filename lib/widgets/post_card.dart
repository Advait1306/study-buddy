import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_buddy/helpers/whatsapp_helper.dart';
import 'package:study_buddy/models/post.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:study_buddy/widgets/highlighted_button.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final void Function() onTap;
  final bool isExpanded;
  PostCard(
      {Key? key,
      required this.post,
      required this.onTap,
      required this.isExpanded})
      : super(key: key);

  final propertiesStyle =
      GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w400);
  final subHeadingStyle = GoogleFonts.inter(
      color: const Color(0xFFCAFE48), fontWeight: FontWeight.w500);
  final normalTextStyle = GoogleFonts.inter(color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 32),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFF252525)),
        width: MediaQuery.of(context).size.width * 0.8,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 24),
            Text(
              post.title,
              style: GoogleFonts.inter(
                  color: const Color(0xFFCAFE48),
                  letterSpacing: -1,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(
                  CupertinoIcons.location_fill,
                  size: 15,
                  color: Colors.white,
                ),
                const SizedBox(width: 5),
                Text(post.place, style: propertiesStyle),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(
                  CupertinoIcons.person_2,
                  size: 15,
                  color: Colors.white,
                ),
                const SizedBox(width: 5),
                Text(post.groupSize.toString(), style: propertiesStyle),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(
                  CupertinoIcons.pencil,
                  size: 15,
                  color: Colors.white,
                ),
                const SizedBox(width: 5),
                Text(post.teacher, style: propertiesStyle),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(
                  CupertinoIcons.person,
                  size: 15,
                  color: Colors.white,
                ),
                const SizedBox(width: 5),
                Text(post.authorName, style: propertiesStyle),
              ],
            ),
            const SizedBox(height: 10),
            if (isExpanded) ...[
              if (post.description != null && post.description!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Description", style: subHeadingStyle),
                    const SizedBox(height: 5),
                    Text(post.description!, style: normalTextStyle),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Days", style: subHeadingStyle),
                  const SizedBox(height: 5),
                  Text(post.days, style: normalTextStyle),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              HighlightedButton(
                  icon: const Icon(CupertinoIcons.chat_bubble),
                  onPressed: () {
                    openWhatsapp(
                        phoneNumber: post.phoneNumber,
                        message:
                            "Hello, contacting you for your post on StudyBuddy app title *${post.title}*. I would like to join your group, can you tell me more about it?",
                        context: context);
                  })
            ],
            const SizedBox(height: 24)
          ]),
        ),
      ),
    );
  }
}
