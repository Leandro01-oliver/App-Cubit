import '../../models/produtividade_model.dart' show ProdutividadeModel;

// ignore: camel_case_types
abstract class iProdutividade {
  Future<List<ProdutividadeModel>> getAll();
  Future<ProdutividadeModel> create({required ProdutividadeModel produtividade});
  Future<void> deleteById({required int id});
}