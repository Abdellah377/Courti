// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kourti_application_1/Blocs/UserBlocs/log_in_bloc/log_in_bloc.dart';
import 'package:kourti_application_1/auth/Signup_screen.dart';
import 'package:kourti_application_1/home/app_view.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Login> {
  final Email = TextEditingController();
  final Num_tel = TextEditingController();
  final password_num = TextEditingController();
  final password_mail = TextEditingController();

  String? _errorMsg1;
  String? _errorMsg2;

  //A bool variable for show and hide password
  bool isVisible = false;

  //Here is our bool variable
  bool LoginRequired = false;
  bool success = true;

  //We have to create global key for our form
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogInBloc, LogInState>(
      listener: (context, state) {
        if (state is LogInSuccess) {
          setState(() {
            success = true;
            LoginRequired = false;
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Appview()));
          });
        } else if (state is LogInLoading) {
          setState(() {
            LoginRequired = true;
          });
        } else if (state is LogInFailure) {
          setState(() {
            success = false;
            LoginRequired = false;
            _errorMsg1 = "Invalid email ou password";
            _errorMsg2 = "Invalid num ou password";
          });
        }
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0.0,
            title: Text(
              "Se connecter",
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
            bottom: TabBar(
              tabs: const [
                Tab(
                  icon: Icon(Icons.email),
                  text: "E-mail",
                ),
                Tab(
                  icon: Icon(Icons.phone),
                  text: "Num Tel",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              "Bienvenue chez courti!",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Connectez-vous à votre compte",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              Form(
                                key: _formKey1,
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(8),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 6),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.deepPurple
                                              .withOpacity(.2)),
                                      child: TextFormField(
                                        controller: Email,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return _errorMsg1;
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                          // icon: Icon(Icons.phone),
                                          icon: Icon(Icons.email),
                                          border: InputBorder.none,
                                          // hintText: "N° Telephone",
                                          hintText: "E-mail",
                                        ),
                                      ),
                                    ),
                                    //Password field
                                    Container(
                                      margin: const EdgeInsets.all(8),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 6),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.deepPurple
                                              .withOpacity(.2)),
                                      child: TextFormField(
                                        controller: password_mail,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return _errorMsg1;
                                          }
                                          return null;
                                        },
                                        obscureText: !isVisible,
                                        decoration: InputDecoration(
                                            icon:
                                                const Icon(Icons.vpn_key_sharp),
                                            border: InputBorder.none,
                                            hintText: "mot de passe",
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

                                    !success
                                        ? Text(
                                            "Incorrect E-mail or password",
                                            style: TextStyle(color: Colors.red),
                                          )
                                        : Text(""),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        !LoginRequired
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
                                      print(success);
                                      if (_formKey1.currentState!.validate()) {
                                        context.read<LogInBloc>().add(
                                            LogInMail(Email.text,
                                                password_mail.text));
                                        print(
                                            "LOOOOOOOOOOOOOOOOOOOOOOOOOOGIN 2222 $LoginRequired");

                                        // Navigator.push(context, MaterialPageRoute(builder: (context) => Appview()));
                                      }
                                    },
                                    color: Color(0xff0095FF),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Text(
                                      "Entrer",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const CircularProgressIndicator(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Vous n'avez pas de compte?"),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Signup_screen()));
                              },
                              child: const Text(
                                "S'inscrire",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 100),
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/images/background.png"),
                                fit: BoxFit.fitHeight),
                          ),
                        ),
                      ],
                    ))
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              "Bienvenue chez courti!",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Connectez-vous à votre compte",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              Form(
                                key: _formKey2,
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(8),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 6),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.deepPurple
                                              .withOpacity(.2)),
                                      child: TextFormField(
                                        controller: Num_tel,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return _errorMsg2;
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                          // icon: Icon(Icons.phone),
                                          icon: Icon(Icons.phone),
                                          border: InputBorder.none,
                                          // hintText: "N° Telephone",
                                          hintText: "Num Tel",
                                        ),
                                      ),
                                    ),
                                    //Password field
                                    Container(
                                      margin: const EdgeInsets.all(8),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 6),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.deepPurple
                                              .withOpacity(.2)),
                                      child: TextFormField(
                                        controller: password_num,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return _errorMsg2;
                                          }
                                          return null;
                                        },
                                        obscureText: !isVisible,
                                        decoration: InputDecoration(
                                            icon:
                                                const Icon(Icons.vpn_key_sharp),
                                            border: InputBorder.none,
                                            hintText: "mot de passe",
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
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        !LoginRequired
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
                                      if (_formKey2.currentState!.validate()) {
                                        context.read<LogInBloc>().add(
                                            LogInPhone(Num_tel.text,
                                                password_num.text));
                                        // if (LoginRequired == false) {
                                        //   Navigator.push(context, MaterialPageRoute(builder: (context) => Appview()));
                                        // }
                                      }
                                    },
                                    color: Color(0xff0095FF),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Text(
                                      "Entrer",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const CircularProgressIndicator(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Vous n'avez pas de compte?"),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Signup_screen()));
                              },
                              child: const Text(
                                "S'inscrire",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 100),
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/images/background.png"),
                                fit: BoxFit.fitHeight),
                          ),
                        ),
                      ],
                    ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
