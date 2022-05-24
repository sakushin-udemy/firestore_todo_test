import '../../domain/eitities/user.dart';

class LoginUserInfo {
  LoginUserInfo._();

  User? _loginUser;

  User? get loginUser => _loginUser;
  bool get isLogin => _loginUser != null;

  static final LoginUserInfo _instance = LoginUserInfo._();

  factory LoginUserInfo() {
    return _instance;
  }

  void login(User user) {
    _loginUser = user;
  }

  void logoff() {
    _loginUser = null;
  }
}
