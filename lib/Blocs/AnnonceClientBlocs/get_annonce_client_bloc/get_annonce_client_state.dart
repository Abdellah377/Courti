part of 'get_annonce_client_bloc.dart';

sealed class GetAnnonceClientState extends Equatable {
  const GetAnnonceClientState();
  
  @override
  List<Object> get props => [];
}

final class GetAnnonceInitial extends GetAnnonceClientState {}

final class GetAnnonceFaliure extends GetAnnonceClientState {}
final class GetAnnonceLoading extends GetAnnonceClientState {}
final class GetAnnonceSuccess extends GetAnnonceClientState {
  final List<AnnoncesClient> annonces;

  const GetAnnonceSuccess(this.annonces);
}


