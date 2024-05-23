// ignore_for_file: unused_import, prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';
import 'package:kourti_application_1/Blocs/UserBlocs/authentification_bloc/authentification_bloc.dart';
import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';

import 'package:kourti_application_1/auth/otp.dart';
import 'package:kourti_application_1/auth/verification.dart';
import 'package:kourti_application_1/auth/login.dart';
import 'package:kourti_application_1/auth/Singnup.dart';
import 'package:kourti_application_1/auth/welcome_page.dart';
import 'package:kourti_application_1/home/Annonces/Annonce.dart';
import 'package:kourti_application_1/home/Annonces/Details_client.dart';

import 'home/app_view.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp(FirebaseUserRepo()));
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  const MyApp(this.userRepository, {super.key});


  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthentificationBloc>(
      create: (context) => AuthentificationBloc(
        userRepository: userRepository
      ),
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/" ,
      routes: {
        "/" : (context) => Appview(),
        "/Welcome_page" : (context) =>  Welcome_page(),
        "/login" :(context) =>  Login(),
        "/signup" :(context) =>  Signup(),
        "/verification" :(context) => verification(),
        // "/otp" :(context) =>  Otp(),
        "/Annonce" : (context) => Annonce(),
      },
    )
    );
}

}