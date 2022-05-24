import 'package:firestore_todo/domain/value_objects/value_object.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class EmailAddress extends ValueObject<String> {
  EmailAddress(String value) : super(value);
}

class EmailAddressConverter implements JsonConverter<EmailAddress, String> {
  const EmailAddressConverter();

  @override
  EmailAddress fromJson(String value) {
    return EmailAddress(value);
  }

  @override
  String toJson(EmailAddress value) {
    return value();
  }
}
