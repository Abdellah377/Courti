part of 'log_in_bloc.dart';

sealed class LogInEvent extends Equatable {
  const LogInEvent();

  @override
  List<Object> get props => [];
}

class LogInMail extends LogInEvent {
  final String email;
  final String password;

  const LogInMail(this.email, this.password);

  
  @override
  List<Object> get props => [email,password];
}

class LogInPhone extends LogInEvent {
  final String phone;
  final String password;

  const LogInPhone(this.phone, this.password);

  
  @override
  List<Object> get props => [phone,password];
}

class SignOutRequired extends LogInEvent {}