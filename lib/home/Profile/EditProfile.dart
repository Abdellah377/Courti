import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kourti_application_1/Blocs/UserBlocs/authentification_bloc/authentification_bloc.dart';
import 'package:kourti_application_1/Blocs/UserBlocs/set_user_data_bloc/set_user_data_bloc.dart';
import 'package:kourti_application_1/Blocs/UserBlocs/upload_picture_bloc/upload_picture_bloc.dart';
import 'package:kourti_application_1/app_language_provider.dart';
import 'package:kourti_application_1/app_localizations.dart';
import 'package:kourti_application_1/home/Profile/EditProfileValues.dart';
import 'package:provider/provider.dart';
import 'package:user_repository/user_repository.dart';

class EditProfile extends StatefulWidget {
  final MyUsers myUser;
  const EditProfile(this.myUser, {super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late MyUsers User;

  @override
  void initState() {
    User = widget.myUser;
    super.initState();
  }

    late AppLanguageProvider appLanguage;

  @override
  Widget build(BuildContext context) {
    appLanguage = Provider.of<AppLanguageProvider>(context);
    return BlocListener<UploadPictureBloc, UploadPictureState>(
      listener: (context, state) {
        if (state is UploadPictureSuccess) {
          setState(() {
            User.picture = state.userImage;
          });
      }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          centerTitle: true,
          title: Text(AppLocalizations.of(context)!.translate('Edit Profile')!),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));
            setState(() {});
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 50),
                        User.picture == ""
                            ? Stack(
                              children: [
                                Container(
                                  width: 160,
                                  height: 160,
                                  decoration: const BoxDecoration(
                                      color: Colors.amber,
                                      shape: BoxShape.circle),
                                ),
                                Positioned(
                                  bottom: -14,
                                  left: 120,
                                  child:IconButton(
                                    onPressed: () async{
                                      final ImagePicker picker = ImagePicker();
                                      final XFile? image = await picker.pickImage(
                                        source: ImageSource.gallery,
                                        maxHeight: 500,
                                        maxWidth: 500,
                                        imageQuality: 40,
                                      );
                                      if (image != null) {
                                        CroppedFile? croppedFile =
                                            await ImageCropper().cropImage(
                                                sourcePath: image.path,
                                                aspectRatio: const CropAspectRatio(
                                                    ratioX: 1, ratioY: 1),
                                            //     aspectRatioPresets: [
                                            //   CropAspectRatioPreset.square
                                            // ],
                                                uiSettings: [
                                              AndroidUiSettings(
                                                  toolbarTitle: 'Cropper',
                                                  toolbarColor: Colors.grey,
                                                  toolbarWidgetColor: Colors.white,
                                                  initAspectRatio:
                                                      CropAspectRatioPreset
                                                          .original,
                                                  lockAspectRatio: false),
                                              IOSUiSettings(
                                                title: 'Cropper',
                                              )
                                            ]);
                                        if (croppedFile != null) {
                                          setState(() {
                                            context.read<UploadPictureBloc>().add(
                                                UploadPicture(
                                                    image.path, User.user_id));
                                          });
                                        }
                                      }
                                    }, 
                                  icon: const Icon(Icons.add_a_photo)),
                                )
                              ],
                            )
                            : Stack(
                              children: [
                                  Container(
                                    width: 160,
                                    height: 160,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: NetworkImage(User.picture),
                                            fit: BoxFit.cover)),
                                  ),
                                  Positioned(

                                  bottom: -14,
                                  left: 120,
                                  child:IconButton(
                                    onPressed: () async{
                                      final ImagePicker picker = ImagePicker();
                                      final XFile? image = await picker.pickImage(
                                        source: ImageSource.gallery,
                                        maxHeight: 500,
                                        maxWidth: 500,
                                        imageQuality: 40,
                                      );
                                      if (image != null) {
                                        CroppedFile? croppedFile =
                                            await ImageCropper().cropImage(
                                                sourcePath: image.path,
                                                aspectRatio: const CropAspectRatio(
                                                    ratioX: 1, ratioY: 1),
                                            //     aspectRatioPresets: [
                                            //   CropAspectRatioPreset.square
                                            // ],
                                                uiSettings: [
                                              AndroidUiSettings(
                                                  toolbarTitle: 'Cropper',
                                                  toolbarColor: Colors.grey,
                                                  toolbarWidgetColor: Colors.white,
                                                  initAspectRatio:
                                                      CropAspectRatioPreset
                                                          .original,
                                                  lockAspectRatio: false),
                                              IOSUiSettings(
                                                title: 'Cropper',
                                              )
                                            ]);
                                        if (croppedFile != null) {
                                          setState(() {
                                            context.read<UploadPictureBloc>().add(
                                                UploadPicture(
                                                    image.path, User.user_id));
                                          });
                                        }
                                      }
                                    }, 
                                  icon: const Icon(Icons.add_a_photo)),
                                )
                                ],
                            ),
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromARGB(255, 95, 95, 95),
                                width: 1.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  User.Nom,
                                  style: const TextStyle(fontSize: 17),
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: MaterialButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                BlocProvider<SetUserDataBloc>(
                                              create: (context) => SetUserDataBloc(
                                                  myUserRepository: context
                                                      .read<
                                                          AuthentificationBloc>()
                                                      .userRepository),
                                              child: EditNom(User),
                                            ),
                                          ));
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    color:
                                        const Color.fromARGB(255, 95, 95, 95),
                                    child: Text(
                                      AppLocalizations.of(context)!.translate('Edit')!,
                                      style: const TextStyle(
                                          fontSize: 17, color: Colors.white),
                                    ),
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromARGB(255, 95, 95, 95),
                                width: 1.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  User.E_mail,
                                  style: const TextStyle(fontSize: 17),
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: MaterialButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                BlocProvider<SetUserDataBloc>(
                                              create: (context) => SetUserDataBloc(
                                                  myUserRepository: context
                                                      .read<
                                                          AuthentificationBloc>()
                                                      .userRepository),
                                              child: EditEmail(User),
                                            ),
                                          ));
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    color:
                                        const Color.fromARGB(255, 95, 95, 95),
                                    child: Text(
                                      AppLocalizations.of(context)!.translate('Edit')!,
                                      style: const TextStyle(
                                          fontSize: 17, color: Colors.white),
                                    ),
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromARGB(255, 95, 95, 95),
                                width: 1.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  User.Telephone,
                                  style: const TextStyle(fontSize: 17),
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: MaterialButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                BlocProvider<SetUserDataBloc>(
                                              create: (context) => SetUserDataBloc(
                                                  myUserRepository: context
                                                      .read<
                                                          AuthentificationBloc>()
                                                      .userRepository),
                                              child: EditPhone(User),
                                            ),
                                          ));
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    color:
                                        const Color.fromARGB(255, 95, 95, 95),
                                    child: Text(
                                      AppLocalizations.of(context)!.translate('Edit')!,
                                      style: const TextStyle(
                                          fontSize: 17, color: Colors.white),
                                    ),
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromARGB(255, 95, 95, 95),
                                width: 1.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              const Expanded(
                                flex: 3,
                                child: Text(
                                  "Password",
                                  style: TextStyle(fontSize: 17),
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: MaterialButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                BlocProvider<SetUserDataBloc>(
                                              create: (context) => SetUserDataBloc(
                                                  myUserRepository: context
                                                      .read<
                                                          AuthentificationBloc>()
                                                      .userRepository),
                                              child: EditPassword(User),
                                            ),
                                          ));
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    color:
                                        const Color.fromARGB(255, 95, 95, 95),
                                    child: Text(
                                      AppLocalizations.of(context)!.translate('Edit')!,
                                      style: const TextStyle(
                                          fontSize: 17, color: Colors.white),
                                    ),
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 150,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 110,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
