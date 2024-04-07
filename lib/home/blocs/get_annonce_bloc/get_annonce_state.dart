part of 'get_annonce_bloc.dart';

sealed class GetAnnonceState extends Equatable {
  const GetAnnonceState();
  
  @override
  List<Object> get props => [];
}

final class GetAnnonceInitial extends GetAnnonceState {}

final class GetAnnonceFaliure extends GetAnnonceState {}
final class GetAnnonceLoading extends GetAnnonceState {}
// final class GetAnnonceSuccess extends GetAnnonceState {
//   final List<Annonce> annonces;
//   const GetAnnonceSuccess(this.annonces);
  
//   List<Object> get props => [annonces];
// }


