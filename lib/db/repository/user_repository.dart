import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_bloc/fcode_bloc.dart';
import '../model/user_model.dart';

class UserRepository extends FirebaseRepository<UserModel> {
  UserRepository() : super('User');

  @override
  UserModel fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data()!;

    return UserModel(
      ref: snapshot.reference,
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      profileImage: data['profileImage'] ?? '',
    );
  }

  @override
  Map<String, Object?> toMap(UserModel value, SetOptions? options) {
    return {
      'email': value.email,
      'name': value.name,
      'profileImg': value.profileImage,
    };
  }

  @override
  Future<DocumentReference> update({
    required UserModel item,
    SetOptions? setOptions,
    String? type,
    DocumentReference? parent,
    MapperCallback<UserModel>? mapper,
  }) {
    return super.update(
      item: item,
      mapper: mapper,
    );
  }

  @override
  Future<Iterable<UserModel>> querySingle(
      {required QueryTransformer spec,
      DocumentReference? parent,
      Source source = Source.serverAndCache}) {
    return super.querySingle(
      spec: spec,
    );
  }


  @override
  Stream<Iterable<UserModel>> query({
    required QueryTransformer spec,
    String? type,
    DocumentReference? parent,
    bool includeMetadataChanges = false,
  }) {
    return super.query(spec: spec);
  }

  @override
  Future<DocumentReference> add({
    required UserModel item,
    SetOptions? setOptions,
    DocumentReference? parent,
    String? type,
  }) {
    return super.add(
      item: item,
    );
  }
}
