// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kourti_application_1/Blocs/bloc/authentification_bloc.dart';
import 'package:kourti_application_1/home/Annonce.dart';

import '../auth/welcome_page.dart';

class Appview extends StatelessWidget {
  const Appview({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthentificationBloc, AuthentificationState>(
        builder: (context, state) {
          if(state.status == AuthentificationStatus.authentificated){
            return Welcome_page();
          }else{
            return Annonce();
          }
        },
      ),
    );
  }
}