import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'log_in_event.dart';
part 'log_in_state.dart';

class LogInBloc extends Bloc<LogInEvent, LogInState> {
  final UserRepository _userRepository;

  LogInBloc(
    this._userRepository
  ) : super(LogInInitial()) {
    on<LogInMail>((event, emit) async{
      emit(LogInLoading());
      try{
        await _userRepository.signInEmail(event.email, event.password);
        emit(LogInSuccess());
      }catch(e){
        emit(LogInFailure());
      }
    });
    on<LogInPhone>((event, emit) async {
      emit(LogInLoading());
      try {
        await _userRepository.signInPhone(event.phone, event.password);
        emit(LogInSuccess());
      } catch (e) {
        emit(LogInFailure());
      }
    });
    on<SignOutRequired>((event, emit) async => await _userRepository.logOut());
  }
}
