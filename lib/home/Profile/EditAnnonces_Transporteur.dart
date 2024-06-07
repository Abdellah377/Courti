// ignore_for_file: non_constant_identifier_names

import 'package:annonce_transporteur_repository/annonce_transporteur_repository.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kourti_application_1/Blocs/AnnonceTransporteurBlocs/add_annonce_transporteur_bloc/add_annonce_transporteur_bloc.dart';
import 'package:kourti_application_1/app_language_provider.dart';
import 'package:kourti_application_1/app_localizations.dart';
import 'package:provider/provider.dart';

class EditAnnonces_Transporteur extends StatefulWidget {
  final AnnoncesTransporteur annoncesTransporteur;
  const EditAnnonces_Transporteur(this.annoncesTransporteur, {super.key});

  @override
  State<EditAnnonces_Transporteur> createState() => _EditAnnonces_TransporteurState();
}

class _EditAnnonces_TransporteurState extends State<EditAnnonces_Transporteur> {
  late AnnoncesTransporteur annonce;

  var TitleController = TextEditingController();
  var DetailsController = TextEditingController();
  var Ville_DepartController = TextEditingController();
  var Ville_DarriveController = TextEditingController();
  var Date_DepartController = TextEditingController();
  var Date_DarriveController = TextEditingController();
  var NbreVehiculeController = TextEditingController();
  var chargeController = TextEditingController();
  var prixController = TextEditingController();

  final format = DateFormat("yyyy-MM-dd HH:mm");

  bool depart = false;

  final _formKey = GlobalKey<FormState>();

    late AppLanguageProvider appLanguage;


  @override
  void initState() {
    annonce = widget.annoncesTransporteur;
    TitleController = TextEditingController(text: annonce.Titre);
    DetailsController = TextEditingController(text: annonce.Details);
    Ville_DepartController = TextEditingController(text: annonce.Ville_depart);
    Ville_DarriveController = TextEditingController(text: annonce.Ville_darrive);
    Date_DepartController = TextEditingController(text: format.format(annonce.Date_depart));
    Date_DarriveController = TextEditingController(text: format.format( annonce.Date_darrive));
    NbreVehiculeController = TextEditingController(text: annonce.NbreVehicule.toString());
    chargeController = TextEditingController(text: annonce.charge.toString());
    prixController = TextEditingController(text: annonce.prix.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    appLanguage = Provider.of<AppLanguageProvider>(context);

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
            AppLocalizations.of(context)!.translate("Modifier Votre Annonce Transporteur")!,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            margin: const EdgeInsets.only(top: 10.0, bottom: 50.0),
            width: double.infinity,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 35),
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
                          labelText: AppLocalizations.of(context)!.translate('Titre')!,
                        ),
                        controller: TitleController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!.translate('Title is required')!;
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
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: AppLocalizations.of(context)!.translate('Ville de départ')!,
                              ),
                              controller: Ville_DepartController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return  AppLocalizations.of(context)!.translate('Ville is required')!;
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
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: AppLocalizations.of(context)!.translate("Ville d'arrivée")!,
                              ),
                              controller: Ville_DarriveController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return AppLocalizations.of(context)!.translate("Ville is required")!;
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
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: AppLocalizations.of(context)!.translate('Date de départ')!,
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
                            value = annonce.Date_darrive;
                            return null;
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
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: AppLocalizations.of(context)!.translate("Date d'arrivée")!,
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
                            value = annonce.Date_darrive;
                            return null;
                          }
                          DateTime arrive =
                              DateTime.parse((Date_DepartController.text));
                          if (depart == true) {
                            if (value.isBefore(arrive)) {
                              return AppLocalizations.of(context)!.translate("Date d'arrivé avant date de départ!")!;
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
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: AppLocalizations.of(context)!.translate("N Vehicule")!,
                              ),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: NbreVehiculeController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!.translate("value is required")!;
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
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: AppLocalizations.of(context)!.translate("Charge")!,
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: chargeController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return AppLocalizations.of(context)!.translate("Charge is required")!;
                                }
                                return null;
                              },
                            )),
                      ),
                      const Expanded(
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
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: AppLocalizations.of(context)!.translate("Prix")!,
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: prixController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return AppLocalizations.of(context)!.translate("Prix is required")!;
                                }
                                return null;
                              },
                            )),
                      ),
                      const Expanded(
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
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: AppLocalizations.of(context)!.translate("Details")!,
                        ),
                        controller: DetailsController,
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    child: Container(
                      padding: const EdgeInsets.only(top: 3, left: 3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: const Offset(0, 2), // changes position of shadow
                          ),
                        ],
                        border: const Border(
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
                                context.read<AddAnnonceTransporteurBloc>().add(SetAnnonceTransporteur(annonce));
                              });
                            }
                          },
                          color: const Color(0xff0095FF),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.send_rounded,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 15),
                              Text(
                                AppLocalizations.of(context)!.translate("Envoier")!,
                                style: const TextStyle(
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
