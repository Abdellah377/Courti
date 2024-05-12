import 'models/model_user.dart';

abstract class UserRepository {
  Stream <MyUsers> get user;

  Future <void> setUserData(MyUsers user);

  Future <void> signInEmail(String E_mail, String password);

  Future <void> signInPhone(String phone, String password);

  Future <void> phoneAuth(String Num);

  Future <bool> verifyOTP(String otp);

  Future <MyUsers> linkEmailToPhoneAuth(MyUsers myuser);

  Future <void> logOut();

  Future<MyUsers> GetMyUser(String myUserId);
}