import 'package:annonce_client_repository/annonce_client_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_annonce_client_event.dart';
part 'add_annonce_client_state.dart';

class AddAnnonceClientBloc extends Bloc<AddAnnonceClientEvent, AddAnnonceClientState> {
  AnnonceClientRepo _annonceRepo;

  AddAnnonceClientBloc({
    required AnnonceClientRepo annonceRepo
  }) : _annonceRepo = annonceRepo,
  super(AddAnnonceInitial()) {
    on<AddAnnonceClient>((event, emit) async {
      emit(AddAnnonceLoading());
      try {
        AnnoncesClient annonce = await _annonceRepo.addAnnonceClient(event.annonce);
        emit(AddAnnonceSuccess(annonce));
      } catch (e) {
        emit(AddAnnonceFailure());
      }
    });
  }
}
