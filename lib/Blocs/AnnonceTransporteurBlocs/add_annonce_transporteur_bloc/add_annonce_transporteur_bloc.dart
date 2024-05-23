import 'package:annonce_transporteur_repository/annonce_transporteur_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_annonce_transporteur_event.dart';
part 'add_annonce_transporteur_state.dart';

class AddAnnonceTransporteurBloc extends Bloc<AddAnnonceTransporteurEvent, AddAnnonceTransporteurState> {
  AnnonceTransporteurRepo _annonceRepo;

  AddAnnonceTransporteurBloc({
    required AnnonceTransporteurRepo annonceRepo
  }) : _annonceRepo = annonceRepo,
  super(AddAnnonceInitial()) {
    on<AddAnnonceTransporteur>((event, emit) async {
      emit(AddAnnonceLoading());
      try {
        AnnoncesTransporteur annonce = await _annonceRepo.addAnnonceTransporteur(event.annonce);
        emit(AddAnnonceSuccess(annonce));
      } catch (e) {
        emit(AddAnnonceFailure());
      }
    });
    on<SetAnnonceTransporteur>((event, emit) async {
      emit(AddAnnonceLoading());
      try {
        AnnoncesTransporteur annonce = await _annonceRepo.setAnnonceTransporteur(event.annonce);
        emit(AddAnnonceSuccess(annonce));
      } catch (e) {
        emit(AddAnnonceFailure());
      }
    });
  }
}
