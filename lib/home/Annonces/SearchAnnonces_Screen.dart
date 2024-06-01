// ignore_for_file: camel_case_types, file_names

import 'package:annonce_client_repository/annonce_client_repository.dart';
import 'package:annonce_transporteur_repository/annonce_transporteur_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kourti_application_1/Blocs/AnnonceClientBlocs/get_annonce_client_bloc/get_annonce_client_bloc.dart';
import 'package:kourti_application_1/Blocs/AnnonceTransporteurBlocs/get_annonce_transporteur_bloc/get_annonce_transporteur_bloc.dart';
import 'package:kourti_application_1/Blocs/UserBlocs/authentification_bloc/authentification_bloc.dart';
import 'package:kourti_application_1/Blocs/UserBlocs/get_user_by_id_bloc/get_user_by_id_bloc.dart';
import 'package:kourti_application_1/home/Annonces/SreachAnnonces.dart';

class SearchAnnonce_Screen extends StatelessWidget {
  final String arg;
  final String argValue;
  final String type;
  const SearchAnnonce_Screen(this.arg, this.argValue, this.type, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetUserByIdBloc>(
          create: (context) => GetUserByIdBloc(
            myUserRepository: context.read<AuthentificationBloc>().userRepository
            )
          ),
        BlocProvider<GetAnnonceClientBloc>(
          create: (context) => GetAnnonceClientBloc(annonceRepo: FirebaseAnnonceClientRepo())
          ..add(GetAnnonceClientByArgs(arg, argValue))
          ),
          BlocProvider<GetAnnonceTransporteurBloc>(
            create: (context) => GetAnnonceTransporteurBloc(annonceRepo: FirebaseAnnonceTransporteurRepo())
            ..add(GetAnnonceTransporteurByArgs(arg, argValue))
            ),
      ],
      child: SearchAnnonce(type),
    );
  }
}