import 'package:freezed_annotation/freezed_annotation.dart';

abstract class ValueObject<T> {
  T value;
  ValueObject(this.value);
  T call() {
    return value;
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType == runtimeType) {
      return (other as ValueObject).value == value;
    }

    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return '$runtimeType[$value]';
  }
}

/** 失敗。どうにかできないか
class ValueObjectConverter<S extends ValueObject>
    implements JsonConverter<S, String> {
  const ValueObjectConverter();

  @override
  S fromJson(String value) {
    return S(value);
  }

  @override
  String toJson(S value) {
    return value.value;
  }
}
**/
class ValueObjectConverter<S extends ValueObject>
    implements JsonConverter<S, String> {
  const ValueObjectConverter(this.convert);

  final Function convert;

  @override
  S fromJson(String value) {
    return convert(value);
  }

  @override
  String toJson(S value) {
    return value.value;
  }
}
