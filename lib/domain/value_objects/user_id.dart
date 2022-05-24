import 'package:firestore_todo/domain/value_objects/value_object.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class UserId extends ValueObject<String> {
  UserId(String value) : super(value);
}

class UserIdConverter implements JsonConverter<UserId, String> {
  const UserIdConverter();

  @override
  UserId fromJson(String value) {
    return UserId(value);
  }

  @override
  String toJson(UserId value) {
    return value.value;
  }
}
