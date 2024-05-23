import 'models/model_annonce_transporteur.dart';

abstract class AnnonceTransporteurRepo {
  Future<List<AnnoncesTransporteur>> getAnnoncesTransporteur();
  
  Future<List<AnnoncesTransporteur>> getAnnoncesTransporteurByUser(String userid);

  Future<List<AnnoncesTransporteur>> getAnnoncesTransporteurByArgs(String arg, String argValue);
  
  Future<AnnoncesTransporteur> addAnnonceTransporteur(AnnoncesTransporteur annonce);

  Future<AnnoncesTransporteur> setAnnonceTransporteur(AnnoncesTransporteur annonce);

}