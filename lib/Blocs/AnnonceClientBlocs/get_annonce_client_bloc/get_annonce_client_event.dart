part of 'get_annonce_client_bloc.dart';

sealed class GetAnnonceClientEvent extends Equatable {
  const GetAnnonceClientEvent();

  @override
  List<Object> get props => [];
}

class GetAnnonceClient extends GetAnnonceClientEvent{}

class GetAnnonceClientByUser extends GetAnnonceClientEvent{
  final MyUsers myUsers;

const GetAnnonceClientByUser(this.myUsers);

  @override
  List<Object> get props => [myUsers];

}


