// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kourti_application_1/Blocs/UserBlocs/authentification_bloc/authentification_bloc.dart';
import 'package:kourti_application_1/Blocs/UserBlocs/set_user_data_bloc/set_user_data_bloc.dart';
import 'package:kourti_application_1/Blocs/UserBlocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:kourti_application_1/app_language_provider.dart';
import 'package:kourti_application_1/app_localizations.dart';
import 'package:kourti_application_1/auth/otp.dart';
import 'package:provider/provider.dart';
import 'package:user_repository/user_repository.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final password2Controller = TextEditingController();
  final emailController = TextEditingController();
  final numTelController = TextEditingController();
  late String TypeController = 'Client';

  List<String> listOfValue = ['Client', 'Transporteur'];

  bool signUpRequired = false;

  //A bool variable for show and hide password
  bool isVisible = false;

  //Here is our bool variable
  bool isLoginTrue = false;

  //We have to create global key for our form
  final _formKey = GlobalKey<FormState>();

  late AppLanguageProvider appLanguage;

  @override
  Widget build(BuildContext context) {
    appLanguage = Provider.of<AppLanguageProvider>(context);
    
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          setState(() {
            signUpRequired = false;
          });
        } else if (state is SignUpLoading) {
          setState(() {
            signUpRequired = true;
          });
        } else if (state is SignUpFailure) {
          return;
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)!.translate("S'inscrire")!,
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            margin: EdgeInsets.only(top: 10.0, bottom: 50.0),
            width: double.infinity,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context)!.translate("créez votre compte, c'est gratuit")!,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Image.asset(
                    "assets/images/person.png",
                    width: double.infinity,
                    height: 250,
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.deepPurple.withOpacity(.2)),
                    child: TextFormField(
                      controller: usernameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppLocalizations.of(context)!.translate("Name is required")!;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.account_circle_rounded),
                        border: InputBorder.none,
                        hintText: AppLocalizations.of(context)!.translate("Nom")!,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.deepPurple.withOpacity(.2)),
                    child: TextFormField(
                      controller: numTelController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppLocalizations.of(context)!.translate('Numero telephone is requireds')!;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.phone),
                        border: InputBorder.none,
                        prefix: Text("+212 "),
                        hintText: AppLocalizations.of(context)!.translate('Numéro de telephone')!,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.deepPurple.withOpacity(.2)),
                    child: TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppLocalizations.of(context)!.translate('Email is required')!;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.email),
                        border: InputBorder.none,
                        hintText: AppLocalizations.of(context)!.translate('E-mail')!,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.deepPurple.withOpacity(.2)),
                    child: DropdownButtonFormField(
                      value: TypeController,
                      hint: Text(
                        AppLocalizations.of(context)!.translate('choose one')!,
                      ),
                      isExpanded: true,
                      onChanged: (value) {
                        setState(() {
                          TypeController = value!;
                        });
                      },
                      onSaved: (value) {
                        setState(() {
                          TypeController = value!;
                        });
                      },
                      validator: (String? value) {
                        if (value == '') {
                          return "can't empty";
                        } else {
                          return null;
                        }
                      },
                      items: listOfValue.map((String val) {
                        return DropdownMenuItem(
                          value: val,
                          child: Text(val),
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.deepPurple.withOpacity(.2)),
                    child: TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppLocalizations.of(context)!.translate('password is required')!;
                        }
                        return null;
                      },
                      obscureText: !isVisible,
                      decoration: InputDecoration(
                          icon: const Icon(Icons.lock),
                          border: InputBorder.none,
                          hintText: AppLocalizations.of(context)!.translate('mot de passe')!,
                          suffixIcon: IconButton(
                              onPressed: () {
                                //In here we will create a click to show and hide the password a toggle button
                                setState(() {
                                  //toggle button
                                  isVisible = !isVisible;
                                });
                              },
                              icon: Icon(isVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off))),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.deepPurple.withOpacity(.2)),
                    child: TextFormField(
                      controller: password2Controller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppLocalizations.of(context)!.translate('password is required')!;
                        } else if (value != passwordController.text) {
                          return AppLocalizations.of(context)!.translate('password is wrong')!;
                        }
                        return null;
                      },
                      obscureText: !isVisible,
                      decoration: InputDecoration(
                          icon: const Icon(Icons.lock),
                          border: InputBorder.none,
                          hintText: AppLocalizations.of(context)!.translate('confirmer mot de passe')!,
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                              icon: Icon(isVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off))),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  !signUpRequired
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Container(
                            padding: EdgeInsets.only(top: 3, left: 3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              border: Border(
                                bottom: BorderSide(color: Colors.black),
                                top: BorderSide(color: Colors.black),
                                left: BorderSide(color: Colors.black),
                                right: BorderSide(color: Colors.black),
                              ),
                            ),
                            child: MaterialButton(
                              minWidth: double.infinity,
                              height: 60,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  MyUsers myuser = MyUsers.empty;
                                  myuser.E_mail = emailController.text;
                                  myuser.Nom = usernameController.text;
                                  myuser.Type = TypeController;
                                  myuser.Password = passwordController.text;
                                  myuser.Telephone = "+212${numTelController.text}";
                                  setState(() {
                                    context
                                        .read<SignUpBloc>()
                                        .add(phoneAuth(myuser.Telephone));
                                  });

                                 Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                        MultiBlocProvider(
                                          providers: [
                                            BlocProvider<SetUserDataBloc>(
                                              create: (context) => SetUserDataBloc(
                                                  myUserRepository: context.read<AuthentificationBloc>().userRepository),
                                                ),
                                            BlocProvider<SignUpBloc>(
                                              create: (context) => SignUpBloc(
                                                  context.read<AuthentificationBloc>().userRepository),
                                                ),
                                              ],
                                            child: Otp(myuser, true),
                                        )
                                      )
                                    );
                                }
                              },
                              color: Color(0xff0095FF),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Text(
                                AppLocalizations.of(context)!.translate('Entrer')!,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      : const CircularProgressIndicator()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
