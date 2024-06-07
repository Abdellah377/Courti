import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kourti_application_1/Blocs/UserBlocs/authentification_bloc/authentification_bloc.dart';
import 'package:kourti_application_1/Blocs/UserBlocs/get_users_bloc/get_users_bloc.dart';
import 'package:kourti_application_1/home/Users/SearchUsers.dart';

class SearchUser_Screen extends StatelessWidget {
  final String arg;
  final String value;

  const SearchUser_Screen(this.arg, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetUsersBloc(
        myUserRepository: context.read<AuthentificationBloc>().userRepository
        )..add(GetUsersByArg(arg, value)),
      child: SearchUser(),
    );
  }
}