part of 'set_user_data_bloc.dart';

sealed class SetUserDataEvent extends Equatable {
  const SetUserDataEvent();

  @override
  List<Object> get props => [];
}

class SetUserData extends SetUserDataEvent{
  final MyUsers myUser;

  const SetUserData(this.myUser);

  @override
  List<Object> get props => [myUser];
}

class SetEmail extends SetUserDataEvent{
  final MyUsers myUser;
  final String email;

  const SetEmail(this.myUser,this.email);

  @override
  List<Object> get props => [myUser,email];
}

class SetPhone extends SetUserDataEvent{
  final MyUsers myUser;
  final String phone;

  const SetPhone(this.myUser, this.phone);

  @override
  List<Object> get props => [myUser, phone];
}

class VerSetPhone extends SetUserDataEvent{
  final MyUsers myUser;
  final String otp;

  const VerSetPhone(this.myUser, this.otp);

  @override
  List<Object> get props => [myUser, otp];
}

class setPassword extends SetUserDataEvent{
  final MyUsers myUser;
  final String password;

  const setPassword(this.myUser, this.password);

  @override
  List<Object> get props => [myUser, password];
}