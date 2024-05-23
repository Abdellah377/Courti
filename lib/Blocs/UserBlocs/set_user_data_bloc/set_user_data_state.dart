part of 'set_user_data_bloc.dart';

sealed class SetUserDataState extends Equatable {
  const SetUserDataState();
  
  @override
  List<Object> get props => [];
}

final class SetUserDataInitial extends SetUserDataState {}
final class SetUserDataLoading extends SetUserDataState {}
final class SetUserDataFailure extends SetUserDataState {}
final class SetUserDataSuccess extends SetUserDataState {}

