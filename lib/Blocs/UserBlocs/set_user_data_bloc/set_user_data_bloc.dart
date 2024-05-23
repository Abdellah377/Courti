import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'set_user_data_event.dart';
part 'set_user_data_state.dart';

class SetUserDataBloc extends Bloc<SetUserDataEvent, SetUserDataState> {
  final UserRepository _userRepository;

  SetUserDataBloc({
    required UserRepository myUserRepository
  }) :  _userRepository = myUserRepository , super(SetUserDataInitial()) {
    on<SetUserData>((event, emit) async{
      emit(SetUserDataLoading());
      try {
        await _userRepository.setUserData(event.myUser);
        emit(SetUserDataSuccess());
      } catch (e) {
        print(e.toString());
        emit(SetUserDataFailure());
      }
    });
  }
}
