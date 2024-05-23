part of 'get_annonce_transporteur_bloc.dart';

sealed class GetAnnonceTransporteurEvent extends Equatable {
  const GetAnnonceTransporteurEvent();

  @override
  List<Object> get props => [];
}

class GetAnnonceTransporteur extends GetAnnonceTransporteurEvent{}

class GetAnnonceTransporteurByUser extends GetAnnonceTransporteurEvent{
  final MyUsers myUsers;

  const GetAnnonceTransporteurByUser(this.myUsers);

  @override
  List<Object> get props => [myUsers];
}

class GetAnnonceTransporteurByArgs extends GetAnnonceTransporteurEvent{
  final String args;
  final String argValue;

  const GetAnnonceTransporteurByArgs(this.args,this.argValue);

  @override
  List<Object> get props => [args,argValue];
}