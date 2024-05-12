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

