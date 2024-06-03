import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kourti_application_1/Blocs/AnnonceClientBlocs/get_annonce_client_bloc/get_annonce_client_bloc.dart'
    as GetAnnonceClient;
import 'package:kourti_application_1/Blocs/AnnonceTransporteurBlocs/get_annonce_transporteur_bloc/get_annonce_transporteur_bloc.dart'
    as GetAnnonceTransporteur;
import 'package:kourti_application_1/Blocs/UserBlocs/get_user_by_id_bloc/get_user_by_id_bloc.dart';
import 'package:kourti_application_1/home/Annonces/Details_Transporteur.dart';
import 'package:kourti_application_1/home/Annonces/Details_client.dart';
class SearchAnnonce extends StatelessWidget {
  final String type;
  const SearchAnnonce(this.type,{super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        title: const Text("Annonces"),
        ),
      body: Builder(
        builder: (context) {
          if (type == "Client") {
            return BlocBuilder<GetAnnonceClient.GetAnnonceClientBloc,
                  GetAnnonceClient.GetAnnonceClientState>(
                builder: (context, state) {
                  if (state is GetAnnonceClient.GetAnnonceSuccess) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: state.annonces.length,
                                itemBuilder: (context, int i) {
                                  final annonce = state.annonces[i];
                                  context.read<GetUserByIdBloc>().add(
                                      (GetUserById(myUserid: annonce.userId)));
                                  return BlocBuilder<GetUserByIdBloc, GetUserByIdState>(
                                    builder: (context, state) {
                                      if (state is GetUserByIdSuccess) {
                                          return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 20),
                                            Row(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 15),
                                                  width: 50,
                                                  height: 50,
                                                  decoration: const BoxDecoration(
                                                      color: Colors.amber,
                                                      shape: BoxShape.circle),
                                                ),
                                                const SizedBox(width: 10),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      state.myUser.Nom,
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(DateFormat(
                                                            "yyyy-MM-dd HH:mm")
                                                        .format(
                                                            annonce.Created_at)),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Container(
                                              margin: const EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 20),
                                              decoration: BoxDecoration(
                                                  image: const DecorationImage(
                                                    image: AssetImage(
                                                        "assets/images/abstract-orange-and-white-background-vector3.jpg"),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color:
                                                            Colors.grey.shade400,
                                                        blurRadius: 5,
                                                        offset:
                                                            const Offset(3, 3))
                                                  ]),
                                              child: MaterialButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Details_Client(
                                                                  annonce,
                                                                  state
                                                                      .myUser)));
                                                },
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 10,
                                                                    top: 20,
                                                                    bottom: 10),
                                                            child: Center(
                                                              child: Text(
                                                                annonce.Titre,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 20,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 5,
                                                              top: 10,
                                                              right: 5),
                                                      child: const Row(
                                                        children: [
                                                          Expanded(
                                                            child: Center(
                                                                child: Text(
                                                              "Ville départ:",
                                                              style: TextStyle(
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline,
                                                              ),
                                                            )),
                                                          ),
                                                          Expanded(
                                                            child: Center(
                                                                child: Text(
                                                              "Ville d'arrivé:",
                                                              style: TextStyle(
                                                                decoration:
                                                                    TextDecoration
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
                                                              child: Text(annonce
                                                                  .Ville_depart)),
                                                        ),
                                                        Expanded(
                                                          child: Center(
                                                              child: Text(annonce
                                                                  .Ville_darrive)),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 5,
                                                              top: 10,
                                                              right: 5),
                                                      child: const Row(
                                                        children: [
                                                          Expanded(
                                                            child: Center(
                                                                child: Text(
                                                              "Date depart:",
                                                              style: TextStyle(
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline,
                                                              ),
                                                            )),
                                                          ),
                                                          Expanded(
                                                            child: Center(
                                                                child: Text(
                                                              "Date d'arrivé:",
                                                              style: TextStyle(
                                                                decoration:
                                                                    TextDecoration
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
                                                                    .format(annonce
                                                                        .Date_depart)))),
                                                        Expanded(
                                                            child: Center(
                                                                child: Text(DateFormat(
                                                                        "yyyy-MM-dd HH:mm")
                                                                    .format(annonce
                                                                        .Date_darrive))))
                                                      ],
                                                    ),
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 5,
                                                              top: 10,
                                                              right: 5),
                                                      child: const Row(
                                                        children: [
                                                          Expanded(
                                                            child: Center(
                                                                child: Text(
                                                                    "Marcendise:",
                                                                    style:
                                                                        TextStyle(
                                                                      decoration:
                                                                          TextDecoration
                                                                              .underline,
                                                                    ))),
                                                          ),
                                                          Expanded(
                                                            child: Center(
                                                                child: Text(
                                                              "Tonnage:",
                                                              style: TextStyle(
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline,
                                                              ),
                                                            )),
                                                          ),
                                                          Expanded(
                                                            child: Center(
                                                                child: Text(
                                                              "Prix:",
                                                              style: TextStyle(
                                                                decoration:
                                                                    TextDecoration
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
                                                            annonce
                                                                .TypeMarchandise,
                                                            maxLines: 2,
                                                          )),
                                                        ),
                                                        Expanded(
                                                          child: Center(
                                                              child: Text(
                                                                  "${annonce.tonnage}")),
                                                        ),
                                                        Expanded(
                                                          child: Center(
                                                              child: Text(
                                                                  "${annonce.prix}")),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      }else{
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } 
                                    },
                                  );
                                }),
                            const SizedBox(height: 30,)
                        ],
                      ),
                    );
                  } else if (state is GetAnnonceClient.GetAnnonceLoading) {
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
                
            });
          } else {
            return BlocBuilder<GetAnnonceTransporteur.GetAnnonceTransporteurBloc,
                  GetAnnonceTransporteur.GetAnnonceTransporteurState>(
                builder: (context, state) {
                  if (state is GetAnnonceTransporteur.GetAnnonceSuccess) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.annonces.length,
                            itemBuilder: (context, int i) {
                              final annonce = state.annonces[i];
                              context.read<GetUserByIdBloc>().add((GetUserById(myUserid: annonce.userId)));
                                return BlocBuilder<GetUserByIdBloc, GetUserByIdState>(
                                builder: (context, state) {
                                  if (state is GetUserByIdSuccess) {
                                      return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 20),
                                        Row(
                                          children: [
                                            Container(
                                              margin:
                                                  const EdgeInsets.only(left: 15),
                                              width: 50,
                                              height: 50,
                                              decoration: const BoxDecoration(
                                                  color: Colors.amber,
                                                  shape: BoxShape.circle),
                                            ),
                                            const SizedBox(width: 10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  state.myUser.Nom,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                    DateFormat("yyyy-MM-dd HH:mm")
                                                        .format(annonce.Created_at)),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 20),
                                          decoration: BoxDecoration(
                                              image: const DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/abstract-orange-and-white-background-vector3.jpg"),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey.shade400,
                                                    blurRadius: 5,
                                                    offset: const Offset(3, 3))
                                              ]),
                                          child: MaterialButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Details_Transporteur(annonce, state.myUser)));
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
                                                        margin:
                                                            const EdgeInsets.only(
                                                                left: 10,
                                                                top: 20,
                                                                bottom: 10),
                                                        child: Center(
                                                          child: Text(
                                                            annonce.Titre,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 20,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 5, top: 10, right: 5),
                                                  child: const Row(
                                                    children: [
                                                      Expanded(
                                                        child: Center(
                                                            child: Text(
                                                          "Ville départ:",
                                                          style: TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                          ),
                                                        )),
                                                      ),
                                                      Expanded(
                                                        child: Center(
                                                            child: Text(
                                                          "Ville d'arrivé:",
                                                          style: TextStyle(
                                                            decoration:
                                                                TextDecoration
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
                                                          child: Text(annonce.Ville_depart)),
                                                    ),
                                                    Expanded(
                                                      child: Center(
                                                          child: Text(annonce.Ville_darrive)),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 5, top: 10, right: 5),
                                                  child: const Row(
                                                    children: [
                                                      Expanded(
                                                        child: Center(
                                                            child: Text(
                                                          "Date depart:",
                                                          style: TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                          ),
                                                        )),
                                                      ),
                                                      Expanded(
                                                        child: Center(
                                                            child: Text(
                                                          "Date d'arrivé:",
                                                          style: TextStyle(
                                                            decoration:
                                                                TextDecoration
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
                                                                .format(annonce.Date_depart)))),
                                                    Expanded(
                                                        child: Center(
                                                            child: Text(DateFormat(
                                                                    "yyyy-MM-dd HH:mm")
                                                                .format(annonce.Date_darrive))))
                                                  ],
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 5, top: 10, right: 5),
                                                  child: const Row(
                                                    children: [
                                                      Expanded(
                                                        child: Center(
                                                            child: Text(
                                                          "N Vehicule:",
                                                          style: TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                          ),
                                                        )),
                                                      ),
                                                      Expanded(
                                                        child: Center(
                                                            child: Text(
                                                          "charge:",
                                                          style: TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                          ),
                                                        )),
                                                      ),
                                                      Expanded(
                                                        child: Center(
                                                            child: Text(
                                                          "Prix:",
                                                          style: TextStyle(
                                                            decoration:
                                                                TextDecoration
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
                                                              "${annonce.NbreVehicule}")),
                                                    ),
                                                    Expanded(
                                                      child: Center(
                                                          child: Text(
                                                              "${annonce.charge} Kg")),
                                                    ),
                                                    Expanded(
                                                      child: Center(
                                                          child: Text(
                                                              "${annonce.prix} Dh")),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 30,)
                        ],
                      ),
                    );
                  } else if (state is GetAnnonceTransporteur.GetAnnonceLoading) {
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
              
            });
          }
        }
        ),
    );
  }
}
