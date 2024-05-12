part of 'add_annonce_transporteur_bloc.dart';

sealed class AddAnnonceTransporteurEvent extends Equatable {
  const AddAnnonceTransporteurEvent();

  @override
  List<Object> get props => [];
}

class AddAnnonceTransporteur extends AddAnnonceTransporteurEvent {
  final AnnoncesTransporteur annonce;

  const AddAnnonceTransporteur(this.annonce);
}
