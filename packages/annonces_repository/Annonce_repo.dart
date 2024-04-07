import 'models/model_annonce.dart';

abstract class AnnonceRepo{
  Future<List<Annonces>> getAnnonces();
}