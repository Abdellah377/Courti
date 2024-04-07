
import 'dart:math';

import 'Annonce_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAnnonceRepo implements AnnonceRepo{
  final annonceCollection = FirebaseFirestore.instance.collection('Annonces');

  Future<List<Annonces>> getAnnonces() async {
    try {
      return await annonceCollection
      .get()
      .then((value) => value.docs.map((e) => 
        Annonces.fromEntity(AnnoncesEntity.fromDocument(e.data()))
      ).toList());
    } catch (e) {
      log(e.toString() as num);
      rethrow;
    }
  }
}