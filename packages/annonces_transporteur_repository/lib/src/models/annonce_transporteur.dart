
// ignore_for_file: non_constant_identifier_names

import 'package:user_repository/user_repository.dart';
import '../entities/annonce_transporteur_entity.dart';

class AnnoncesTransporteur{

  String annonce_id;
  MyUsers myUser;
  String Titre;
  String Details;
  String Ville_depart;
  String Ville_darrive;
  DateTime Date_depart;
  DateTime Date_darrive;
  DateTime Created_at;
  int NbreVehicule;
  double charge;
  double prix;


  AnnoncesTransporteur({
    required this.annonce_id,
    required this.myUser,
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

    static final empty = AnnoncesTransporteur(
      annonce_id: '', 
      myUser: MyUsers.empty, 
      Titre: '', 
      Details: '', 
      Ville_depart: '', 
      Ville_darrive: '', 
      NbreVehicule: 0,
      charge: 0,
      prix: 0,
      Date_depart: DateTime.now(), 
      Date_darrive: DateTime.now(), 
      Created_at: DateTime.now()
      );

    AnnoncesTransporteurEntity toEntity(){
    return AnnoncesTransporteurEntity(
      annonce_id : annonce_id,
      myUser: myUser,
      Titre: Titre,
      Details: Details,
      Ville_depart: Ville_depart,
      Ville_darrive: Ville_darrive,
      Date_depart: Date_depart,
      Date_darrive :Date_darrive,
      Created_at: Created_at,
      NbreVehicule: NbreVehicule,
      charge: charge,
      prix: prix,
    );
  }

  static AnnoncesTransporteur fromEntity(AnnoncesTransporteurEntity entity) {
    return AnnoncesTransporteur(
      annonce_id: entity.annonce_id,
      myUser: entity.myUser, 
      Titre: entity.Titre, 
      Details: entity.Details,
      Ville_depart: entity.Ville_depart,
      Ville_darrive: entity.Ville_darrive,
      Date_depart: entity.Date_depart, 
      Date_darrive: entity.Date_darrive,
      Created_at: entity.Created_at,
      NbreVehicule:entity.NbreVehicule,
      charge:entity.charge,
      prix:entity.prix,
      );
  }

    @override
      String toString() {
    return '''Annonce: {
      'annonce_id' : $annonce_id
      'myUser': $myUser
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