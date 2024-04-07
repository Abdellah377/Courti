
import '../entities/annonce_entity.dart';

class Annonces{

  String annonce_id;
  String user_id;
  String Titre;
  String Details;
  String Ville_depart;
  String Ville_darrive;
  String Date_depart;
  String Date_darrive;

  Annonces({
    required this.annonce_id,
    required this.user_id,
    required this.Titre,
    required this.Details,
    required this.Ville_depart,
    required this.Ville_darrive,
    required this.Date_depart,
    required this.Date_darrive,
    });

    AnnoncesEntity toEntity(){
    return AnnoncesEntity(
      annonce_id : annonce_id,
      user_id: user_id,
      Titre: Titre,
      Details: Details,
      Ville_depart: Ville_depart,
      Ville_darrive: Ville_darrive,
      Date_depart: Date_depart,
      Date_darrive :Date_darrive,
    );
  }

  static Annonces fromEntity(AnnoncesEntity entity) {
    return Annonces(
      annonce_id: entity.annonce_id,
      user_id: entity.user_id, 
      Titre: entity.Titre, 
      Details: entity.Details,
      Ville_depart: entity.Ville_depart,
      Ville_darrive: entity.Ville_darrive,
      Date_depart: entity.Date_depart, 
      Date_darrive: entity.Date_darrive,
      );
  }
}