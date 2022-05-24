enum PageModeStatus {
  //// 新規登録
  create,
  //// 表示 */
  read,
  //// 修正
  update,
  //// 削除
  delete,
}
/*
Function convertPageMode = (String value) {
  PageModeStatus status = PageModeStatus.values.firstWhere(
    (p) => p.toString().split('.').last == value,
    orElse: () => PageModeStatus.read,
  );
  return status;
};*/

class PageMode {
  final PageModeStatus status;
  PageMode(this.status);

  static const create = 'create';
  static const update = 'update';
  static const delete = 'delete';
  static const read = 'read';

  static final PageMode createMode = PageMode(PageModeStatus.create);
  static final PageMode updateMode = PageMode(PageModeStatus.update);
  static final PageMode deleteMode = PageMode(PageModeStatus.delete);
  static final PageMode readMode = PageMode(PageModeStatus.read);

  static PageMode convert(String value) {
    return value == create
        ? createMode
        : value == update
            ? updateMode
            : value == delete
                ? deleteMode
                : readMode;
  }

  bool get onlyRegister => status == PageModeStatus.create;
  bool get updatable =>
      status == PageModeStatus.create || status == PageModeStatus.update;
  bool get noChange => false;
  String get btnText => status == PageModeStatus.create
      ? '作成'
      : status == PageModeStatus.update
          ? '修正'
          : status == PageModeStatus.delete
              ? '削除'
              : '完了';
  String get path => status.toString().split('.')[1];

  @override
  String toString() {
    return 'PageMode[$status]';
  }
}
