part of 'add_annonce_client_bloc.dart';

sealed class AddAnnonceClientEvent extends Equatable {
  const AddAnnonceClientEvent();

  @override
  List<Object> get props => [];
}

class AddAnnonceClient extends AddAnnonceClientEvent {
  final AnnoncesClient annonce;

  const AddAnnonceClient(this.annonce);
}

class SetAnnonceClient extends AddAnnonceClientEvent {
  final AnnoncesClient annonce;

  const SetAnnonceClient(this.annonce);
}
