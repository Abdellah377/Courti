
import '../entities/entities.dart';

class MyUsers{
  String user_id;
  String Nom;
  String Prenom;
  String E_mail;
  String Telephone;
  String Password;

  MyUsers({
    required this.user_id,
    required this.Nom,
    required this.Prenom,
    required this.E_mail,
    required this.Telephone,
    required this.Password,
  });

  static final empty = MyUsers(
      user_id:'',
      Nom:'',
      Prenom:'',
      E_mail:'',
      Telephone:'',
      Password:'',
  );

  UsersEntity toEntity(){
    return UsersEntity(
      user_id: user_id,
      Nom: Nom,
      Prenom: Prenom,
      E_mail: E_mail,
      Telephone: Telephone,
      Password: Password,
    );
  }

  static MyUsers fromEntity(UsersEntity entity) {
    return MyUsers(
      user_id: entity.user_id, 
      Nom: entity.Nom, 
      Prenom: entity.Prenom,
      E_mail: entity.E_mail, 
      Telephone: entity.Telephone,
      Password: entity.Password
      );
  }
}