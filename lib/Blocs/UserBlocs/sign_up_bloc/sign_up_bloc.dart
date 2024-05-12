import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository _userRepository;

  SignUpBloc(this._userRepository) : super(SignUpInitial()) {
    on<SignUpRequired>((event, emit) async {
      emit(SignUpLoading());
      try {
        bool isVerified = await _userRepository.verifyOTP(event.otp);
        if (isVerified == true) {

          // MyUsers myUser = await _userRepository.signUp(event.user);
          // await _userRepository.setUserData(myUser);
          MyUsers myUser = await _userRepository.linkEmailToPhoneAuth(event.user);
          await _userRepository.setUserData(myUser);
          emit(SignUpSuccess());

        } else {

          emit(SignUpFailure());
        }
      } catch (e) {
        emit(SignUpFailure());
      }
    });

    on<phoneAuth>((event, emit) async {
      await _userRepository.phoneAuth(event.NumTelephone);
    });
  }
}
