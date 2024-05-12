// ignore_for_file: prefer_const_constructors, camel_case_types, file_names

import 'package:annonce_client_repository/annonce_client_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Details_Client extends StatelessWidget {
  final AnnoncesClient annoncesclient;
  const Details_Client(this.annoncesclient, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(),
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
                    Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        shape: BoxShape.circle
                      ),
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
                            annoncesclient.myUser.Nom,
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
                            annoncesclient.myUser.Type,
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
                          child: Text(annoncesclient.myUser.E_mail,
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
                          child: Text(annoncesclient.myUser.Telephone,
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
                            annoncesclient.Titre,
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
                            "${annoncesclient.prix} Dh",
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
                              child: Text(annoncesclient.Ville_depart,
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
                              child: Text(annoncesclient.Ville_darrive,
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
                                DateFormat("yyyy-MM-dd HH:mm").format(annoncesclient.Date_depart),
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
                                DateFormat("yyyy-MM-dd HH:mm").format(annoncesclient.Date_darrive),
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
                                "Type des marchandises: ",
                              style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold ),
                                ),
                            ),
                            Expanded(
                              // flex: 15,
                              child: Text(annoncesclient.TypeMarchandise,
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
                                "Tonnage: ",
                              style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold ),
                              ),
                            ),
                            Expanded(
                              // flex: 15,
                              child: Text("${annoncesclient.tonnage} Kg",
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
                              child: Text(annoncesclient.Details,
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