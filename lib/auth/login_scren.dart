// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kourti_application_1/Blocs/UserBlocs/authentification_bloc/authentification_bloc.dart';
import 'package:kourti_application_1/Blocs/UserBlocs/log_in_bloc/log_in_bloc.dart';
import 'package:kourti_application_1/auth/login.dart';

class login_screen extends StatelessWidget {
  const login_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LogInBloc>(
      create: (context) => LogInBloc(
        context.read<AuthentificationBloc>().userRepository
        ),
        child: const Login(),
      );
  }
}