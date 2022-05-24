import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:firestore_todo/domain/eitities/base_entity.dart';
import '../value_objects/data_key.dart';
import '../value_objects/email_address.dart';
import '../value_objects/user_id.dart';
import '../value_objects/user_name.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// 使用者
/// 例：京都太郎、管理者A
@freezed
class User extends BaseEntity<UserId> with _$User {
  const User._(); //メソッド不要の場合、削除
  const factory User({
    /// 使用者のキー
    @DataKeyConverter() required DataKey userKey,

    /// 使用者のID
    @UserIdConverter() required UserId userId,

    /// 使用者の名前
    @UserNameConverter() required UserName userName,

    /// 使用者のメールアドレス
    @EmailAddressConverter() required EmailAddress emailAddress,
  }) = _User;
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  UserId id() => userId;
}
