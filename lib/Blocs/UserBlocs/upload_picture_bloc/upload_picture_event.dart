part of 'upload_picture_bloc.dart';

sealed class UploadPictureEvent extends Equatable {
  const UploadPictureEvent();

  @override
  List<Object> get props => [];
}

class UploadPicture extends UploadPictureEvent{
  final String file;
  final String userId;

  const UploadPicture(this.file, this.userId);

  @override
  List<Object> get props => [file, userId];
}
