part of 'authentification_bloc.dart';

enum AuthentificationStatus { authentificated, unauthentificated, unknown }

class AuthentificationState extends Equatable{
  const AuthentificationState._({
    this.status = AuthentificationStatus.unknown,
    this.user
  });

  final AuthentificationStatus status;
  final MyUsers? user;

  const AuthentificationState.unknown() : this._();

  const AuthentificationState.authentificated(MyUsers myUser) :
    this._(status: AuthentificationStatus.authentificated, user: myUser);

  const AuthentificationState.unauthentificated() :
    this._(status: AuthentificationStatus.unauthentificated);

  @override
  List<Object?> get props => [status, user];
}