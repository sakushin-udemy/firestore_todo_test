import 'package:firestore_todo/domain/value_objects/value_object.dart';

import '../value_objects/data_key.dart';

abstract class BaseEntity<S extends ValueObject> {
  const BaseEntity();
  S get idValue;
  DataKey get dataKey;

  Map<String, dynamic> toJson();
  BaseEntity convert(Map<String, Object?> map);
  BaseEntity setDataKey(DataKey key);
}
