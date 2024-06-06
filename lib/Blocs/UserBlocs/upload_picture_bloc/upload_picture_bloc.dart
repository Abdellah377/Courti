import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'upload_picture_event.dart';
part 'upload_picture_state.dart';

class UploadPictureBloc extends Bloc<UploadPictureEvent, UploadPictureState> {
  final UserRepository _userRepository;

  UploadPictureBloc({
    required UserRepository userRepository
  }) : _userRepository = userRepository, super(UploadPictureInitial()) {
    on<UploadPicture>((event, emit) async{
      emit(UploadPictureLoading());
      try {
        String userImage = await _userRepository.UploadPicture(event.file, event.userId);
        emit(UploadPictureSuccess(userImage));
      } catch (e) {
        emit(UploadPictureFailure());
        print(e.toString());
      }
    });
  }
}
