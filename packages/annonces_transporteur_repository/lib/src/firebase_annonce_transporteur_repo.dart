import 'package:annonce_transporteur_repository/annonce_transporteur_repository.dart';
import 'package:uuid/uuid.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAnnonceTransporteurRepo implements AnnonceTransporteurRepo{
  final annonceCollection = FirebaseFirestore.instance.collection('Annonces_Transporteur');

  @override
  Future<List<AnnoncesTransporteur>> getAnnoncesTransporteur() async {
    try {
      return await annonceCollection
      .get()
      .then((value) => value.docs.map((e) => 
        AnnoncesTransporteur.fromEntity(AnnoncesTransporteurEntity.fromDocument(e.data()))
      ).toList());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<AnnoncesTransporteur>> getAnnoncesTransporteurByUser(String userid) async{
    try {
      return await annonceCollection
    .get()
    .then((value) => value.docs
        .where((doc) => doc.data()['userId'] == userid)
        .map((e) => AnnoncesTransporteur.fromEntity(AnnoncesTransporteurEntity.fromDocument(e.data())))
        .toList());
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<AnnoncesTransporteur> addAnnonceTransporteur(AnnoncesTransporteur annonce) async {
    try {
      annonce.annonce_id = const Uuid().v1();
      annonce.Created_at = DateTime.now();
      await annonceCollection.doc(annonce.annonce_id).set(annonce.toEntity().toDocuments());
      return annonce;
    } catch (e) {
      rethrow;
    }

  }
  
  @override
  Future<List<AnnoncesTransporteur>> getAnnoncesTransporteurByArgs(String arg, String argValue) async{
    try {
      return await annonceCollection
    .get()
    .then((value) => value.docs
        .where((doc) => doc.data()[arg] == argValue)
        .map((e) => AnnoncesTransporteur.fromEntity(AnnoncesTransporteurEntity.fromDocument(e.data())))
        .toList());
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<AnnoncesTransporteur> setAnnonceTransporteur(AnnoncesTransporteur annonce) async {
    try {
      await annonceCollection.doc(annonce.annonce_id).set(annonce.toEntity().toDocuments());
      return annonce;
    } catch (e) {
      rethrow;
    }

  }

}