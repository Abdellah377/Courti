part of 'get_users_bloc.dart';

sealed class GetUsersEvent extends Equatable {
  const GetUsersEvent();

  @override
  List<Object> get props => [];
}

class GetUsers extends GetUsersEvent {}

class GetUsersByArg extends GetUsersEvent{
  final String args;
  final String value;

  const GetUsersByArg(this.args,this.value);

  @override
  List<Object> get props => [args,value];
}
