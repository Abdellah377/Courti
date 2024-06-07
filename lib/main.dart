// ignore_for_file: unused_import, prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kourti_application_1/app_language_provider.dart';
import 'package:kourti_application_1/app_localizations.dart';
import 'package:kourti_application_1/app_localizations_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
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
  AppLanguageProvider appLanguage = AppLanguageProvider();
  await appLanguage.fetchLocale();
  runApp(MyApp(FirebaseUserRepo(), appLanguage: appLanguage));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  AppLanguageProvider? appLanguage;
  MyApp(this.userRepository, {super.key, required this.appLanguage});


  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthentificationBloc>(
      create: (context) => AuthentificationBloc(
        userRepository: userRepository
      ),
      child: ChangeNotifierProvider(
        create: (context) => appLanguage,
        child: Consumer<AppLanguageProvider>(
          builder: (context, model, child) {
            return MaterialApp(
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
            locale: model.appLocal,
            supportedLocales: const [Locale('en', 'US'), Locale('fr','FR'), Locale('ar','MA')],
            localizationsDelegates: const[
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
            );
          }
        ),
      )
    );
}

}