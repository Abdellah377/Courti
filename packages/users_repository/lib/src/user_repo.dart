import 'models/model_user.dart';

abstract class UserRepository {
  Stream <MyUsers> get user;

  Future <MyUsers> signUp(MyUsers myuser);

  Future <void> setUserData(MyUsers user);

  Future <void> signInEmail(String E_mail, String password);

  Future <void> logOut();
}