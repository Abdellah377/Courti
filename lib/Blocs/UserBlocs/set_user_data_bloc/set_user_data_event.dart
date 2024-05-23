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