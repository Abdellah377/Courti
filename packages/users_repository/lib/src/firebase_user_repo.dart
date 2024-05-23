import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/user_repository.dart';
import 'package:rxdart/rxdart.dart';

class FirebaseUserRepo implements UserRepository {
  final FirebaseAuth _firebaseAuth;

  final userCollection = FirebaseFirestore.instance.collection('Users');
  var verificationId = '';

  FirebaseUserRepo({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Stream<MyUsers> get user {
    return _firebaseAuth.authStateChanges().flatMap((firebaseUser) async* {
      if (firebaseUser == null) {
        yield MyUsers.empty;
      } else {
        yield await userCollection.doc(firebaseUser.uid).get().then((value) =>
            MyUsers.fromEntity(UsersEntity.fromDocument(value.data()!)));
      }
    });
  }

  @override
  Future<void> signInEmail(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      log(e.toString() as num);
      rethrow;
    }
  }

  @override
  Future<void> signInPhone(String phone, String password) async {
    try {
      await _firebaseAuth.signInWithPhoneNumber("+212670729866");
    } catch (e) {
      print("WAAAAAAAAAAAAAAAAAAAAAAAAA: " + e.toString());
      rethrow;
    }
  }

  @override
  Future<void> phoneAuth(String num) async {
    print("[       num      ]: $num       ");
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: num,
      verificationCompleted: (credential) async {
        await _firebaseAuth.signInWithCredential(credential);
      },
      codeSent: (verificationId, resendToken) {
        this.verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        this.verificationId = verificationId;
      },
      verificationFailed: (e) {
        print("       [       ERROR:        ]       " + e.toString());
      },
    );
  }

  @override
  Future<bool> verifyOTP(String otp) async {
    var credentials = await _firebaseAuth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: otp));
    return credentials.user != null ? true : false;
  }

  @override
  Future<MyUsers> linkEmailToPhoneAuth(MyUsers myuser) async {
    User user = _firebaseAuth.currentUser!;
    AuthCredential credential = EmailAuthProvider.credential(
      email: myuser.E_mail,
      password: myuser.Password,
    );
    try {
      await user.linkWithCredential(credential);
      myuser.user_id = user.uid;
      print('Email linked successfully');
      return myuser;
    } on FirebaseAuthException catch (e) {
      print('Failed to link email: ${e.message}');
      rethrow;
    }
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> setUserData(MyUsers user) async {
    try {
      await userCollection.doc(user.user_id).set(user.toEntity().toDocuments());
    } catch (e) {
      log(e.toString() as num);
      rethrow;
    }
  }

  @override
  Future<MyUsers> getMyUser(String myUserId) async {
    try {
      return userCollection.doc(myUserId).get().then((value) =>
          MyUsers.fromEntity(UsersEntity.fromDocument(value.data()!)));
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<MyUsers>> getUsers() async {
    try {
      return await userCollection.get().then((value) => value.docs
          .map((e) => MyUsers.fromEntity(UsersEntity.fromDocument(e.data())))
          .toList());
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<MyUsers>> getUsersByArg(String args, String argvalue) async {
    try {
      return await userCollection.get()
    .then((value) => value.docs
        .where((doc) => doc.data()[args] == argvalue)
        .map((e) => MyUsers.fromEntity(UsersEntity.fromDocument(e.data())))
        .toList());
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
