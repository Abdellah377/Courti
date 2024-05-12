part of 'add_annonce_transporteur_bloc.dart';

sealed class AddAnnonceTransporteurState extends Equatable {
  const AddAnnonceTransporteurState();
  
  @override
  List<Object> get props => [];
}

final class AddAnnonceInitial extends AddAnnonceTransporteurState {}

final class AddAnnonceFailure extends AddAnnonceTransporteurState {}
final class AddAnnonceLoading extends AddAnnonceTransporteurState {}
final class AddAnnonceSuccess extends AddAnnonceTransporteurState {
  final AnnoncesTransporteur annonce;

  const AddAnnonceSuccess(this.annonce);
}

