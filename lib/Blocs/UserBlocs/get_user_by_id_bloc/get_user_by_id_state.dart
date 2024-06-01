part of 'get_user_by_id_bloc.dart';

sealed class GetUserByIdState extends Equatable {
  const GetUserByIdState();
  
  @override
  List<Object> get props => [];
}

final class GetUserByIdInitial extends GetUserByIdState {}
final class GetUserByIdLoading extends GetUserByIdState {}
final class GetUserByIdFailed extends GetUserByIdState {
  final String errorMsg;
  const GetUserByIdFailed(this.errorMsg);
}
final class GetUserByIdSuccess extends GetUserByIdState {
  final MyUsers myUser;
  const GetUserByIdSuccess(this.myUser);
}

