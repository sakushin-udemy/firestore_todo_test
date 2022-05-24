import 'package:firestore_todo/domain/value_objects/value_object.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

main() {
  test('generic get_it', () async {
    GetIt.I.registerSingleton<List<String>>(['a', 'b', 'c']);
    GetIt.I.registerSingleton<List<int>>([1, 2, 3, 4]);

    expect(GetIt.I.get<List<String>>().length, 3);
    expect(GetIt.I.get<List<int>>().length, 4);
  });
}
