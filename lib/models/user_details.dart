// ignore_for_file: constant_identifier_names

enum Subject { SPCC, CSS, AI, QA, IOT, MC }

class UserDetails {
  final String name;
  final String division;
  final List<Subject> subjects;
  final String bio;
  final String phoneNumber;

  UserDetails(
      {required this.name,
      required this.division,
      required this.subjects,
      required this.bio,
      required this.phoneNumber});

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "division": division,
      "subjects": subjects.map((subject) => subject.name).toList(),
      "bio": bio,
      "phone_number": phoneNumber
    };
  }

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
        name: json["name"],
        division: json["division"],
        bio: json["bio"],
        phoneNumber: json["phone_number"],
        subjects: (json["subjects"] as List)
            .map((name) => Subject.values.byName(name))
            .toList());
  }
}
