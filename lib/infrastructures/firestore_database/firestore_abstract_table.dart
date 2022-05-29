import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_todo/domain/database/abstract_table.dart';
import 'package:firestore_todo/domain/eitities/base_entity.dart';
import 'package:firestore_todo/domain/value_objects/data_key.dart';

import '../../domain/value_objects/value_object.dart';

abstract class FirestoreAbstractTable<T extends BaseEntity,
    S extends ValueObject> extends AbstractTable<T, S> {
  String get getKey;
  T convert(Map<String, Object?> json);

  FirestoreAbstractTable(this.database);
  final FirebaseFirestore database;

  CollectionReference get collection => database.collection(getKey);

  @override
  Future<DataKey> create(T entity) async {
    var value = await collection.add(entity.toJson());
    var dataKey = DataKey(value.id);

    BaseEntity newEntity = entity.setDataKey(dataKey);
    collection.doc(value.id).update(newEntity.toJson());

    return dataKey;
  }

  @override
  Future<void> delete(S id) async {
    var user = await read(id: id);
    if (user.length != 1) {
      return;
    }

    collection.doc(user[0].idValue()).delete();
  }

  @override
  Future<List<T>> read({S? id}) async {
    var snapshot =
        (id == null ? collection : collection.where('id', isEqualTo: id()))
            .get();

    List<QueryDocumentSnapshot> list = (await snapshot).docs;

    Iterable data = list.map((snapshot) => snapshot.data());

    return data
        .map((e) => e as Map<String, Object?>)
        .map((e) => convert(e))
        .toList();
  }

  @override
  Stream<List<T>> snapshotList() {
    return collection.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => convert(doc.data() as Map<String, dynamic>))
        .toList());
  }

  @override
  Future<void> update(T entity) async {
    await collection.doc(entity.dataKey()).set(entity.toJson());
  }
}
