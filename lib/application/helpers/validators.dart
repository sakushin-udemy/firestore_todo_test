String? notEmptyStringValidator(String? value) {
  if (value == null || value.isEmpty) {
    return '必須です';
  }
  return null;
}

String? notEmptyValidator<T>(T? value) {
  if (value == null) {
    return '必須です';
  }
  return null;
}
