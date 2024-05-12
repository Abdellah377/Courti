part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpRequired extends SignUpEvent {
  final MyUsers user;
  final String otp;

  const SignUpRequired(this.user,this.otp);

  @override
  List<Object> get props => [user, otp];
}

class phoneAuth extends SignUpEvent{
  final String NumTelephone;

  const phoneAuth(this.NumTelephone);
  @override

  List<Object> get props => [NumTelephone];
}
