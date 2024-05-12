part of 'add_annonce_client_bloc.dart';

sealed class AddAnnonceClientState extends Equatable {
  const AddAnnonceClientState();
  
  @override
  List<Object> get props => [];
}

final class AddAnnonceInitial extends AddAnnonceClientState {}

final class AddAnnonceFailure extends AddAnnonceClientState {}
final class AddAnnonceLoading extends AddAnnonceClientState {}
final class AddAnnonceSuccess extends AddAnnonceClientState {
  final AnnoncesClient annonce;

  const AddAnnonceSuccess(this.annonce);
}

