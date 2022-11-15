import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_bloc/fcode_bloc.dart';

class UserModel extends DBModel {
  static const NAME = 'name';
  static const EMAIL = 'email';
  static const PROFILE_IMAGE = 'profileImage';

  String? name;
  String? email;
  String? profileImage;

  UserModel({
    DocumentReference? ref,
    this.name,
    required this.email,
    this.profileImage,
  }) : super(ref: ref);

  @override
  UserModel clone() {
    return UserModel(
      ref: ref,
      name: name,
      email: email,
      profileImage: profileImage,
    );
  }
}
