part of 'authentification_bloc.dart';

sealed class AuthentificationEvent extends Equatable {
  const AuthentificationEvent();

  @override
  List<Object> get props => [];
}

class AuthentificationUserChanged extends AuthentificationEvent {
  final MyUsers? user;
  const AuthentificationUserChanged(this.user);

}