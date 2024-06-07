// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_prefixes, file_names

import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kourti_application_1/Blocs/AnnonceTransporteurBlocs/get_annonce_transporteur_bloc/get_annonce_transporteur_bloc.dart'
    as GetAnnonceTransporteur;
import 'package:kourti_application_1/Blocs/AnnonceClientBlocs/get_annonce_client_bloc/get_annonce_client_bloc.dart'
    as GetAnnonceClient;
import 'package:kourti_application_1/Blocs/UserBlocs/authentification_bloc/authentification_bloc.dart';
import 'package:kourti_application_1/Blocs/UserBlocs/get_user_by_id_bloc/get_user_by_id_bloc.dart';
import 'package:kourti_application_1/Blocs/UserBlocs/upload_picture_bloc/upload_picture_bloc.dart';
import 'package:kourti_application_1/app_language_provider.dart';
import 'package:kourti_application_1/app_localizations.dart';
import 'package:kourti_application_1/home/Profile/EditProfile.dart';
import 'package:kourti_application_1/home/Profile/My_Details_Transporteur.dart';
import 'package:kourti_application_1/home/Profile/My_Details_client.dart';
import 'package:provider/provider.dart';
import 'package:user_repository/user_repository.dart';

class MyProfile extends StatefulWidget {
  final MyUsers myUsers;
  const MyProfile(this.myUsers, {super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  late AppLanguageProvider appLanguage;

  @override
  Widget build(BuildContext context) {
    appLanguage = Provider.of<AppLanguageProvider>(context);
    
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.translate('Profile')!),
        actions: [
          PopupMenuButton<int>(
            color: Colors.white,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 1,
                child: Row(
                  children: <Widget>[
                    // Icon(Icons.abc,),
                    SizedBox(
                      width: 10,
                    ),
                    Text("English")
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 2,
                child: Row(
                  children: [
                    // Icon(Icons.nearby_off),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Francais")
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 3,
                child: Row(
                  children: [
                    // Icon(Icons.nearby_off),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Arabic")
                  ],
                ),
              ),
            ],
            elevation: 2,
            onSelected: (value) {
              if (value == 1) {
                appLanguage.changeLanguage(const Locale("en"));
              } else if (value == 2) {
                appLanguage.changeLanguage(const Locale("fr"));
              }else if (value == 3) {
                appLanguage.changeLanguage(const Locale("ar"));
              }
            },
          ),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider<UploadPictureBloc>(
                        create: (context) => UploadPictureBloc(
                          userRepository: context.read<AuthentificationBloc>().userRepository),
                        child: EditProfile(widget.myUsers),
                      ),
                    ));
              },
              icon: Icon(Icons.edit))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 1));
          setState(() {});
        },
        child: SingleChildScrollView(
          child: Column(
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
                        AppLocalizations.of(context)!.translate('Information personnelle')!,
                        style: TextStyle(
                            fontSize: 25,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      widget.myUsers.picture == ""
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
                                          NetworkImage(widget.myUsers.picture),
                                      fit: BoxFit.cover)),
                            ),

                      SizedBox(
                        height: 20,
                      ),

                      // Text(
                      //   "${widget.myUsers.Rating} (${widget.myUsers.NbRaters})",
                      //   style: TextStyle(fontSize: 22),),

                      AnimatedRatingStars(
                        initialRating: 3.5,
                        minRating: 0.0,
                        maxRating: 5.0,
                        filledColor: Colors.amber,
                        emptyColor: Colors.grey,
                        filledIcon: Icons.star,
                        halfFilledIcon: Icons.star_half,
                        emptyIcon: Icons.star_border,
                        onChanged: (double rating) {
                          setState(() {});
                          print('Rating: $rating');
                        },
                        displayRatingValue: true,
                        interactiveTooltips: true,
                        customFilledIcon: Icons.star,
                        customHalfFilledIcon: Icons.star_half,
                        customEmptyIcon: Icons.star_border,
                        starSize: 30.0,
                        animationDuration: Duration(milliseconds: 300),
                        animationCurve: Curves.easeInOut,
                        readOnly: true,
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
                              AppLocalizations.of(context)!.translate('Nom')!,
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 15,
                            child: Text(
                              widget.myUsers.Nom,
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
                              AppLocalizations.of(context)!.translate('Type')!,
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                              flex: 15,
                              child: Text(
                                widget.myUsers.Type,
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
                              AppLocalizations.of(context)!.translate('E-mail')!,
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                              flex: 15,
                              child: Text(
                                widget.myUsers.E_mail,
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
                              AppLocalizations.of(context)!.translate('Numéro de telephone')!,
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 15,
                            child: Text(
                              widget.myUsers.Telephone,
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
              Builder(builder: (context) {
                if (widget.myUsers.Type == "Client") {
                  return BlocBuilder<GetAnnonceClient.GetAnnonceClientBloc,
                      GetAnnonceClient.GetAnnonceClientState>(
                    builder: (context, state) {
                      if (state is GetAnnonceClient.GetAnnonceSuccess) {
                        return Column(
                          children: [
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: state.annonces.length,
                                itemBuilder: (context, int i) {
                                  final annonce = state.annonces[i];
                                  context.read<GetUserByIdBloc>().add(
                                      (GetUserById(myUserid: annonce.userId)));
                                  return BlocBuilder<GetUserByIdBloc,
                                      GetUserByIdState>(
                                    builder: (context, state) {
                                      if (state is GetUserByIdSuccess) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 20),
                                            Row(
                                              children: [
                                                SizedBox(width: 20),
                                                widget.myUsers.picture == ""
                                                  ? Container(
                                                      width: 50,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                          color: Colors.amber, shape: BoxShape.circle),
                                                    )
                                                  : Container(
                                                      width: 50,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                          color: Colors.grey,
                                                          shape: BoxShape.circle,
                                                          image: DecorationImage(
                                                              image:
                                                                  NetworkImage(widget.myUsers.picture),
                                                              fit: BoxFit.cover)),
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
                                                        .format(annonce
                                                            .Created_at)),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 20),
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
                                                        color: Colors
                                                            .grey.shade400,
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
                                                              My_Details_Client(
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
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Center(
                                                                child: Text(
                                                              AppLocalizations.of(context)!.translate('Ville de départ')!,
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
                                                              AppLocalizations.of(context)!.translate("Ville d'arrivée")!,
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
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Center(
                                                                child: Text(
                                                              AppLocalizations.of(context)!.translate('Date de départ')!,
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
                                                              AppLocalizations.of(context)!.translate("Date d'arrivée")!,
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
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Center(
                                                                child: Text(
                                                                    AppLocalizations.of(context)!.translate("Marchandise")!,
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
                                                              AppLocalizations.of(context)!.translate("Tonnage")!,
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
                                                              AppLocalizations.of(context)!.translate("Prix")!,
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
                                                                  "${annonce.tonnage} ${AppLocalizations.of(context)!.translate("Kg")!}")),
                                                        ),
                                                        Expanded(
                                                          child: Center(
                                                              child: Text(
                                                                  "${annonce.prix} ${AppLocalizations.of(context)!.translate("Dh")!}")),
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
                                }),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 5,
                            )
                          ],
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
                  );
                } else {
                  return BlocBuilder<
                      GetAnnonceTransporteur.GetAnnonceTransporteurBloc,
                      GetAnnonceTransporteur.GetAnnonceTransporteurState>(
                    builder: (context, state) {
                      if (state is GetAnnonceTransporteur.GetAnnonceSuccess) {
                        return Column(
                          children: [
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: state.annonces.length,
                              itemBuilder: (context, int i) {
                                final annonce = state.annonces[i];
                                context.read<GetUserByIdBloc>().add(
                                    (GetUserById(myUserid: annonce.userId)));
                                return BlocBuilder<GetUserByIdBloc,
                                    GetUserByIdState>(
                                  builder: (context, state) {
                                    if (state is GetUserByIdSuccess) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 20),
                                          Row(
                                            children: [
                                              const SizedBox(width: 20,),
                                              widget.myUsers.picture == ""
                                              ? Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      color: Colors.amber, shape: BoxShape.circle),
                                                )
                                              : Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey,
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          image:
                                                              NetworkImage(widget.myUsers.picture),
                                                          fit: BoxFit.cover)),
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
                                                            My_Details_Transporteur(
                                                                annonce,
                                                                state.myUser)));
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
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Center(
                                                              child: Text(
                                                            AppLocalizations.of(context)!.translate("Ville de départ")!,
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
                                                            AppLocalizations.of(context)!.translate("Ville d'arrivée")!,
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
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Center(
                                                              child: Text(
                                                            AppLocalizations.of(context)!.translate("Date de départ")!,
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
                                                            AppLocalizations.of(context)!.translate("Date d'arrivée")!,
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
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Center(
                                                              child: Text(
                                                            AppLocalizations.of(context)!.translate("N Vehicule")!,
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
                                                            AppLocalizations.of(context)!.translate("Charge")!,
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
                                                            AppLocalizations.of(context)!.translate("Prix")!,
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
                                                                "${annonce.charge} ${AppLocalizations.of(context)!.translate("Kg")!}")),
                                                      ),
                                                      Expanded(
                                                        child: Center(
                                                            child: Text(
                                                                "${annonce.prix} ${AppLocalizations.of(context)!.translate("Dh")!}")),
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
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 5,
                            )
                          ],
                        );
                      } else if (state
                          is GetAnnonceTransporteur.GetAnnonceLoading) {
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
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
