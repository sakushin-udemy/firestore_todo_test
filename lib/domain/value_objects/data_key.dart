import 'package:firestore_todo/domain/value_objects/value_object.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class DataKey extends ValueObject<String> {
  static final empty = DataKey('');
  DataKey(String key) : super(key);
}

class DataKeyConverter implements JsonConverter<DataKey, String> {
  const DataKeyConverter();

  @override
  DataKey fromJson(String value) {
    return DataKey(value);
  }

  @override
  String toJson(DataKey value) {
    return value.value;
  }
}
