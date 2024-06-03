import 'package:firebase_auth/firebase_auth.dart';

import 'models/model_user.dart';

abstract class UserRepository {
  Stream <MyUsers> get user;

  Future <void> setUserData(MyUsers user);

  Future <void> signInEmail(String E_mail, String password);

  Future <void> signInPhone(String phone, String password);

  Future <void> phoneAuth(String Num);

  Future <bool> verifyOTP(String otp);

  Future<bool> verifyUpdateOTP(String otp);

  Future <MyUsers> linkEmailToPhoneAuth(MyUsers myuser);

  Future <bool> setEmail(MyUsers myUser, String email);

  Future <void> setPassword(MyUsers Myuser, String password);

  Future <void> setPhoneNumber(MyUsers myUser,String phoneNumber);

  Future <void> logOut();

  Future<MyUsers> getMyUser(String myUserId);

  Future<List<MyUsers>> getUsers();

  Future<List<MyUsers>>getUsersByArg(String args, String argvalue);
  
  Future<User> getCurrentUser();
}