part of 'get_annonce_transporteur_bloc.dart';

sealed class GetAnnonceTransporteurState extends Equatable {
  const GetAnnonceTransporteurState();
  
  @override
  List<Object> get props => [];
}

final class GetAnnonceInitial extends GetAnnonceTransporteurState {}

final class GetAnnonceFaliure extends GetAnnonceTransporteurState {}
final class GetAnnonceLoading extends GetAnnonceTransporteurState {}
final class GetAnnonceSuccess extends GetAnnonceTransporteurState {
  final List<AnnoncesTransporteur> annonces;

  const GetAnnonceSuccess(this.annonces);
  
}


