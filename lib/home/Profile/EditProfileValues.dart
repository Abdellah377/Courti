// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kourti_application_1/Blocs/UserBlocs/set_user_data_bloc/set_user_data_bloc.dart';
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
          title: const Text("Edit Nom"),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Form(
                    key: _nomKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 100,),
                        Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.deepPurple.withOpacity(.2)
                          ),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: "Nom",
                            ),
                            controller: nomController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Nom is required";
                              }
                              return null;
                            },
                          )
                        ),
                        const SizedBox(height:10 ,),
                        MaterialButton(
                          onPressed: () {
                            if (_nomKey.currentState!.validate()) {
                              setState(() {
                                User.Nom = nomController.text;
                                context.read<SetUserDataBloc>().add(SetUserData(User));
                              });
                            }
                          },
                          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          color: Colors.lightBlue,
                          child: const Text("Valider"),
                        ),
                      ],
                    )
                  ),
                )
              )
            ]
          ),
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
          title: const Text("Edit E-mail"),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/2,
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
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.deepPurple.withOpacity(.2)
                          ),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: "New Email",
                            ),
                            controller: emailController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "email is required";
                              }
                              return null;
                            },
                          )
                        ),
                        Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.deepPurple.withOpacity(.2)
                          ),
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
                              labelText: "Password",
                            ),
                            controller: passwordController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "password is required";
                              }
                              else if(value!=User.Password){
                                return "password is wrong";
                              }
                              return null;
                            },
                          )
                        ),
                        const SizedBox(height:10 ,),
                          MaterialButton(
                            onPressed: () {
                              if (_emailKey.currentState!.validate()) {
                                setState(() {
                                  context.read<SetUserDataBloc>().add(SetEmail(User,emailController.text));
                                });
                              }
                            },
                            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            color: Colors.lightBlue,
                            child: const Text("Valider"),
                          ),
                      ],
                    )
                  ),
                )
              )
            ]
          ),
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
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          centerTitle: true,
          title: const Text("Edit Phone"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
            Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Form(
                    key: _phoneKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 80,),
                        Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.deepPurple.withOpacity(.2)
                          ),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              prefix: Text("+212"),
                              border: InputBorder.none,
                              labelText: "New number",
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: PhoneController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "phone is required";
                              }
                              return null;
                            },
                          )
                        ),
                        Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.deepPurple.withOpacity(.2)
                          ),
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
                              labelText: "Password",
                            ),
                            controller: passwordController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "password is required";
                              }
                              else if(value != User.Password){
                                return "password is wrong";
                              }
                              return null;
                            },
                          )
                        ),
                        const SizedBox(height:10 ,),
                        MaterialButton(
                          onPressed: () {
                            if (_phoneKey.currentState!.validate()) {
                              setState(() {
                                context.read<SetUserDataBloc>().add(SetPhone("+212${PhoneController.text}"));
                              });
                            }
                          },
                          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          color: Colors.lightBlue,
                          child: const Text("Valider"),
                        ),
                      ],
                    )
                  ),
                )
              )
            ]
          ),
        ),
      ),
    );
  }
}


class EditPassword extends StatefulWidget {
  final MyUsers myUser;
  const EditPassword(this.myUser,{super.key});

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
          title: const Text("Edit Password"),
        ),
        body: Column(children: [
          Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Form(
                  key: _nomKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 40,),
                      Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.deepPurple.withOpacity(.2)
                        ),
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
                            labelText: "Old Password",
                          ),
                          controller: oldPassController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password is required";
                            }
                            else if(value != User.Password){
                              return "Password wrong";
                            }
                            return null;
                          },
                        )
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.deepPurple.withOpacity(.2)
                        ),
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
                            labelText: "New Password",
                          ),
                          controller: newPassController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password is required";
                            }
                            return null;
                          },
                        )
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.deepPurple.withOpacity(.2)
                        ),
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
                            labelText: "Confirmer Password",
                          ),
                          controller: newPassController2,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password is required";
                            }
                            else if(value != newPassController.text){
                              return "Password wrong";
                            }
                            return null;
                          },
                        )
                      ),
                      const SizedBox(height:10 ,),
                        MaterialButton(
                          onPressed: () {
                            if (_nomKey.currentState!.validate()) {
                              setState(() {
                                User.Password = newPassController2.text;
                                context.read<SetUserDataBloc>().add(SetUserData(User));
                              });
                            }
                          },
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          color: Colors.lightBlue,
                          child: const Text("Valider"),
                        ),
                    ],
                  )
                ),
              )
            )
          ]
        ),
      ),
    );
  }
}