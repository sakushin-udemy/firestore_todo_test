/*
@freezed
class Corporation with _$Corporation {
  const Corporation._(); //メソッド不要の場合、削除
  const factory Corporation({
    required String corporationId,
    required String corporationName,
    @DataKeyConverter() required DataKey corporationKey,
  }) = _Corporation;

  factory Corporation.fromJson(Map<String, dynamic> json) =>
      _$CorporationFromJson(json);
  static Future<Either<Failure, List<Corporation>>> selectAll(
      Database database) async {
    return Right(await database.corporation().read());
  }

  static Stream<List<Corporation>> snapshotAll(Database database) {
    return database.corporation().snapshotList();
  }

  static Future<Either<Failure, Corporation>> selectOne(
      Database database, String corporationId) async {
    var result = await database.corporation().read(id: corporationId);
    if (result.isEmpty) {
      return Left(
        DataNotFoundFailure(
          '該当のCategoryIdのカテゴリが見つかりませんでした: $id',
          stackTrace: StackTrace.current,
        ),
      );
    }
    if (1 < result.length) {
      return Left(
        DuplicatedDataFailure(
          '該当のCategoryIdのカテゴリが複数見つかりました: $id',
          stackTrace: StackTrace.current,
        ),
      );
    }
    return Right(result[0]);
  }

  Future<Either<Failure, DataKey>> create(Database database) async {
    var result = await database.corporation().read(id: corporationId);
    if (result.isNotEmpty) {
      return Left(
        DuplicatedDataFailure(
          '該当のcorporationIdのカテゴリは、既に登録されています: $corporationId}',
        ),
      );
    }

    return Right(await database.corporation().create(this));
  }

  Future<Either<Failure, Corporation>> delete(Database database) async {
    var result = await selectOne(database, corporationId);
    if (result.isLeft()) {
      return result;
    }
    await database.corporation().delete(corporationId);
    return Right(this);
  }

  Future<Either<Failure, Corporation>> update(Database database) async {
    var result = await selectOne(database, corporationId);
    if (result.isLeft()) {
      return result;
    }
    database.corporation().update(this);
    return Right(this);
  }
}
*/
