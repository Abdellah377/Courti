import 'models/model_annonce_client.dart';

abstract class AnnonceClientRepo{
  Future<List<AnnoncesClient>> getAnnoncesClient();

  Future<List<AnnoncesClient>> getAnnoncesClientByUser(String userId);

  Future<List<AnnoncesClient>> getAnnoncesClientByArgs(String arg, String argValue);
  
  Future<AnnoncesClient> addAnnonceClient(AnnoncesClient annonce);

  Future<AnnoncesClient> setAnnonceClient(AnnoncesClient annonce);
}