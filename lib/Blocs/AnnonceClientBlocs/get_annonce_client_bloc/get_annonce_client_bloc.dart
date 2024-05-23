import 'package:annonce_client_repository/annonce_client_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'get_annonce_client_event.dart';
part 'get_annonce_client_state.dart';

class GetAnnonceClientBloc extends Bloc<GetAnnonceClientEvent, GetAnnonceClientState> {
  final AnnonceClientRepo _annonceRepo;

  GetAnnonceClientBloc({
    required AnnonceClientRepo annonceRepo
  }) : _annonceRepo = annonceRepo,
  super(GetAnnonceInitial()) {
    on<GetAnnonceClient>((event, emit) async {
      emit(GetAnnonceLoading());
      try {
        List<AnnoncesClient> annonces = await _annonceRepo.getAnnoncesClient();
        emit(GetAnnonceSuccess(annonces));
      } catch (e) {
        emit(GetAnnonceFaliure());
      }
    });

    on<GetAnnonceClientByUser>((event, emit) async {
      emit(GetAnnonceLoading());
      try {
        List<AnnoncesClient> annonces = await _annonceRepo.getAnnoncesClientByUser(event.myUsers.user_id);
        
        emit(GetAnnonceSuccess(annonces));
      } catch (e) {
        emit(GetAnnonceFaliure());
      }
    });

    on<GetAnnonceClientByArgs>((event, emit) async{
      emit(GetAnnonceLoading());
      try {
        List<AnnoncesClient> annonces = await _annonceRepo.getAnnoncesClientByArgs(event.arg, event.argValue);
        emit(GetAnnonceSuccess(annonces));
      } catch (e) {
        emit(GetAnnonceFaliure());
      }
    });
  }
}
