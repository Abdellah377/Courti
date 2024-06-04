
// ignore_for_file: non_constant_identifier_names

class UsersEntity{
  String user_id;
  String Nom;
  String Type;
  String E_mail;
  String Telephone;
  String Password;
  num Rating;
  num NbRaters;

  UsersEntity({
    required this.user_id,
    required this.Nom,
    required this.Type,
    required this.E_mail,
    required this.Telephone,
    required this.Password,
    required this.Rating,
    required this.NbRaters,
  });

  Map<String,Object?> toDocuments(){
    return{
      'user_id': user_id,
      'Nom': Nom,
      'Type': Type,
      'E_mail': E_mail,
      'Telephone': Telephone,
      'Password': Password,
      'Rating': Rating,
      'NbRaters': NbRaters,
    };
  }

  static UsersEntity fromDocument(Map<String,dynamic> doc){
    return UsersEntity(
      user_id: doc['user_id'],
      Nom: doc['Nom'],
      Type: doc['Type'],
      E_mail: doc['E_mail'], 
      Telephone: doc['Telephone'], 
      Password: doc['Password'],
      Rating: doc['Rating'],
      NbRaters: doc['NbRaters'],
      );
  }
}