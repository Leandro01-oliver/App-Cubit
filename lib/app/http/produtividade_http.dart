import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:produtividade/app/models/produtividade_model.dart';

class ProdutividadeHttp {
  final _dio = Dio();
  final String _baseUrl = 'http://192.168.0.151:3000/api/produtividade';

  Future<List<ProdutividadeModel>> getProdutividade() async {
    var url = "$_baseUrl/get";
    List<ProdutividadeModel> data = [];
    try {
      Response response = await _dio.get(url);
      if (response.statusCode == 200) {
        data = (response.data as List)
            .map(
                (produtividades) => ProdutividadeModel.fromJson(produtividades))
            .toList();
      }
    } catch (error, stackTrace) {
      throw Exception(
          "Ocorreu um erro na requisição. objeto de error : $error. o stackTrace de error : $stackTrace");
    }

    return data;
  }

  Future<ProdutividadeModel> createProdutividade(
      {required ProdutividadeModel produtividadeModel}) async {
    try {
      Response response = await _dio.post('$_baseUrl/post',
          data: json.encode(produtividadeModel.toJson()));
      if (response.statusCode == 201) {
        Map<String, dynamic> jsonData = response.data;
        return ProdutividadeModel.fromJson(jsonData);
      } else {
        return throw Exception("nada");
      }
    } catch (error, stackTrace) {
      throw Exception(
          "Ocorreu um erro na requisição. objeto de error : $error. o stackTrace de error : $stackTrace");
    }
  }

  Future<ProdutividadeModel> updateProdutividade(
      {required ProdutividadeModel produtividadeModel}) async {
    try {
      Response response = await _dio.put('$_baseUrl/put',
          data: json.encode(produtividadeModel.toJson()));
      if (response.statusCode == 201) {
        Map<String, dynamic> jsonData = response.data;
        return ProdutividadeModel.fromJson(jsonData);
      } else {
        return throw Exception("nada");
      }
    } catch (error, stackTrace) {
      throw Exception(
          "Ocorreu um erro na requisição. objeto de error : $error. o stackTrace de error : $stackTrace");
    }
  }

  Future<ProdutividadeModel> deleteProdutividade({required int id}) async {
    try {
          var produtividades = await getProdutividade();
    ProdutividadeModel produtividadeSelecionada =
        produtividades.where((x) => x.id == id).first;
    Response response = await _dio.delete('$_baseUrl/delete',
        data: json.encode(produtividadeSelecionada.toJson()));
    if (response.statusCode == 202) {
      Map<String, dynamic> jsonData = response.data;
      return ProdutividadeModel.fromJson(jsonData);
    } else {
      return throw Exception("nada");
    }
    }  catch (error, stackTrace) {
          throw Exception("Ocorreu um erro na requisição. objeto de error : $error. o stackTrace de error : $stackTrace");
    }
  }
}
