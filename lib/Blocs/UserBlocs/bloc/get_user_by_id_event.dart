part of 'get_user_by_id_bloc.dart';

sealed class GetUserByIdEvent extends Equatable {
  const GetUserByIdEvent();

  @override
  List<Object> get props => [];
}

class GetUserById extends GetUserByIdEvent{
  final String myUserid;

  const GetUserById({required this.myUserid});
  
  @override
  List<Object> get props => [myUserid];
}