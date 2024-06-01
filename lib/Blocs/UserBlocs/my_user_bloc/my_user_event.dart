part of 'my_user_bloc.dart';

sealed class MyUserEvent extends Equatable {
  const MyUserEvent();

  @override
  List<Object> get props => [];
}

class GetMyUser extends MyUserEvent{
  final String myUserid;

  const GetMyUser({required this.myUserid});
  
  @override
  List<Object> get props => [myUserid];
}
