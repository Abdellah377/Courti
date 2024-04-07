
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'entities/entities.dart';
import 'models/MyUser.dart';
import 'user_repo.dart';
import 'package:rxdart/rxdart.dart';

class FirebaseUserRepo implements UserRepository{
  final FirebaseAuth _firebaseAuth;
  final userCollection = FirebaseFirestore.instance.collection('Users');

  FirebaseUserRepo({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Stream<MyUsers> get user {
    return _firebaseAuth.authStateChanges().flatMap((FirebaseUser) async* {
      if(FirebaseUser == null){
        yield MyUsers.empty;
      }
      else{
        yield await userCollection
        .doc(FirebaseUser.uid)
        .get()
        .then((value) => MyUsers.fromEntity(UsersEntity.fromDocument(value.data()!)));
      }
    });
  }
  
  @override
  Future<void> signInEmail(String email, String password) async {
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<MyUsers> signUp(MyUsers myuser) async {
    try{
      UserCredential user =  await _firebaseAuth.createUserWithEmailAndPassword(email: myuser.E_mail, password: myuser.Password);
      myuser.user_id = user.user!.uid;
      return myuser;
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<void> logOut() async{
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> setUserData(MyUsers user) async{
    try{
      await userCollection.doc(user.user_id).set(user.toEntity().toDocuments());
    }catch(e){
      rethrow;
    }
  }

}

