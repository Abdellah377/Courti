
class AnnoncesEntity{
  String annonce_id;
  String user_id;
  String Titre;
  String Details;
  String Ville_depart;
  String Ville_darrive;
  String Date_depart;
  String Date_darrive;

  AnnoncesEntity({
    required this.annonce_id,
    required this.user_id,
    required this.Titre,
    required this.Details,
    required this.Ville_depart,
    required this.Ville_darrive,
    required this.Date_depart,
    required this.Date_darrive,
    });

     Map<String,Object?> toDocuments(){
    return{
      'annonce_id' : annonce_id,
      'user_id': user_id,
      'Titre': Titre,
      'Details': Details,
      'Ville_depart': Ville_depart,
      'Ville_darrive': Ville_darrive,
      'Date_depart': Date_depart,
      'Date_darrive': Date_darrive,
    };
  }

  static AnnoncesEntity fromDocument(Map<String,dynamic> doc){
    return AnnoncesEntity(
      annonce_id : doc['annonce_id'],
      user_id: doc['user_id'],
      Titre: doc['Titre'],
      Details: doc['Details'],
      Ville_depart: doc['Ville_depart'],
      Ville_darrive: doc['Ville_darrive'],
      Date_depart: doc['Date_depart'],
      Date_darrive: doc['Date_darrive'],
      );
  }
}