import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_annonce_event.dart';
part 'get_annonce_state.dart';

class GetAnnonceBloc extends Bloc<GetAnnonceEvent, GetAnnonceState> {
  GetAnnonceBloc() : super(GetAnnonceInitial()) {
    on<GetAnnonceEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
