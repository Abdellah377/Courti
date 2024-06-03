import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'get_user_by_id_event.dart';
part 'get_user_by_id_state.dart';

class GetUserByIdBloc extends Bloc<GetUserByIdEvent, GetUserByIdState> {
  final UserRepository _userRepository;

  GetUserByIdBloc({
    required UserRepository myUserRepository
  }) :  _userRepository = myUserRepository ,super(GetUserByIdInitial()) {
    on<GetUserById>((event, emit) async {
      try {
        MyUsers myUser = await _userRepository.getMyUser(event.myUserid);
        emit(GetUserByIdSuccess(myUser));
      } catch (e) {
        emit(GetUserByIdFailed());
      }
    });
  }
}
