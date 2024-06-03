// ignore_for_file: avoid_print

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

    on<SetEmail>((event, emit) async {
      emit(SetUserDataLoading());
      try {
        await _userRepository.setEmail(event.myUser,event.email);
        emit(SetUserDataSuccess());
      } catch (e) {
        print(e.toString());
        emit(SetUserDataFailure());
      }
    });

    on<SetPhone>((event, emit) async{
      emit(SetUserDataLoading());
      try {
        await _userRepository.setPhoneNumber(event.myUser, event.phone);
        emit(SetUserDataSuccess());
      } catch (e) {
        print(e.toString());
        emit(SetUserDataFailure());
      }
    });

    on<VerSetPhone>((event, emit) async{
      emit(SetUserDataLoading());
      try {
        bool isVerified = await _userRepository.verifyUpdateOTP(event.otp);
        if (isVerified == true) {
          _userRepository.setUserData(event.myUser);
        } else {
          throw "   [     otp wrong     ]   ";
        }
        emit(SetUserDataSuccess());
      } catch (e) {
        print(e.toString());
        emit(SetUserDataFailure());
      }
    });


    on<setPassword>((event, emit) async{
      emit(SetUserDataLoading());
      try {
        await _userRepository.setPassword(event.myUser, event.password);
        emit(SetUserDataSuccess());
      } catch (e) {
        emit(SetUserDataFailure());
      }
    });

  }
}
