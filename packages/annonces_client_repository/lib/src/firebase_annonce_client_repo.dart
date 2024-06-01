import 'package:annonce_client_repository/annonce_client_repository.dart';
import 'package:uuid/uuid.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAnnonceClientRepo implements AnnonceClientRepo {
  final annonceCollection =
      FirebaseFirestore.instance.collection('Annonces_Client');

  @override
  Future<List<AnnoncesClient>> getAnnoncesClient() async {
    try {
      return await annonceCollection.get().then((value) => value.docs
          .map((e) => AnnoncesClient.fromEntity(
              AnnoncesClientEntity.fromDocument(e.data())))
          .toList());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<AnnoncesClient>> getAnnoncesClientByUser(String userId) async {
    try {
      return await annonceCollection
    .get()
    .then((value) => value.docs
        .where((doc) => doc.data()['userId'] == userId)
        .map((e) => AnnoncesClient.fromEntity(AnnoncesClientEntity.fromDocument(e.data())))
        .toList());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AnnoncesClient> addAnnonceClient(AnnoncesClient annonce) async {
    try {
      annonce.annonce_id = const Uuid().v1();
      annonce.Created_at = DateTime.now();
      await annonceCollection
          .doc(annonce.annonce_id)
          .set(annonce.toEntity().toDocuments());
      return annonce;
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<List<AnnoncesClient>> getAnnoncesClientByArgs(String arg, String argValue) async{
    try {
      return await annonceCollection
      .get()
      .then((value) => value.docs
          .where((doc) => doc.data()[arg] == argValue)
          .map((e) => AnnoncesClient.fromEntity(AnnoncesClientEntity.fromDocument(e.data())))
          .toList());
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
  
  @override
  Future<AnnoncesClient> setAnnonceClient(AnnoncesClient annonce) async {
    try {
      await annonceCollection
          .doc(annonce.annonce_id)
          .set(annonce.toEntity().toDocuments());
      return annonce;
    } catch (e) {
      rethrow;
    }
  }
}
