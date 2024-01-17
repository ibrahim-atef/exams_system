import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? name;
  String? email;
  String? role;

  String? uid;
  Timestamp? registerDate;

  UserModel(this.name,this.role, this.uid, this.email, this.registerDate);

  factory UserModel.fromMap(map) {
    return UserModel(
      map['displayName'], map['role'],
      map['uid'],

      map['email'],
      map['registerDate'],
    );
  }
}
class StudentScoreModel {
  final String studentName;
  final int score;

  StudentScoreModel({
    required this.studentName,
    required this.score,
  });

  factory StudentScoreModel.fromJson(  json) {
    return StudentScoreModel(
      studentName: json['studentName'] ?? '',
      score: (json['score'] ?? 0),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "studentName": studentName,
      "score": score,
    };
  }
}
