import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'my_user_event.dart';
part 'my_user_state.dart';

class MyUserBloc extends Bloc<MyUserEvent, MyUserState> {
  final UserRepository _userRepository;

  MyUserBloc({
    required UserRepository myUserRepository
  }) : _userRepository = myUserRepository,
  super(const MyUserState.loading()) {
    on<GetMyUser>((event, emit) async {
      try {
        MyUsers myUser = await _userRepository.GetMyUser(event.myUserid);
        emit(MyUserState.success(myUser));
      } catch (e) {
        emit(const MyUserState.faliure());
        print(e.toString());
      }
    });
  }
}
