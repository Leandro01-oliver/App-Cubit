import 'package:produtividade/app/http/produtividade_http.dart';
import 'package:produtividade/app/models/produtividade_model.dart';

class ProdutividadeRepositorye{
  final ProdutividadeHttp produtividadeHttp = ProdutividadeHttp();

  Future<ProdutividadeModel> create({required ProdutividadeModel produtividadeData}) async{
     ProdutividadeModel produtividade = await produtividadeHttp.createProdutividade(produtividadeModel: produtividadeData);
    return produtividade;
  }

  Future<ProdutividadeModel> updateById({required ProdutividadeModel produtividadeModel}) async{
    ProdutividadeModel produtividade = await produtividadeHttp.updateProdutividade(produtividadeModel: produtividadeModel);
    return produtividade;
  }

  Future<ProdutividadeModel> deleteById({required int id})async {
    ProdutividadeModel produtividade = await produtividadeHttp.deleteProdutividade(id: id);
    return produtividade;
  }
  
  Future<List<ProdutividadeModel>> getAll() async{
    List<ProdutividadeModel> produtividades = await produtividadeHttp.getProdutividade();
    return produtividades;
  }
  
}