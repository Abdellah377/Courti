// ignore_for_file: non_constant_identifier_names

import '../entities/entities.dart';

class MyUsers{
  String user_id;
  String Nom;
  String Type;
  String E_mail;
  String Telephone;
  String Password;
  num Rating;
  num NbRaters;

  MyUsers({
    required this.user_id,
    required this.Nom,
    required this.Type,
    required this.E_mail,
    required this.Telephone,
    required this.Password,
    required this.Rating,
    required this.NbRaters,
  });

  static final empty = MyUsers(
      user_id:'',
      Nom:'',
      Type:'',
      E_mail:'',
      Telephone:'',
      Password:'',
      Rating:0,
      NbRaters:0,
  );

  UsersEntity toEntity(){
    return UsersEntity(
      user_id: user_id,
      Nom: Nom,
      Type: Type,
      E_mail: E_mail,
      Telephone: Telephone,
      Password: Password,
      Rating: Rating,
      NbRaters: NbRaters,
    );
  }

  static MyUsers fromEntity(UsersEntity entity) {
    return MyUsers(
      user_id: entity.user_id, 
      Nom: entity.Nom, 
      Type: entity.Type,
      E_mail: entity.E_mail, 
      Telephone: entity.Telephone,
      Password: entity.Password,
      Rating: entity.Rating,
      NbRaters: entity.NbRaters,
      );
  }

      @override
  String toString() {
    return '''(user_id: $user_id, Nom: $Nom, Type: $Type, E_mail: $E_mail, Telephone: $Telephone)''';
  }
}