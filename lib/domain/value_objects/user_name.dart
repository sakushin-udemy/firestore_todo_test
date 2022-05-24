import 'package:firestore_todo/domain/value_objects/value_object.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class UserName extends ValueObject<String> {
  UserName(String value) : super(value);
}

class UserNameConverter implements JsonConverter<UserName, String> {
  const UserNameConverter();

  @override
  UserName fromJson(String value) {
    return UserName(value);
  }

  @override
  String toJson(UserName value) {
    return value.value;
  }
}
