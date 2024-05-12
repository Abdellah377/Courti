// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, library_prefixes, file_names

import 'package:annonce_client_repository/annonce_client_repository.dart';
import 'package:annonce_transporteur_repository/annonce_transporteur_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kourti_application_1/Blocs/AnnonceClientBlocs/add_annonce_client_bloc/add_annonce_client_bloc.dart';
import 'package:kourti_application_1/Blocs/AnnonceClientBlocs/get_annonce_client_bloc/get_annonce_client_bloc.dart' as GetAnnonceClient;
import 'package:kourti_application_1/Blocs/AnnonceTransporteurBlocs/add_annonce_transporteur_bloc/add_annonce_transporteur_bloc.dart';
import 'package:kourti_application_1/Blocs/AnnonceTransporteurBlocs/get_annonce_transporteur_bloc/get_annonce_transporteur_bloc.dart' as GetAnnonceTransporteur;
import 'package:kourti_application_1/Blocs/UserBlocs/authentification_bloc/authentification_bloc.dart';
import 'package:kourti_application_1/Blocs/UserBlocs/log_in_bloc/log_in_bloc.dart';
import 'package:kourti_application_1/home/Add_annonce_Client.dart';
import 'package:kourti_application_1/home/Add_annonce_transporteur.dart';
import 'package:kourti_application_1/home/Details_Transporteur.dart';
import 'package:kourti_application_1/home/Details_client.dart';
import 'package:kourti_application_1/Blocs/UserBlocs/my_user_bloc/my_user_bloc.dart';
import 'package:kourti_application_1/home/Profile.dart';

class Annonce extends StatelessWidget {
  const Annonce({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          centerTitle: true,
          title: Text("Home page"),
          leading: IconButton(
            icon: const Icon(Icons.person_pin),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider<MyUserBloc>(
                  create: (context) => MyUserBloc(
                    myUserRepository: context.read<AuthentificationBloc>().userRepository
                  )..add(GetMyUser(myUserid: context.read<AuthentificationBloc>().state.user!.user_id)),
                  child: Profile(),
                  ),
                )
              );
            },
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: const Icon(Icons.person),
                text: "Annonce Client",
              ),
              Tab(
                icon: const Icon(Icons.person),
                text: "Annonce Transporteur",
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: (){
                
              },
               icon: Icon(Icons.search)),
            IconButton(
                onPressed: () {
                  context.read<LogInBloc>().add(SignOutRequired());
                },
                icon: const Icon(CupertinoIcons.arrow_right_to_line))
          ],
        ),
        floatingActionButton: BlocBuilder<MyUserBloc, MyUserState>(
          builder: (context, state) {
            return FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  if (state.myUser!.Type == "Client") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider<AddAnnonceClientBloc>(
                          create: (context) => AddAnnonceClientBloc(annonceRepo: FirebaseAnnonceClientRepo()),
                          child: AnnonceAdd_Client(state.myUser!),
                          )
                      )
                    );
                  } else if (state.myUser!.Type == "Transporteur") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider<AddAnnonceTransporteurBloc>(
                          create: (context) =>
                          AddAnnonceTransporteurBloc(annonceRepo:FirebaseAnnonceTransporteurRepo()),
                          child: AnnonceAdd_Transporteur(state.myUser!),
                          )
                      )
                    );
                  }
                }
              );
          },
        ),
        body: TabBarView(
          children: [
            BlocBuilder<GetAnnonceClient.GetAnnonceClientBloc, GetAnnonceClient.GetAnnonceClientState>(
              builder: (context, state) {
                if (state is GetAnnonceClient.GetAnnonceSuccess) {
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
                                margin:EdgeInsets.only(left: 15),
                                width: 50,
                                height: 50,
                                decoration: const BoxDecoration(
                                  color: Colors.amber,
                                  shape: BoxShape.circle
                                ),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(state.annonces[i].myUser.Nom,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                  Text(DateFormat("yyyy-MM-dd HH:mm").format(state.annonces[i].Created_at)),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            margin:EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/abstract-orange-and-white-background-vector3.jpg"),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade400,
                                  blurRadius: 5,
                                  offset: Offset(3, 3)
                                )
                                ]
                              ),
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Details_Client(state.annonces[i])));
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(left: 10,top: 20,bottom: 10),
                                          child: Center(
                                            child: Text(state.annonces[i].Titre,
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
                                    margin: EdgeInsets.only(left: 5,top: 10,right: 5),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Center(child: Text("Ville départ:", style: TextStyle(decoration: TextDecoration.underline,),)),
                                        ),
                                        Expanded(
                                          child: Center(child: Text("Ville d'arrivé:", style: TextStyle(decoration: TextDecoration.underline,),)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Center(child: Text(state.annonces[i].Ville_depart)),
                                      ),
                                      Expanded(
                                        child: Center(child: Text(state.annonces[i].Ville_darrive)),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 5,top: 10,right: 5),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Center(child: Text("Date depart:", style: TextStyle(decoration: TextDecoration.underline,),)),
                                        ),
                                        Expanded(
                                          child: Center(child: Text("Date d'arrivé:", style: TextStyle(decoration: TextDecoration.underline,),)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(child: Center(child: Text(DateFormat("yyyy-MM-dd HH:mm").format(state.annonces[i].Date_depart)))),
                                      Expanded(child: Center(child: Text(DateFormat("yyyy-MM-dd HH:mm").format(state.annonces[i].Date_darrive))))
                                      ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 5,top: 10,right: 5),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Center(child: Text("Marcendise:", style: TextStyle(decoration: TextDecoration.underline,))),
                                        ),
                                        Expanded(
                                          child: Center(child: Text("charge:", style: TextStyle(decoration: TextDecoration.underline,),)),
                                        ),
                                        Expanded(
                                          child: Center(child: Text("Prix:", style: TextStyle(decoration: TextDecoration.underline,),)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Center(child: Text(state.annonces[i].TypeMarchandise,maxLines: 2,)),
                                      ),
                                      Expanded(
                                        child: Center(child: Text("${state.annonces[i].tonnage}")),
                                      ),
                                      Expanded(
                                        child: Center(child: Text("${state.annonces[i].prix}")),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                  }
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
              },
            ),
            BlocBuilder<GetAnnonceTransporteur.GetAnnonceTransporteurBloc,GetAnnonceTransporteur.GetAnnonceTransporteurState>(
              builder: (context, state) {
                if (state is GetAnnonceTransporteur.GetAnnonceSuccess) {
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
                                margin:EdgeInsets.only(left: 15),
                                width: 50,
                                height: 50,
                                decoration: const BoxDecoration(
                                  color: Colors.amber,
                                  shape: BoxShape.circle
                                ),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Abdellah",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                  Text(DateFormat("yyyy-MM-dd HH:mm").format(state.annonces[i].Created_at)),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            margin:
                              EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/images/abstract-orange-and-white-background-vector3.jpg"),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade400,
                                    blurRadius: 5,
                                    offset: Offset(3, 3)
                                  )
                                ]
                              ),
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Details_Transporteur(state.annonces[i])));
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(left: 10,top: 20,bottom: 10),
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
                                    margin: EdgeInsets.only(left: 5,top: 10,right: 5),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Center(child: Text("Ville départ:", style: TextStyle(decoration: TextDecoration.underline,),)),
                                        ),
                                        Expanded(
                                          child: Center(child: Text("Ville d'arrivé:", style: TextStyle(decoration: TextDecoration.underline,),)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Center(child: Text(state.annonces[i].Ville_depart)),
                                      ),
                                      Expanded(
                                        child: Center(child: Text(state.annonces[i].Ville_darrive)),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 5,top: 10,right: 5),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Center(child: Text("Date depart:", style: TextStyle(decoration: TextDecoration.underline,),)),
                                        ),
                                        Expanded(
                                          child: Center(child: Text("Date d'arrivé:", style: TextStyle(decoration: TextDecoration.underline,),)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(child: Center(child: Text(DateFormat("yyyy-MM-dd HH:mm").format(state.annonces[i].Date_depart)))),
                                      Expanded(child: Center(child: Text(DateFormat("yyyy-MM-dd HH:mm").format(state.annonces[i].Date_darrive))))
                                      ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 5,top: 10,right: 5),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Center(child: Text("N Vehicule:", style: TextStyle(decoration: TextDecoration.underline,),)),
                                        ),
                                        Expanded(
                                          child: Center(child: Text("charge:", style: TextStyle(decoration: TextDecoration.underline,),)),
                                        ),
                                        Expanded(
                                          child: Center(child: Text("Prix:", style: TextStyle(decoration: TextDecoration.underline,),)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Center(child: Text("${state.annonces[i].NbreVehicule}")),
                                      ),
                                      Expanded(
                                        child: Center(child: Text("${state.annonces[i].charge} Kg")),
                                      ),
                                      Expanded(
                                        child: Center(child: Text("${state.annonces[i].prix} Dh")),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
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
              },
            ),
          ],
        ),
      ),
    );
  }
}
