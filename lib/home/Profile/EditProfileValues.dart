// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kourti_application_1/Blocs/UserBlocs/authentification_bloc/authentification_bloc.dart';
import 'package:kourti_application_1/Blocs/UserBlocs/set_user_data_bloc/set_user_data_bloc.dart';
import 'package:kourti_application_1/Blocs/UserBlocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:kourti_application_1/app_localizations.dart';
import 'package:kourti_application_1/auth/otp.dart';
import 'package:user_repository/user_repository.dart';

class EditNom extends StatefulWidget {
  final MyUsers myUser;
  const EditNom(this.myUser, {super.key});

  @override
  State<EditNom> createState() => _EditNomState();
}

class _EditNomState extends State<EditNom> {
  late MyUsers User;
  var nomController = TextEditingController();
  final _nomKey = GlobalKey<FormState>();

  @override
  void initState() {
    User = widget.myUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SetUserDataBloc, SetUserDataState>(
      listener: (context, state) async {
        if (state is SetUserDataSuccess) {
          await Future.delayed(Duration(seconds: 1));
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          centerTitle: true,
          title: Text(AppLocalizations.of(context)!.translate('Edit Nom')!)
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Form(
                      key: _nomKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 100,
                          ),
                          Container(
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.deepPurple.withOpacity(.2)),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: AppLocalizations.of(context)!.translate('Nom')!,
                                ),
                                controller: nomController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppLocalizations.of(context)!.translate("Name is required")!;
                                  }
                                  return null;
                                },
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          MaterialButton(
                            onPressed: () {
                              if (_nomKey.currentState!.validate()) {
                                setState(() {
                                  User.Nom = nomController.text;
                                  context
                                      .read<SetUserDataBloc>()
                                      .add(SetUserData(User));
                                });
                              }
                            },
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color: Colors.lightBlue,
                            child: Text(AppLocalizations.of(context)!.translate("Entrer")!),
                          ),
                        ],
                      )),
                ))
          ]),
        ),
      ),
    );
  }
}

class EditEmail extends StatefulWidget {
  final MyUsers myUser;
  const EditEmail(this.myUser, {super.key});

  @override
  State<EditEmail> createState() => _EditEmailState();
}

class _EditEmailState extends State<EditEmail> {
  late MyUsers User;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _emailKey = GlobalKey<FormState>();
  bool isVisible = false;

  @override
  void initState() {
    User = widget.myUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SetUserDataBloc, SetUserDataState>(
      listener: (context, state) {
        if (state is SetUserDataSuccess) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          centerTitle: true,
          title: Text(AppLocalizations.of(context)!.translate('Edit E-mail')!,),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Form(
                      key: _emailKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 80),
                          Container(
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.deepPurple.withOpacity(.2)),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: AppLocalizations.of(context)!.translate('New Email')!,
                                ),
                                controller: emailController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppLocalizations.of(context)!.translate('Email is required')!;
                                  }
                                  return null;
                                },
                              )),
                          Container(
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.deepPurple.withOpacity(.2)),
                              child: TextFormField(
                                obscureText: !isVisible,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isVisible = !isVisible;
                                        });
                                      },
                                      icon: Icon(isVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off)),
                                  border: InputBorder.none,
                                  labelText: AppLocalizations.of(context)!.translate('mot de passe')!,
                                ),
                                controller: passwordController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppLocalizations.of(context)!.translate('password is required')!;
                                  } else if (value != User.Password) {
                                    return AppLocalizations.of(context)!.translate('password is wrong')!;
                                  }
                                  return null;
                                },
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          MaterialButton(
                            onPressed: () {
                              if (_emailKey.currentState!.validate()) {
                                setState(() {
                                  context.read<SetUserDataBloc>().add(
                                      SetEmail(User, emailController.text));
                                });
                              }
                            },
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color: Colors.lightBlue,
                            child: Text(AppLocalizations.of(context)!.translate('Entrer')!,)
                          ),
                        ],
                      )),
                ))
          ]),
        ),
      ),
    );
  }
}

class EditPhone extends StatefulWidget {
  final MyUsers myUser;
  const EditPhone(this.myUser, {super.key});

  @override
  State<EditPhone> createState() => _EditPhoneState();
}

class _EditPhoneState extends State<EditPhone> {
  late MyUsers User;
  final PhoneController = TextEditingController();
  final passwordController = TextEditingController();
  final _phoneKey = GlobalKey<FormState>();
  bool isVisible = false;

  @override
  void initState() {
    User = widget.myUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SetUserDataBloc, SetUserDataState>(
      listener: (context, state) {
        if (state is SetUserDataSuccess) {
          // Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          centerTitle: true,
          title: Text(AppLocalizations.of(context)!.translate('Edit Phone')!,),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Form(
                      key: _phoneKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 80,
                          ),
                          Container(
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.deepPurple.withOpacity(.2)),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  prefix: Text("+212"),
                                  border: InputBorder.none,
                                  labelText: AppLocalizations.of(context)!.translate('New number')!,
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                controller: PhoneController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppLocalizations.of(context)!.translate('Numero telephone is requireds')!;
                                  }
                                  return null;
                                },
                              )),
                          Container(
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.deepPurple.withOpacity(.2)),
                              child: TextFormField(
                                obscureText: !isVisible,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isVisible = !isVisible;
                                        });
                                      },
                                      icon: Icon(isVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off)),
                                  border: InputBorder.none,
                                  labelText: AppLocalizations.of(context)!.translate('mot de passe')!,
                                ),
                                controller: passwordController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppLocalizations.of(context)!.translate('password is required')!;
                                  } else if (value != User.Password) {
                                    return AppLocalizations.of(context)!.translate('password is wrong')!;
                                  }
                                  return null;
                                },
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          MaterialButton(
                            onPressed: () {
                              if (_phoneKey.currentState!.validate()) {
                                setState(() {
                                  context.read<SetUserDataBloc>().add(SetPhone(
                                    User, "+212${PhoneController.text}"));
                                });
                                User.Telephone = "+212${PhoneController.text}";
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
                                            child: Otp(User, false),
                                        )
                                      )
                                    );
                              }
                            },
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color: Colors.lightBlue,
                            child: Text(AppLocalizations.of(context)!.translate('Entrer')!)
                          ),
                        ],
                      )),
                ))
          ]),
        ),
      ),
    );
  }
}

class EditPassword extends StatefulWidget {
  final MyUsers myUser;
  const EditPassword(this.myUser, {super.key});

  @override
  State<EditPassword> createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  late MyUsers User;
  var newPassController = TextEditingController();
  var newPassController2 = TextEditingController();
  var oldPassController = TextEditingController();
  final _nomKey = GlobalKey<FormState>();
  bool isVisible1 = false;
  bool isVisible2 = false;
  bool isVisible3 = false;

  @override
  void initState() {
    User = widget.myUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SetUserDataBloc, SetUserDataState>(
      listener: (context, state) {
        if (state is SetUserDataSuccess) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          centerTitle: true,
          title: Text(AppLocalizations.of(context)!.translate('Edit Password')!),
        ),
        body: Column(children: [
          Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Form(
                    key: _nomKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.deepPurple.withOpacity(.2)),
                            child: TextFormField(
                              obscureText: !isVisible1,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isVisible1 = !isVisible1;
                                      });
                                    },
                                    icon: Icon(isVisible1
                                        ? Icons.visibility
                                        : Icons.visibility_off)),
                                border: InputBorder.none,
                                labelText: AppLocalizations.of(context)!.translate('Old Password')!,
                              ),
                              controller: oldPassController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return AppLocalizations.of(context)!.translate('password is required')!;
                                } else if (value != User.Password) {
                                  return AppLocalizations.of(context)!.translate('password is wrong')!;
                                }
                                return null;
                              },
                            )),
                        Container(
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.deepPurple.withOpacity(.2)),
                            child: TextFormField(
                              obscureText: !isVisible2,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isVisible2 = !isVisible2;
                                      });
                                    },
                                    icon: Icon(isVisible2
                                        ? Icons.visibility
                                        : Icons.visibility_off)),
                                border: InputBorder.none,
                                labelText: AppLocalizations.of(context)!.translate('New Password')!
                              ),
                              controller: newPassController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return AppLocalizations.of(context)!.translate('password is required')!;
                                }
                                return null;
                              },
                            )),
                        Container(
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.deepPurple.withOpacity(.2)),
                            child: TextFormField(
                              obscureText: !isVisible3,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isVisible3 = !isVisible3;
                                      });
                                    },
                                    icon: Icon(isVisible3
                                        ? Icons.visibility
                                        : Icons.visibility_off)),
                                border: InputBorder.none,
                                labelText: AppLocalizations.of(context)!.translate('confirmer mot de passe')!,
                              ),
                              controller: newPassController2,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return AppLocalizations.of(context)!.translate('password is required')!;
                                } else if (value != newPassController.text) {
                                  return AppLocalizations.of(context)!.translate('password is wrong')!;
                                }
                                return null;
                              },
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        MaterialButton(
                          onPressed: () {
                            if (_nomKey.currentState!.validate()) {
                              setState(() {
                                context.read<SetUserDataBloc>().add(
                                    setPassword(User, newPassController2.text));
                              });
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: Colors.lightBlue,
                          child: Text(AppLocalizations.of(context)!.translate('Entrer')!,),
                        ),
                      ],
                    )),
              ))
        ]),
      ),
    );
  }
}
