/*
@freezed
class Project with _$Project {
  const Project._(); //メソッド不要の場合、削除
  const factory Project({
    required String projectId,
    required String projectName,
    @DataKeyConverter() required DataKey projectKey,
    required String corporationName,
    @DataKeyConverter() required DataKey corporationKey,
  }) = _Project;

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  static Future<Either<Failure, List<Project>>> selectAll(Database database,
      {DataKey? corporationKey}) async {
    return Right(await database.project().read(corporationKey: corporationKey));
  }

  static Stream<List<Project>> snapshotAll(Database database) {
    return database.project().snapshotList();
  }

  static Future<Either<Failure, Project>> selectOne(
      Database database, String projectId) async {
    var result = await database.project().read(id: projectId);
    if (result.isEmpty) {
      return Left(
        DataNotFoundFailure(
          '該当のCategoryIdのカテゴリが見つかりませんでした: $projectId',
          stackTrace: StackTrace.current,
        ),
      );
    }
    if (1 < result.length) {
      return Left(
        DuplicatedDataFailure(
          '該当のCategoryIdのカテゴリが複数見つかりました: $projectId}',
          stackTrace: StackTrace.current,
        ),
      );
    }
    return Right(result[0]);
  }

  Future<Either<Failure, DataKey>> create(Database database) async {
    var result = await database.project().read(id: projectId);
    if (result.isNotEmpty) {
      return Left(
        DuplicatedDataFailure(
          '該当のprojectIdのカテゴリは、既に登録されています: $projectId',
        ),
      );
    }

    return Right(await database.project().create(this));
  }

  Future<Either<Failure, Project>> delete(Database database) async {
    var result = await selectOne(database, projectId);
    if (result.isLeft()) {
      return result;
    }
    await database.project().delete(projectId);
    return Right(this);
  }

  Future<Either<Failure, Project>> update(Database database) async {
    var result = await selectOne(database, projectId);
    if (result.isLeft()) {
      return result;
    }
    database.project().update(this);
    return Right(this);
  }
}

 */
