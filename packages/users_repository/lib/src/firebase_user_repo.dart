// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
      await _firebaseAuth.signInWithPhoneNumber(phone);
    } catch (e) {
      print(e.toString());
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
        print(e.toString());
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
  Future<bool> verifyUpdateOTP(String otp) async {
    try {
      await _firebaseAuth.currentUser!.updatePhoneNumber(
        PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otp));
        return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
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
  
  @override
  Future<void> setEmail(MyUsers myUser, String email) async {
    try {
      User user = _firebaseAuth.currentUser!;

      AuthCredential credential = EmailAuthProvider.credential(
        email: myUser.E_mail,
        password: myUser.Password,
      );
      await user.reauthenticateWithCredential(credential);

      await user.verifyBeforeUpdateEmail(email);

      const checkInterval = Duration(seconds: 5);
      try {
        Timer.periodic(checkInterval, (timer) async {
          User updatedUser = _firebaseAuth.currentUser!;
          await updatedUser.reload();
          if (user.emailVerified && updatedUser.email == email) {
            print("     [       GOOD       ]       ");
            timer.cancel();
            myUser.E_mail = email;
            await setUserData(myUser); 
          }
          else{
            print("     [       WAITING       ]       ");
          }
        });
      } catch (e) {
        print("     [       MEH       ]       ");
        UserCredential newUserCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: myUser.Password,
        );
        User newUser = newUserCredential.user!;
        await newUser.reload();
        myUser.E_mail = email;
        await setUserData(myUser); 
      }
    } catch (e) {
      print(e.toString());
    }
  }



  
  @override
  Future<void> setPhoneNumber(MyUsers myUser,String phoneNumber) async{
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        // timeout: const Duration(minutes: 1),

        verificationCompleted: (credential) async {
          await _firebaseAuth.currentUser!.updatePhoneNumber(credential);

        },

        codeSent: (verificationId, [forceResendingToken]) async {
          this.verificationId = verificationId;
        },

        codeAutoRetrievalTimeout: (String verificationId) {
          this.verificationId = verificationId;
        },

        verificationFailed: (e){
          print(e.toString());
        }, 
      );
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
  
  @override
  Future <User> getCurrentUser() async{
    User user = _firebaseAuth.currentUser!;
    return user;
  }
  
  @override
  Future<void> setPassword(MyUsers myUser, String password) async{
    try {
      User user = _firebaseAuth.currentUser!;
      await user.reauthenticateWithCredential(
        EmailAuthProvider.credential(
          email: myUser.E_mail,
          password: myUser.Password
        )
      );

      await user.updatePassword(password);

      myUser.Password = password;
      await setUserData(myUser);
    } catch (e) {
      print(e.toString());
    }

  }
  
  @override
  Future<String> UploadPicture(String file, String userId) async{
    try {

      File imageFile = File(file);
      Reference firebaseStoreRef = FirebaseStorage.instance.ref().child('$userId/PP/${userId}_lead');

      await firebaseStoreRef.putFile(imageFile);
      String url = await firebaseStoreRef.getDownloadURL();
      await userCollection.doc(userId).update({'picture': url});
      return url;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}