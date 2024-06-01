
// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class AnnoncesTransporteurEntity{
  String annonce_id;

  String Titre;
  String userId;
  String Details;
  String Ville_depart;
  String Ville_darrive;
  DateTime Date_depart;
  DateTime Date_darrive;
  DateTime Created_at;
  int NbreVehicule;
  double charge;
  double prix;

  AnnoncesTransporteurEntity({
    required this.annonce_id,
    required this.userId,
    required this.Titre,
    required this.Details,
    required this.Ville_depart,
    required this.Ville_darrive,
    required this.Date_depart,
    required this.Date_darrive,
    required this.Created_at,
    required this.NbreVehicule,
    required this.charge,
    required this.prix,
    });

     Map<String,Object?> toDocuments(){
    return{
      'annonce_id' : annonce_id,
      'userId': userId,
      'Titre': Titre,
      'Details': Details,
      'Ville_depart': Ville_depart,
      'Ville_darrive': Ville_darrive,
      'Date_depart': Date_depart,
      'Date_darrive': Date_darrive,
      'Created_at': Created_at,
      'NbreVehicule': NbreVehicule,
      'charge': charge,
      'prix': prix,
    };
  }

  static AnnoncesTransporteurEntity fromDocument(Map<String,dynamic> doc){
    return AnnoncesTransporteurEntity(
      annonce_id : doc['annonce_id'],
      userId: doc['userId'],
      Titre: doc['Titre'],
      Details: doc['Details'],
      Ville_depart: doc['Ville_depart'],
      Ville_darrive: doc['Ville_darrive'],
      Date_depart: (doc['Date_depart'] as Timestamp).toDate() ,
      Date_darrive: (doc['Date_darrive'] as Timestamp).toDate(),
      Created_at: (doc['Created_at'] as Timestamp).toDate(),
      NbreVehicule: doc['NbreVehicule'],
      charge: doc['charge'],
      prix: doc['prix'],
      );
  }

  List<Object?> get props =>[annonce_id,userId,Titre,Details,Ville_depart,Ville_darrive,Date_depart,Date_darrive,Created_at];
  
  @override
  String toString() {
    return '''AnnonceEntity: {
      'annonce_id' : $annonce_id
      'userId': $userId
      'Titre': $Titre
      'Details': $Details
      'Ville_depart': $Ville_depart
      'Ville_darrive': $Ville_darrive
      'Date_depart': $Date_depart
      'Date_darrive': $Date_darrive
      'Created_at': $Created_at
    }''';
  }

}