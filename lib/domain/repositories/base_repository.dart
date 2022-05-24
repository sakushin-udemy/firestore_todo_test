import 'package:dartz/dartz.dart';
import 'package:firestore_todo/domain/database/abstract_table.dart';
import 'package:firestore_todo/domain/eitities/base_entity.dart';

import '../exceptions/data_not_found_failure.dart';
import '../exceptions/duplicated_data_failure.dart';
import '../exceptions/failure.dart';
import '../value_objects/data_key.dart';

abstract class BaseRepository<T extends BaseEntity, S> {
  final AbstractTable<T, S> table;
  BaseRepository(this.table);

  Future<Either<Failure, List<T>>> selectAll() async {
    return Right(await table.read());
  }

  Stream<List<T>> snapshotAll() {
    return table.snapshotList();
  }

  Future<Either<Failure, T>> selectOne(S id) async {
    var result = await table.read(id: id);
    if (result.isEmpty) {
      return Left(
        DataNotFoundFailure(
          '該当のデータが見つかりませんでした: $id()}',
          stackTrace: StackTrace.current,
        ),
      );
    }
    if (1 < result.length) {
      return Left(
        DuplicatedDataFailure(
          '該当のデータが複数見つかりました: $id()}',
          stackTrace: StackTrace.current,
        ),
      );
    }
    return Right(result[0]);
  }

  Future<Either<Failure, DataKey>> create(T data) async {
    var result = await table.read(id: data.id());
    if (result.isNotEmpty) {
      return Left(
        DuplicatedDataFailure(
          '該当のデータのIDは、既に登録されています: ${data.id()()}',
        ),
      );
    }

    return Right(await table.create(data));
  }

  Future<Either<Failure, T>> delete(S id) async {
    var result = await selectOne(id);
    return result.fold(
      (failure) => left(failure),
      (data) async {
        await table.delete(data.id());
        return right(data);
      },
    );
  }

  Future<Either<Failure, T>> update(T data) async {
    var result = await selectOne(data.id());

    return result.fold(
      (failure) => left(failure),
      (_) async {
        await table.update(data);
        return right(data);
      },
    );
  }
}
