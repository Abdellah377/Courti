// ignore_for_file: prefer_const_constructors, camel_case_types, file_names

import 'package:annonce_client_repository/annonce_client_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kourti_application_1/app_language_provider.dart';
import 'package:kourti_application_1/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:user_repository/user_repository.dart';

// ignore: must_be_immutable
class Details_Client extends StatelessWidget {
  final AnnoncesClient annoncesclient;
  final MyUsers myUser;
  Details_Client(this.annoncesclient, this.myUser, {super.key});

  late AppLanguageProvider appLanguage;

  @override
  Widget build(BuildContext context) {
    appLanguage = Provider.of<AppLanguageProvider>(context);
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
                    Text(
                      AppLocalizations.of(context)!.translate('Information personnelle')!,
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
                          AppLocalizations.of(context)!.translate('Nom')!,
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
                            AppLocalizations.of(context)!.translate('Type')!,
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
                            AppLocalizations.of(context)!.translate('E-mail')!,
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
                            AppLocalizations.of(context)!.translate('Numéro de telephone')!,
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
                    Text(
                      AppLocalizations.of(context)!.translate("Information sur l'annonce")!,
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
                          AppLocalizations.of(context)!.translate('Titre')!,
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
                            AppLocalizations.of(context)!.translate("Prix")!,
                          style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold ),
                            ),
                        ),
                        Expanded(
                          // flex: 15,
                          child: Text(
                            "${annoncesclient.prix} ${AppLocalizations.of(context)!.translate("Dh")!}",
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
                                AppLocalizations.of(context)!.translate('Ville de départ')!,
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
                                AppLocalizations.of(context)!.translate("Ville d'arrivée")!,
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
                               AppLocalizations.of(context)!.translate('Date de départ')!,
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
                                AppLocalizations.of(context)!.translate("Date d'arrivée")!,
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
                                AppLocalizations.of(context)!.translate("Types de marchandises")!,
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
                                AppLocalizations.of(context)!.translate("Tonnage")!,
                              style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold ),
                              ),
                            ),
                            Expanded(
                              // flex: 15,
                              child: Text("${annoncesclient.tonnage} ${AppLocalizations.of(context)!.translate("Kg")!}",
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
                                AppLocalizations.of(context)!.translate("Details")!,
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