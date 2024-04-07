part of 'get_annonce_bloc.dart';

sealed class GetAnnonceEvent extends Equatable {
  const GetAnnonceEvent();

  @override
  List<Object> get props => [];
}

class GetAnnonce extends GetAnnonceEvent{}
