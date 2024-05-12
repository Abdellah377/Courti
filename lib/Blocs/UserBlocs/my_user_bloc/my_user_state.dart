part of 'my_user_bloc.dart';

enum MyUserStatus {success, loading ,faliure }


class MyUserState extends Equatable {
  final MyUserStatus status;
  final MyUsers? myUser;

  const MyUserState._({
    this.status = MyUserStatus.loading, 
    this.myUser,
  });

  const MyUserState.loading() : this._();
  const MyUserState.success(MyUsers user) : this._(status: MyUserStatus.success, myUser: user);
  const MyUserState.faliure() : this._(status: MyUserStatus.faliure);
  
  @override
  List<Object> get props => [];
}



