import 'package:annonce_transporteur_repository/annonce_transporteur_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'get_annonce_transporteur_event.dart';
part 'get_annonce_transporteur_state.dart';

class GetAnnonceTransporteurBloc extends Bloc<GetAnnonceTransporteurEvent, GetAnnonceTransporteurState> {
  final AnnonceTransporteurRepo _annonceRepo;

  GetAnnonceTransporteurBloc({
    required AnnonceTransporteurRepo annonceRepo
  }) : _annonceRepo = annonceRepo,
  super(GetAnnonceInitial()) {
    on<GetAnnonceTransporteur>((event, emit) async{
      emit(GetAnnonceLoading());
      try {
        List<AnnoncesTransporteur> annonces = await _annonceRepo.getAnnoncesTransporteur();
        emit(GetAnnonceSuccess(annonces));
      } catch (e) {
        emit(GetAnnonceFaliure());
      }
    });

    on<GetAnnonceTransporteurByUser>((event, emit) async{
      emit(GetAnnonceLoading());
      try {
        List<AnnoncesTransporteur> annonces = await _annonceRepo.getAnnoncesTransporteurByUser(event.myUsers.user_id);
        emit(GetAnnonceSuccess(annonces));
      } catch (e) {
        emit(GetAnnonceFaliure());
      }
    });

    on<GetAnnonceTransporteurByArgs>((event, emit) async {
      emit(GetAnnonceLoading());
      try {
        List<AnnoncesTransporteur> annonces = await _annonceRepo.getAnnoncesTransporteurByArgs(event.args,event.argValue);
        emit(GetAnnonceSuccess(annonces));
      } catch (e) {
        emit(GetAnnonceFaliure());
      }
    });
  }
}
