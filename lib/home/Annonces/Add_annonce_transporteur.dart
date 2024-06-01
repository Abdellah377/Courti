// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_local_variable, use_build_context_synchronously

import 'package:annonce_transporteur_repository/annonce_transporteur_repository.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kourti_application_1/Blocs/AnnonceTransporteurBlocs/add_annonce_transporteur_bloc/add_annonce_transporteur_bloc.dart';

class AnnonceAdd_Transporteur extends StatefulWidget {
  final String userId;
  const AnnonceAdd_Transporteur(this.userId, {super.key});

  @override
  State<AnnonceAdd_Transporteur> createState() =>
      _AnnonceAdd_TransporteurState();
}

class _AnnonceAdd_TransporteurState extends State<AnnonceAdd_Transporteur> {
  late AnnoncesTransporteur annonce;

  final TitleController = TextEditingController();
  final DetailsController = TextEditingController();
  final Ville_DepartController = TextEditingController();
  final Ville_DarriveController = TextEditingController();
  final Date_DepartController = TextEditingController();
  final Date_DarriveController = TextEditingController();
  final NbreVehiculeController = TextEditingController();
  final chargeController = TextEditingController();
  final prixController = TextEditingController();

  final format = DateFormat("yyyy-MM-dd HH:mm");

  bool depart = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    annonce = AnnoncesTransporteur.empty;
    annonce.userId = widget.userId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddAnnonceTransporteurBloc, AddAnnonceTransporteurState>(
      listener: (context, state) {
        if(state is AddAnnonceSuccess){
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          centerTitle: true,
          title: Text(
            "Ajouter une Annonce Transporteur",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            margin: EdgeInsets.only(top: 10.0, bottom: 50.0),
            width: double.infinity,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 35),
                  Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.deepPurple.withOpacity(.2)),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: "Titre",
                        ),
                        controller: TitleController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Title is required";
                          }
                          return null;
                        },
                      )),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.deepPurple.withOpacity(.2),
                            ),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                labelText: "Ville départ",
                              ),
                              controller: Ville_DepartController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Ville is required";
                                }
                                return null;
                              },
                            )),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.deepPurple.withOpacity(.2)),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                labelText: "Ville d'arrivé",
                              ),
                              controller: Ville_DarriveController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Ville is required";
                                }
                                return null;
                              },
                            )),
                      ),
                    ],
                  ),
                  Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.deepPurple.withOpacity(.2)),
                      child: DateTimeField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: "Date départ",
                        ),
                        format: format,
                        onShowPicker: (context, currentValue) async {
                          final date = await showDatePicker(
                            context: context,
                            firstDate: DateTime(2024),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100),
                          );
                          if (date != null) {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(
                                  currentValue ?? DateTime.now()),
                            );
                            if (time != null) {
                              return DateTimeField.combine(date, time);
                            }
                          }
                          return currentValue;
                        },
                        controller: Date_DepartController,
                        validator: (value) {
                          if (value == null) {
                            depart == false;
                            return "Date is required";
                          }
                          depart = true;
                          return null;
                        },
                      )),
                  Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.deepPurple.withOpacity(.2)),
                      child: DateTimeField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: "Date d'arrivé",
                        ),
                        format: format,
                        onShowPicker: (context, currentValue) async {
                          final date = await showDatePicker(
                            context: context,
                            firstDate: DateTime(2024),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100),
                          );
                          if (date != null) {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(
                                  currentValue ?? DateTime.now()),
                            );
                            if (time != null) {

                              return DateTimeField.combine(date, time);
                            }
                          }
                          return currentValue;
                        },
                        controller: Date_DarriveController,
                        validator: (value) {
                          if (value == null) {
                            return "Date is required";
                          }
                          DateTime arrive =
                              DateTime.parse((Date_DepartController.text));
                          if (depart == true) {
                            if (value.isBefore(arrive)) {
                              return "Date d'arrivé avant date de départ";
                            }
                          }
                          return null;
                        },
                      )
                    ),
                    Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.deepPurple.withOpacity(.2),
                          ),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: "Nombre de véhicule",
                              ),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: NbreVehiculeController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Numbre is required";
                              }
                              return null;
                            },
                          )
                      ),
                    Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Container(
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.deepPurple.withOpacity(.2)),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                labelText: "Charge",
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: chargeController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "charge is required";
                                }
                                return null;
                              },
                            )),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text("Kg",style: TextStyle(fontSize: 18),)
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.deepPurple.withOpacity(.2),
                            ),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                labelText: "Prix",
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: prixController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "prix is required";
                                }
                                return null;
                              },
                            )),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text("Dh",style: TextStyle(fontSize: 18),)
                      ),
                    ],
                  ),
                    Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.deepPurple.withOpacity(.2)),
                      child: TextFormField(
                        maxLines: 5,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: "Details",
                        ),
                        controller: DetailsController,
                      )),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    child: Container(
                      padding: EdgeInsets.only(top: 3, left: 3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(0, 2), // changes position of shadow
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
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                annonce.Titre = TitleController.text;
                                annonce.Ville_darrive = Ville_DarriveController.text;
                                annonce.Ville_depart = Ville_DepartController.text;
                                annonce.Date_depart = DateTime.parse(Date_DepartController.text);
                                annonce.Date_darrive = DateTime.parse(Date_DarriveController.text);
                                annonce.NbreVehicule = int.parse(NbreVehiculeController.text);
                                annonce.charge = double.parse(chargeController.text);
                                annonce.prix = double.parse(prixController.text);
                                annonce.Details = DetailsController.text;
                                context.read<AddAnnonceTransporteurBloc>().add(AddAnnonceTransporteur(annonce));
                              });
                            }
                          },
                          color: Color(0xff0095FF),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.send_rounded,
                                color: Colors.white,
                              ),
                              SizedBox(width: 15),
                              Text(
                                "Envoier",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
