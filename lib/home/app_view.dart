// ignore_for_file: prefer_const_constructors

import 'package:annonce_client_repository/annonce_client_repository.dart';
import 'package:annonce_transporteur_repository/annonce_transporteur_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kourti_application_1/Blocs/AnnonceClientBlocs/get_annonce_client_bloc/get_annonce_client_bloc.dart';
import 'package:kourti_application_1/Blocs/AnnonceTransporteurBlocs/get_annonce_transporteur_bloc/get_annonce_transporteur_bloc.dart';
import 'package:kourti_application_1/Blocs/UserBlocs/authentification_bloc/authentification_bloc.dart';
import 'package:kourti_application_1/Blocs/UserBlocs/log_in_bloc/log_in_bloc.dart';
import 'package:kourti_application_1/home/Annonce.dart';
import 'package:kourti_application_1/Blocs/UserBlocs/my_user_bloc/my_user_bloc.dart';
import '../auth/welcome_page.dart';

class Appview extends StatelessWidget {
  const Appview({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthentificationBloc, AuthentificationState>(
        builder: (context, state) {
          if(state.status == AuthentificationStatus.authentificated){
            return MultiBlocProvider(
              providers: [
                BlocProvider<LogInBloc>(
                  create: (context) =>
                      LogInBloc(context.read<AuthentificationBloc>().userRepository),
                ),
                BlocProvider<MyUserBloc>(
                  create: (context) => MyUserBloc(
                    myUserRepository: context.read<AuthentificationBloc>().userRepository
                  )..add(GetMyUser(myUserid: context.read<AuthentificationBloc>().state.user!.user_id)),
                ),
                BlocProvider<GetAnnonceClientBloc>(
                  create: (context) => GetAnnonceClientBloc(
                    annonceRepo: FirebaseAnnonceClientRepo())..add(GetAnnonceClient())
                ),
                BlocProvider<GetAnnonceTransporteurBloc>(
                  create: (context) => GetAnnonceTransporteurBloc(
                    annonceRepo: FirebaseAnnonceTransporteurRepo())..add(GetAnnonceTransporteur())
                ),
              ],
              child: Annonce(),
            );
          }
          else if(state.status == AuthentificationStatus.unknown){
             return  Center(
              child: CircularProgressIndicator(),
              );
          }
          else{
            return Welcome_page();
          }
        },
      ),
    );
  }
}