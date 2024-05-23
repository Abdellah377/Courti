// ignore_for_file: library_prefixes, file_names

import 'package:annonce_client_repository/annonce_client_repository.dart';
import 'package:annonce_transporteur_repository/annonce_transporteur_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:kourti_application_1/Blocs/AnnonceClientBlocs/get_annonce_client_bloc/get_annonce_client_bloc.dart'
    as GetAnnonceClient;
import 'package:kourti_application_1/Blocs/AnnonceTransporteurBlocs/get_annonce_transporteur_bloc/get_annonce_transporteur_bloc.dart'
    as GetAnnonceTransporteur;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kourti_application_1/home/Profile/MyProfile.dart';
import 'package:user_repository/user_repository.dart';

class MyProfile_Screen extends StatelessWidget {
  final MyUsers myUser;
  const MyProfile_Screen(this.myUser, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<GetAnnonceClient.GetAnnonceClientBloc>(
          create: (context) => GetAnnonceClient.GetAnnonceClientBloc(
              annonceRepo: FirebaseAnnonceClientRepo())
            ..add(GetAnnonceClient.GetAnnonceClientByUser(myUser))),
      BlocProvider<GetAnnonceTransporteur.GetAnnonceTransporteurBloc>(
          create: (context) => GetAnnonceTransporteur
              .GetAnnonceTransporteurBloc(
                  annonceRepo: FirebaseAnnonceTransporteurRepo())
            ..add(GetAnnonceTransporteur.GetAnnonceTransporteurByUser(myUser))),
    ], child: MyProfile(myUser));
  }
}
