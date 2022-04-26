// ignore_for_file: constant_identifier_names

import 'package:study_buddy/models/user_details.dart';

enum Timing { MORNING, AFTERNOON, EVENING, LATENIGHT }

class Post {
  final String title;
  final Subject subject;
  final String place;
  final String teacher;
  final String days;
  final Timing timing;
  final int groupSize;
  final String? description;
  final String authorName;
  final String authorUid;
  final String phoneNumber;

  Post({
    required this.phoneNumber,
    required this.title,
    required this.subject,
    required this.place,
    required this.teacher,
    required this.days,
    required this.timing,
    required this.groupSize,
    required this.description,
    required this.authorName,
    required this.authorUid,
  });

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "subject": subject.name,
      "place": place,
      "teacher": teacher,
      "days": days,
      "timing": timing.name,
      "group_size": groupSize,
      "description": description ?? "",
      "author_name": authorName,
      "author_uid": authorUid,
      "phone_number" : phoneNumber,
    };
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        title: json["title"],
        subject: Subject.values.byName(json["subject"]),
        place: json["place"],
        teacher: json["teacher"],
        days: json["days"],
        timing: Timing.values.byName(json["timing"]),
        groupSize: json["group_size"],
        description: json["description"],
        authorName: json["author_name"],
        authorUid: json["author_uid"],
        phoneNumber: json["phone_number"]
    );
  }
}
