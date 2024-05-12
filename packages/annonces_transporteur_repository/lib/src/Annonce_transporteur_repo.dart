import 'models/model_annonce_transporteur.dart';

abstract class AnnonceTransporteurRepo {
  Future<List<AnnoncesTransporteur>> getAnnoncesTransporteur();
  
  Future<List<AnnoncesTransporteur>> getAnnoncesTransporteurByUser(String userid);
  
  Future<AnnoncesTransporteur> addAnnonceTransporteur(AnnoncesTransporteur annonce);
}