import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'authentification_event.dart';
part 'authentification_state.dart';

class AuthentificationBloc extends Bloc<AuthentificationEvent, AuthentificationState> {
  final UserRepository userRepository;
  late final StreamConsumer<MyUsers?> _userSubscription;

  AuthentificationBloc({
    required this.userRepository
  }) : super(const AuthentificationState.unknown()) {
    _userSubscription = userRepository.user.listen((user) { 
      add(AuthentificationUserChanged(user as MyUsers?));
    }) as StreamConsumer<MyUsers?>;

    on<AuthentificationUserChanged>((event, emit) {
      if(event.user != MyUsers.empty){
        emit(AuthentificationState.authentificated(event.user!));
      }else{
         emit(const AuthentificationState.unauthentificated());
      }
    });
  }

  @override
  Future<void> close() {
    _userSubscription.close();
    return super.close();
  }
}
