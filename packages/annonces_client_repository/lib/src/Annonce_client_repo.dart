import 'models/model_annonce_client.dart';

abstract class AnnonceClientRepo{
  Future<List<AnnoncesClient>> getAnnoncesClient();

  Future<List<AnnoncesClient>> getAnnoncesClientByUser(String userId);
  
  Future<AnnoncesClient> addAnnonceClient(AnnoncesClient annonce);
}