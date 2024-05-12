
// ignore_for_file: non_constant_identifier_names

import 'package:user_repository/user_repository.dart';
import '../entities/annonce_client_entity.dart';

class AnnoncesClient{

  String annonce_id;
  MyUsers myUser;
  String Titre;
  String Details;
  String Ville_depart;
  String Ville_darrive;
  DateTime Date_depart;
  DateTime Date_darrive;
  DateTime Created_at;
  double prix;
  String TypeMarchandise;
  double tonnage;

  AnnoncesClient({
    required this.annonce_id,
    required this.myUser,
    required this.Titre,
    required this.Details,
    required this.Ville_depart,
    required this.Ville_darrive,
    required this.Date_depart,
    required this.Date_darrive,
    required this.Created_at,
    required this.prix,
    required this.TypeMarchandise,
    required this.tonnage,
    });

    static final empty = AnnoncesClient(
      annonce_id: '', 
      myUser: MyUsers.empty, 
      Titre: '', 
      Details: '', 
      Ville_depart: '', 
      Ville_darrive: '', 
      Date_depart: DateTime.now(), 
      Date_darrive: DateTime.now(), 
      Created_at: DateTime.now(),
      prix: 0,
      TypeMarchandise: '',
      tonnage: 0,
      );

    AnnoncesClientEntity toEntity(){
    return AnnoncesClientEntity(
      annonce_id : annonce_id,
      myUser: myUser,
      Titre: Titre,
      Details: Details,
      Ville_depart: Ville_depart,
      Ville_darrive: Ville_darrive,
      Date_depart: Date_depart,
      Date_darrive :Date_darrive,
      Created_at: Created_at,
      prix: prix,
      TypeMarchandise: TypeMarchandise,
      tonnage: tonnage,
    );
  }

  static AnnoncesClient fromEntity(AnnoncesClientEntity entity) {
    return AnnoncesClient(
      annonce_id: entity.annonce_id,
      myUser: entity.myUser, 
      Titre: entity.Titre, 
      Details: entity.Details,
      Ville_depart: entity.Ville_depart,
      Ville_darrive: entity.Ville_darrive,
      Date_depart: entity.Date_depart, 
      Date_darrive: entity.Date_darrive,
      Created_at: entity.Created_at,
      prix: entity.prix,
      TypeMarchandise: entity.TypeMarchandise,
      tonnage: entity.tonnage,
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