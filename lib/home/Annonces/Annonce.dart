// ignore_for_file: library_prefixes

import 'package:annonce_client_repository/annonce_client_repository.dart';
import 'package:annonce_transporteur_repository/annonce_transporteur_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kourti_application_1/Blocs/AnnonceClientBlocs/add_annonce_client_bloc/add_annonce_client_bloc.dart';
import 'package:kourti_application_1/Blocs/AnnonceClientBlocs/get_annonce_client_bloc/get_annonce_client_bloc.dart'
    as GetAnnonceClient;
import 'package:kourti_application_1/Blocs/AnnonceTransporteurBlocs/add_annonce_transporteur_bloc/add_annonce_transporteur_bloc.dart';
import 'package:kourti_application_1/Blocs/AnnonceTransporteurBlocs/get_annonce_transporteur_bloc/get_annonce_transporteur_bloc.dart'
    as GetAnnonceTransporteur;
import 'package:kourti_application_1/Blocs/UserBlocs/get_users_bloc/get_users_bloc.dart';
import 'package:kourti_application_1/Blocs/UserBlocs/log_in_bloc/log_in_bloc.dart';
import 'package:kourti_application_1/app_language_provider.dart';
import 'package:kourti_application_1/app_localizations.dart';
import 'package:kourti_application_1/home/Annonces/Add_annonce_Client.dart';
import 'package:kourti_application_1/home/Annonces/Add_annonce_transporteur.dart';
import 'package:kourti_application_1/home/Annonces/Details_Transporteur.dart';
import 'package:kourti_application_1/home/Annonces/Details_client.dart';
import 'package:kourti_application_1/Blocs/UserBlocs/my_user_bloc/my_user_bloc.dart';
import 'package:kourti_application_1/home/Profile/MyProfile_Screen.dart';
import 'package:kourti_application_1/home/Annonces/SearchAnnonces_Screen.dart';
import 'package:kourti_application_1/home/Users/UserProfile_Screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class Annonce extends StatefulWidget {
  const Annonce({super.key});

  @override
  State<Annonce> createState() => _AnnonceState();
}

class _AnnonceState extends State<Annonce> {
  final _formKeyC = GlobalKey<FormState>();
  final _formKeyT = GlobalKey<FormState>();

  final valueControllerClient = TextEditingController();
  final valueControllerTransp = TextEditingController();

  String argsControllerClient = 'Titre';
  String argsControllerTransp = 'Titre';

  List<String> listOfValueClient = [
    'Titre',
    'Ville_depart',
    'Ville_darrive',
    'Date_depart',
    'Date_darrive',
    'tonnage',
    'prix',
    'TypeMarchandise',
  ];
  List<String> listOfValueTransp = [
    'Titre',
    'Ville_depart',
    'Ville_darrive',
    'Date_depart',
    'Date_darrive',
    'charge',
    'prix',
    'NbreVehicule',
  ];

  late AppLanguageProvider appLanguage;

  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    appLanguage = Provider.of<AppLanguageProvider>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          centerTitle: true,
          title: Text(AppLocalizations.of(context)!.translate('Courti')!),
          leading: BlocBuilder<MyUserBloc, MyUserState>(
            builder: (context, state) {
              return IconButton(
                icon: const Icon(Icons.person_pin),
                onPressed: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: MyProfile_Screen(state.myUser!),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
              );
            },
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.person),
                text: AppLocalizations.of(context)!.translate("Annonce Client")!,
              ),
              Tab(
                icon: Icon(Icons.person),
                text: AppLocalizations.of(context)!.translate('Annonce Transporteur')!,
              ),
            ],
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
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
                heroTag: "btn",
                child: const Icon(Icons.add),
                onPressed: () {
                  if (state.myUser!.Type == "Client") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BlocProvider<AddAnnonceClientBloc>(
                                  create: (context) => AddAnnonceClientBloc(
                                      annonceRepo: FirebaseAnnonceClientRepo()),
                                  child:
                                      AnnonceAdd_Client(state.myUser!.user_id),
                                )));
                  } else if (state.myUser!.Type == "Transporteur") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BlocProvider<AddAnnonceTransporteurBloc>(
                                  create: (context) =>
                                      AddAnnonceTransporteurBloc(
                                          annonceRepo:
                                              FirebaseAnnonceTransporteurRepo()),
                                  child: AnnonceAdd_Transporteur(
                                      state.myUser!.user_id),
                                )));
                  }
                });
          },
        ),
        body: TabBarView(
          children: [
            BlocBuilder<GetAnnonceClient.GetAnnonceClientBloc,
                GetAnnonceClient.GetAnnonceClientState>(
              builder: (context, state) {
                if (state is GetAnnonceClient.GetAnnonceSuccess) {
                  return SizedBox(
                    width: 2000,
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await Future.delayed(Duration(seconds: 1));
                        setState(() {});
                      },
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Form(
                                key: _formKeyC,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        margin: const EdgeInsets.only(left: 0),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 18),
                                        decoration: BoxDecoration(
                                            border: const Border(
                                                bottom: BorderSide(
                                                    color: Colors.black)),
                                            borderRadius:
                                                const BorderRadius.horizontal(
                                                    left: Radius.circular(15)),
                                            color: const Color.fromARGB(
                                                    255, 255, 255, 255)
                                                .withOpacity(.2)),
                                        child: DropdownButtonFormField(
                                          decoration:
                                              const InputDecoration.collapsed(
                                                  hintText: ''),
                                          value: argsControllerClient,
                                          hint: const Text(
                                            'Nom',
                                          ),
                                          isExpanded: true,
                                          onChanged: (value) {
                                            setState(() {
                                              argsControllerClient = value!;
                                            });
                                          },
                                          onSaved: (value) {
                                            setState(() {
                                              argsControllerClient = value!;
                                            });
                                          },
                                          validator: (String? value) {
                                            if (value == '') {
                                              return "can't empty";
                                            } else {
                                              return null;
                                            }
                                          },
                                          items: listOfValueClient
                                              .map((String val) {
                                            return DropdownMenuItem(
                                              value: val,
                                              child: Text(val),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 6),
                                          decoration: BoxDecoration(
                                            border: const Border(
                                                bottom: BorderSide(
                                                    color: Colors.black)),
                                            color: const Color.fromARGB(
                                                    255, 255, 255, 255)
                                                .withOpacity(.2),
                                          ),
                                          child: TextFormField(
                                            style: const TextStyle(height: 1.5),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: AppLocalizations.of(context)!.translate('Search Annonce')!,
                                            ),
                                            controller: valueControllerClient,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return AppLocalizations.of(context)!.translate('value is required')!;
                                              }
                                              return null;
                                            },
                                          )),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                          padding:
                                              const EdgeInsets.only(top: 12),
                                          decoration: const BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.black)),
                                            borderRadius:
                                                BorderRadius.horizontal(
                                                    right: Radius.circular(15)),
                                          ),
                                          child: IconButton(
                                            icon: const Icon(Icons.search),
                                            onPressed: () {
                                              PersistentNavBarNavigator
                                                  .pushNewScreen(
                                                context,
                                                screen: SearchAnnonce_Screen(
                                                    argsControllerClient,
                                                    valueControllerClient.text,
                                                    "Client"),
                                                withNavBar: false,
                                                pageTransitionAnimation:
                                                    PageTransitionAnimation
                                                        .cupertino,
                                              );
                                            },
                                          )),
                                    ),
                                  ],
                                )),
                              ListView.builder(
                                physics: const ClampingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: state.annonces.length,
                                itemBuilder: (context, int i) {
                                  final annonce = state.annonces[i];
                                  return BlocBuilder<GetUsersBloc, GetUsersState>(
                                    builder: (context, state) {
                                      if (state is GetUsersSuccess ) {
                                          return ListView.builder(
                                            physics: const ClampingScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: state.myUsers.length,
                                            itemBuilder: (context, int j) {
                                              if (state.myUsers[j].user_id == annonce.userId) {
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(height: 20),
                                                  MaterialButton(
                                                    onPressed: () {
                                                      PersistentNavBarNavigator.pushNewScreen(
                                                      context,
                                                      screen: UserProfile_Screen(state.myUsers[j]),
                                                      withNavBar: false,
                                                      pageTransitionAnimation:
                                                      PageTransitionAnimation.cupertino,);
                                                    },
                                                    child: Row(
                                                      children: [
                                                        state.myUsers[j].picture == ""
                                                          ? Container(
                                                              width: 50,
                                                              height: 50,
                                                              decoration: const BoxDecoration(
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
                                                                          NetworkImage(state.myUsers[j].picture),
                                                                      fit: BoxFit.cover)),
                                                            ),
                                                        const SizedBox(width: 10),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              state.myUsers[j].Nom,
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
                                                                            .myUsers[j])));
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
                                                                    style: const TextStyle(
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
                                                                    style: const TextStyle(
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
                                                                    style: const TextStyle(
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
                                                                    style: const TextStyle(
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
                                                                              const TextStyle(
                                                                            decoration:
                                                                                TextDecoration
                                                                                    .underline,
                                                                          ))),
                                                                ),
                                                                Expanded(
                                                                  child: Center(
                                                                      child: Text(
                                                                    AppLocalizations.of(context)!.translate("Tonnage")!,
                                                                    style: const TextStyle(
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
                                                                    style: const TextStyle(
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
                                                return const SizedBox(width: 0,);
                                              }
                                            }
                                          );
                                      } else if(state is GetUsersLoading){
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else if(state is GetUsersfailure){
                                        return const Center(
                                          child: Text("Error user"),
                                        );
                                      }
                                      else{
                                        return const SizedBox(height: 0,);
                                      }
                                    },
                                  );
                                }),
                            const SizedBox(
                              height: 30,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                } else if (state is GetAnnonceClient.GetAnnonceLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if(state is GetAnnonceClient.GetAnnonceFaliure){
                  return const Center(
                    child: Text(
                      "Error!!!",
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                }
                else{
                  return const SizedBox(height: 0,);
                }
              },
            ),
            BlocBuilder<GetAnnonceTransporteur.GetAnnonceTransporteurBloc,
                GetAnnonceTransporteur.GetAnnonceTransporteurState>(
              builder: (context, state) {
                if (state is GetAnnonceTransporteur.GetAnnonceSuccess) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      await Future.delayed(Duration(seconds: 2));
                      setState(() {});
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Form(
                              key: _formKeyT,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 0),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 18),
                                      decoration: BoxDecoration(
                                          border: const Border(
                                              bottom: BorderSide(
                                                  color: Colors.black)),
                                          borderRadius:
                                              const BorderRadius.horizontal(
                                                  left: Radius.circular(15)),
                                          color: const Color.fromARGB(
                                                  255, 255, 255, 255)
                                              .withOpacity(.2)),
                                      child: DropdownButtonFormField(
                                        decoration:
                                            const InputDecoration.collapsed(
                                                hintText: ''),
                                        value: argsControllerTransp,
                                        hint: const Text(
                                          'Nom',
                                        ),
                                        isExpanded: true,
                                        onChanged: (value) {
                                          setState(() {
                                            argsControllerTransp = value!;
                                          });
                                        },
                                        onSaved: (value) {
                                          setState(() {
                                            argsControllerTransp = value!;
                                          });
                                        },
                                        validator: (String? value) {
                                          if (value == '') {
                                            return "can't empty";
                                          } else {
                                            return null;
                                          }
                                        },
                                        items:
                                            listOfValueTransp.map((String val) {
                                          return DropdownMenuItem(
                                            value: val,
                                            child: Text(val),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 6),
                                        decoration: BoxDecoration(
                                          border: const Border(
                                              bottom: BorderSide(
                                                  color: Colors.black)),
                                          color: const Color.fromARGB(
                                                  255, 255, 255, 255)
                                              .withOpacity(.2),
                                        ),
                                        child: TextFormField(
                                          style: const TextStyle(height: 1.5),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: AppLocalizations.of(context)!.translate('Search Annonce')!,
                                          ),
                                          controller: valueControllerTransp,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return AppLocalizations.of(context)!.translate('value is required')!;
                                            }
                                            return null;
                                          },
                                        )),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                        padding: const EdgeInsets.only(top: 12),
                                        decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black)),
                                          borderRadius: BorderRadius.horizontal(
                                              right: Radius.circular(15)),
                                        ),
                                        child: IconButton(
                                          icon: const Icon(Icons.search),
                                          onPressed: () {
                                            PersistentNavBarNavigator
                                                .pushNewScreen(
                                              context,
                                              screen: SearchAnnonce_Screen(
                                                  argsControllerTransp,
                                                  valueControllerTransp.text,
                                                  "Transporteur"),
                                              withNavBar: false,
                                              pageTransitionAnimation:
                                                  PageTransitionAnimation
                                                      .cupertino,
                                            );
                                          },
                                        )),
                                  ),
                                ],
                              )),
                          ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.annonces.length,
                            itemBuilder: (context, int i) {
                              final annonce = state.annonces[i];
                                return BlocBuilder<GetUsersBloc, GetUsersState>(
                                builder: (context, state) {
                                  if (state is GetUsersSuccess) {
                                      return ListView.builder(
                                        physics: const ClampingScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: state.myUsers.length,
                                        itemBuilder: (context, int j) {
                                          if (state.myUsers[j].user_id == annonce.userId) {
                                            return Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 20),
                                              Row(
                                                children: [
                                                  const SizedBox(width: 20,),
                                                  state.myUsers[j].picture == ""
                                                    ? Container(
                                                        width: 50,
                                                        height: 50,
                                                        decoration: const BoxDecoration(
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
                                                                    NetworkImage(state.myUsers[j].picture),
                                                                fit: BoxFit.cover)),
                                                      ),
                                                  const SizedBox(width: 10),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        state.myUsers[j].Nom,
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
                                                                Details_Transporteur(annonce, state.myUsers[j])));
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
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child: Center(
                                                                  child: Text(
                                                                AppLocalizations.of(context)!.translate("Ville de départ")!,
                                                                style: const TextStyle(
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
                                                                style: const TextStyle(
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
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child: Center(
                                                                  child: Text(
                                                                AppLocalizations.of(context)!.translate("Date de départ")!,
                                                                style: const TextStyle(
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
                                                                style: const TextStyle(
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
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child: Center(
                                                                  child: Text(
                                                                AppLocalizations.of(context)!.translate("N Vehicule")!,
                                                                style: const TextStyle(
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
                                                                style: const TextStyle(
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
                                                                style: const TextStyle(
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
                                          }else{
                                            return const SizedBox(width: 0,);
                                          }
                                        }
                                      );
                                  } else if(state is GetUsersLoading){
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if(state is GetUsersfailure){
                                    return const Center(
                                      child: Text("Error user"),
                                    );
                                  }
                                  else{
                                    return const SizedBox(height: 0,);
                                  }
                                },
                              );
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 2,
                          )
                        ],
                      ),
                    ),
                  );
                } else if (state is GetAnnonceTransporteur.GetAnnonceLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if(state is GetAnnonceTransporteur.GetAnnonceFaliure){
                  return const Center(
                    child: Text(
                      "Error!!!",
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                }
                else{
                  return const SizedBox(height: 0,);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
