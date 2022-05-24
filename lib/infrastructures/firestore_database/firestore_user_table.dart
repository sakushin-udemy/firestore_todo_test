import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/database/abstract_table.dart';
import '../../domain/eitities/user.dart';
import '../../domain/value_objects/data_key.dart';
import '../../domain/value_objects/user_id.dart';

class FirestoreUserTable extends AbstractTable<User, UserId> {
  final FirebaseFirestore database;
  static const KEY = 'user';

  FirestoreUserTable(this.database);

  CollectionReference get _collection => database.collection(KEY);

  @override
  Future<void> delete(UserId userId) async {
    var user = await read(id: userId);
    if (user.length != 1) {
      return;
    }

    _collection.doc(user[0].userKey()).delete();
  }

  @override
  Future<void> update(User user) async {
    await _collection.doc(user.userKey()).set(user.toJson());
  }

  @override
  Future<DataKey> create(User user) async {
    var value = await _collection.add(user.toJson());
    var dataKey = DataKey(value.id);
    _collection.doc(value.id).update(user.copyWith(userKey: dataKey).toJson());

    return dataKey;
  }

  @override
  Future<List<User>> read({UserId? id}) async {
    var snapshot = (id == null
            ? _collection
            : _collection.where('userId', isEqualTo: id()))
        .get();

    List<QueryDocumentSnapshot> list = (await snapshot).docs;

    return list.map((snapshot) => snapshot.data()).map((element) {
      var data = element as Map<String, Object?>;
      var user = User.fromJson(data);
      return user;
    }).toList();
  }

  @override
  Stream<List<User>> snapshotList() {
    return _collection.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => User.fromJson(doc.data() as Map<String, dynamic>))
        .toList());
  }
}
