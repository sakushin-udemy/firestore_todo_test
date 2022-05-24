import '../value_objects/data_key.dart';

abstract class AbstractTable<T, S> {
  Future<List<T>> read({S? id});
  Future<void> delete(S id);
  Future<DataKey> create(T entity);
  Future<void> update(T entity);

  Stream<List<T>> snapshotList();
}
