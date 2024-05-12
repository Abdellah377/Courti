// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kourti_application_1/Blocs/UserBlocs/authentification_bloc/authentification_bloc.dart';
import 'package:kourti_application_1/Blocs/UserBlocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:kourti_application_1/auth/Singnup.dart';

class Signup_screen extends StatelessWidget {
  const Signup_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpBloc>(
      create: (context) => SignUpBloc(
        context.read<AuthentificationBloc>().userRepository
        ),
        child: const Signup(),
    );
  }
}