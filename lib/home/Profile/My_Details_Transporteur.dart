// ignore_for_file: prefer_const_constructors, camel_case_types, file_names

import 'package:annonce_transporteur_repository/annonce_transporteur_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kourti_application_1/Blocs/AnnonceTransporteurBlocs/add_annonce_transporteur_bloc/add_annonce_transporteur_bloc.dart';
import 'package:kourti_application_1/home/Profile/EditAnnonces_Transporteur.dart';
import 'package:user_repository/user_repository.dart';

class My_Details_Transporteur extends StatelessWidget {
  final AnnoncesTransporteur annoncesTransporteur;
  final MyUsers myUser;

  const My_Details_Transporteur(this.annoncesTransporteur, this.myUser, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) =>
                BlocProvider<AddAnnonceTransporteurBloc>(
                  create: (context) => AddAnnonceTransporteurBloc(
                    annonceRepo: FirebaseAnnonceTransporteurRepo()),
                  child: EditAnnonces_Transporteur(annoncesTransporteur)
                )
              ));
            },
            icon: Icon(Icons.edit))
          ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16,right: 16,top: 16),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 25),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration( 
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Column(
                  children:[
                    SizedBox(height: 20,),
                    Text("Information personnelle",
                    style: TextStyle( 
                      fontSize: 25,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: 20,),
                    myUser.picture == ""
                          ? Container(
                              width: 160,
                              height: 160,
                              decoration: BoxDecoration(
                                  color: Colors.amber, shape: BoxShape.circle),
                            )
                          : Container(
                              width: 160,
                              height: 160,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image:
                                          NetworkImage(myUser.picture),
                                      fit: BoxFit.cover)),
                            ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        SizedBox(width: 20,height: 30),
                        Expanded(
                          flex: 10,
                          child: Text(
                          "Nom: ",
                          style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold ),
                          ),
                        ),
                        Expanded(
                          flex: 15,
                          child: Text(
                            myUser.Nom,
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 20,height: 30),
                        Expanded(
                          flex: 10,
                          child: Text(
                            "Type: ",
                          style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold ),
                            ),
                        ),
                        Expanded(
                          flex: 15,
                          child: Text(
                            myUser.Type,
                            style: TextStyle(fontSize: 17),
                          )),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 20,height: 30),
                        Expanded(
                          flex: 10,
                          child: Text(
                            "E-mail: ",
                          style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold ),
                            ),
                        ),
                        Expanded(
                          flex: 15,
                          child: Text(myUser.E_mail,
                            style: TextStyle(fontSize: 17),
                          )
                        )
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 20,height: 30),
                        Expanded(
                          flex: 10,
                          child: Text(
                            "Numéro de telephone: ",
                          style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold ),
                          ),
                        ),
                        Expanded(
                          flex: 15,
                          child: Text(myUser.Telephone,
                          style: TextStyle(fontSize: 17),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 25),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration( 
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Column(
                  children:[
                    SizedBox(height: 20,),
                    Text("Information sur l'annonce",
                    style: TextStyle( 
                      fontSize: 25,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: 20,),
                    Column(
                      children: [
                        Row(
                      children: [
                        SizedBox(width: 20,),
                        Expanded(
                          // flex: 10,
                          child: Text(
                          "Titre: ",
                          style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold ),
                          ),
                        ),
                        Expanded(
                          // flex: 15,
                          child: Text(
                            annoncesTransporteur.Titre,
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 20,height: 30),
                        Expanded(
                          child: Text(
                            "Prix: ",
                          style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold ),
                            ),
                        ),
                        Expanded(
                          // flex: 15,
                          child: Text(
                            "${annoncesTransporteur.prix} Dh",
                            style: TextStyle(fontSize: 17),
                          )),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 20,height: 30),
                            Expanded(
                              // flex: 10,
                              child: Text(
                                "Ville de départ: ",
                              style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold ),
                                ),
                            ),
                            Expanded(
                              // flex: 15,
                              child: Text(annoncesTransporteur.Ville_depart,
                                style: TextStyle(fontSize: 17),
                              ))
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 20,height: 30),
                            Expanded(
                              // flex: 10,
                              child: Text(
                                "Ville d'arrivé: ",
                              style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold ),
                              ),
                            ),
                            Expanded(
                              // flex: 15,
                              child: Text(annoncesTransporteur.Ville_darrive,
                              style: TextStyle(fontSize: 17),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 20,height: 30),
                            Expanded(
                              // flex: 10,
                              child: Text(
                              "Date de départ: ",
                              style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold ),
                              ),
                            ),
                            Expanded(
                              // flex: 15,
                              child: Text(
                                DateFormat("yyyy-MM-dd HH:mm").format(annoncesTransporteur.Date_depart),
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 20,height: 30),
                            Expanded(
                              // flex: 10,
                              child: Text(
                                "Date d'arrivé: ",
                              style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold ),
                                ),
                            ),
                            Expanded(
                              // flex: 15,
                              child: Text(
                                DateFormat("yyyy-MM-dd HH:mm").format(annoncesTransporteur.Date_darrive),
                                style: TextStyle(fontSize: 17),
                              )),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 20,height: 30),
                            Expanded(
                              // flex: 10,
                              child: Text(
                                "Nombre de vehicules utiliser: ",
                              style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold ),
                                ),
                            ),
                            Expanded(
                              // flex: 15,
                              child: Text("${annoncesTransporteur.NbreVehicule}",
                                style: TextStyle(fontSize: 17),
                              ))
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 20,height: 30),
                            Expanded(
                              // flex: 10,
                              child: Text(
                                "Charge: ",
                              style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold ),
                              ),
                            ),
                            Expanded(
                              // flex: 15,
                              child: Text("${annoncesTransporteur.charge} Kg",
                              style: TextStyle(fontSize: 17),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 20,height: 30),
                            Expanded(
                              child: Text(
                                "Details: ",
                              style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold ),
                              ),
                            ),
                            Expanded(
                              child: Text(annoncesTransporteur.Details,
                              style: TextStyle(fontSize: 17),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}