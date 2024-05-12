// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kourti_application_1/Blocs/AnnonceClientBlocs/get_annonce_client_bloc/get_annonce_client_bloc.dart' ;
import 'package:kourti_application_1/Blocs/UserBlocs/my_user_bloc/my_user_bloc.dart';
import 'package:kourti_application_1/home/Details_client.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyUserBloc, MyUserState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            backgroundColor: Colors.lightBlue,
            centerTitle: true,
            title: const Text("Profile"),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Information personnelle",
                        style: TextStyle(
                            fontSize: 25,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                            color: Colors.amber, shape: BoxShape.circle),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SizedBox(width: 20, height: 30),
                          Expanded(
                            flex: 10,
                            child: Text(
                              "Nom: ",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 15,
                            child: Text(
                              state.myUser!.Nom,
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 20, height: 30),
                          Expanded(
                            flex: 10,
                            child: Text(
                              "Type: ",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                              flex: 15,
                              child: Text(
                                state.myUser!.Type,
                                style: TextStyle(fontSize: 17),
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 20, height: 30),
                          Expanded(
                            flex: 10,
                            child: Text(
                              "E-mail: ",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                              flex: 15,
                              child: Text(
                                state.myUser!.E_mail,
                                style: TextStyle(fontSize: 17),
                              ))
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 20, height: 30),
                          Expanded(
                            flex: 10,
                            child: Text(
                              "Numéro de telephone: ",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 15,
                            child: Text(
                              state.myUser!.Telephone,
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              TabBarView(children: [
                BlocBuilder<GetAnnonceClientBloc, GetAnnonceClientState>(
                  builder: (context, state) {
                    if (state is GetAnnonceSuccess) {
                      return ListView.builder(
                          itemCount: state.annonces.length,
                          itemBuilder: (context, int i) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 15),
                                      width: 50,
                                      height: 50,
                                      decoration: const BoxDecoration(
                                          color: Colors.amber,
                                          shape: BoxShape.circle),
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.annonces[i].myUser.Nom,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(DateFormat("yyyy-MM-dd HH:mm")
                                            .format(
                                                state.annonces[i].Created_at)),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/abstract-orange-and-white-background-vector3.jpg"),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.shade400,
                                            blurRadius: 5,
                                            offset: Offset(3, 3))
                                      ]),
                                  child: MaterialButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Details_Client(
                                                      state.annonces[i])));
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    left: 10,
                                                    top: 20,
                                                    bottom: 10),
                                                child: Center(
                                                  child: Text(
                                                    state.annonces[i].Titre,
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 5, top: 10, right: 5),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Center(
                                                    child: Text(
                                                  "Ville départ:",
                                                  style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                  ),
                                                )),
                                              ),
                                              Expanded(
                                                child: Center(
                                                    child: Text(
                                                  "Ville d'arrivé:",
                                                  style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                  ),
                                                )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Center(
                                                  child: Text(state.annonces[i]
                                                      .Ville_depart)),
                                            ),
                                            Expanded(
                                              child: Center(
                                                  child: Text(state.annonces[i]
                                                      .Ville_darrive)),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 5, top: 10, right: 5),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Center(
                                                    child: Text(
                                                  "Date depart:",
                                                  style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                  ),
                                                )),
                                              ),
                                              Expanded(
                                                child: Center(
                                                    child: Text(
                                                  "Date d'arrivé:",
                                                  style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                  ),
                                                )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Center(
                                                    child: Text(DateFormat(
                                                            "yyyy-MM-dd HH:mm")
                                                        .format(state
                                                            .annonces[i]
                                                            .Date_depart)))),
                                            Expanded(
                                                child: Center(
                                                    child: Text(DateFormat(
                                                            "yyyy-MM-dd HH:mm")
                                                        .format(state
                                                            .annonces[i]
                                                            .Date_darrive))))
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 5, top: 10, right: 5),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Center(
                                                    child: Text("Marcendise:",
                                                        style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                        ))),
                                              ),
                                              Expanded(
                                                child: Center(
                                                    child: Text(
                                                  "charge:",
                                                  style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                  ),
                                                )),
                                              ),
                                              Expanded(
                                                child: Center(
                                                    child: Text(
                                                  "Prix:",
                                                  style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                  ),
                                                )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Center(
                                                  child: Text(
                                                state.annonces[i]
                                                    .TypeMarchandise,
                                                maxLines: 2,
                                              )),
                                            ),
                                            Expanded(
                                              child: Center(
                                                  child: Text(
                                                      "${state.annonces[i].tonnage}")),
                                            ),
                                            Expanded(
                                              child: Center(
                                                  child: Text(
                                                      "${state.annonces[i].prix}")),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          });
                    } else if (state is GetAnnonceLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return const Center(
                        child: Text(
                          "Error!!!",
                          style: TextStyle(fontSize: 20),
                        ),
                      );
                    }
                  },
                ),
              ])
            ],
          ),
        );
      },
    );
  }
}
