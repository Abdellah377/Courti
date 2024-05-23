import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'get_users_event.dart';
part 'get_users_state.dart';

class GetUsersBloc extends Bloc<GetUsersEvent, GetUsersState> {
  final UserRepository _userRepository;


  GetUsersBloc({
    required UserRepository myUserRepository
  }) : _userRepository = myUserRepository,  super(GetUsersInitial()) {
    on<GetUsers>((event, emit) async{
      emit(GetUsersLoading());
      try {
        List<MyUsers> myUsers = await _userRepository.getUsers();
        emit(GetUsersSuccess(myUsers));
      } catch (e) {
        emit(GetUsersfailure());
      }
    });
    on<GetUsersByArg>((event, emit) async {
      emit(GetUsersLoading());
      try {
        List<MyUsers> myUsers = await _userRepository.getUsersByArg(event.args,event.value);
        emit(GetUsersSuccess(myUsers));
      } catch (e) {
        emit(GetUsersfailure());
      }
    });
  }
}
