import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_bloc/fcode_bloc.dart';

class UserModel extends DBModel {

  String? name;
  String? email;
  String? profileImage;
  int difficulty;
  int rank;
  int score;
  int level;
  int played;

  UserModel({
    DocumentReference? ref,
    this.name,
    required this.email,
    required this.difficulty,
    required this.rank,
    required this.score,
    required this.level,
    required this.played,
    this.profileImage,
  }) : super(ref: ref);

  @override
  UserModel clone() {
    return UserModel(
      ref: ref,
      name: name,
      email: email,
      profileImage: profileImage,
      difficulty: difficulty,
      rank: rank,
      score: score,
      level: level,
      played: played,
    );
  }
}
