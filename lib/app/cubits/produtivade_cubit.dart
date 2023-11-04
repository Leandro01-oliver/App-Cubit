import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:produtividade/app/models/produtividade_model.dart';
// import 'package:produtividade/app/models/produtividade_model.dart';

import '../repositorye/produtividade_repositorye.dart';
import 'produtividade_states.dart';

class ProdutividadeCubit extends Cubit<ProdutividadesState> {
  final ProdutividadeRepositorye repository;
  ProdutividadeCubit({required this.repository}) : super(InitialState()) {
    getProdutividade();
  }

  void getProdutividade() async {
    try {
      emit(LoadingState());
      final produtividades = await repository.getAll();
      emit(LoadedState(produtividades));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  void createProdutividade(
      {required ProdutividadeModel produtividadeModel}) async {
    try {
      await repository.create(produtividadeData: produtividadeModel);
      Fluttertoast.showToast(
          msg: "Produtividade criada com sucesso!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color.fromARGB(150, 76, 175, 79),
          textColor: const Color.fromARGB(255, 0, 0, 0),
          fontSize: 16.0
      );
      emit(LoadingState());
      final produtividades = await repository.getAll();
      emit(LoadedState(produtividades));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  void updateProdutividade(
      {required ProdutividadeModel produtividadeModel}) async {
    try {
      await repository.updateById(produtividadeModel: produtividadeModel);
      Fluttertoast.showToast(
          msg: "Produtividade editada com sucesso!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color.fromARGB(150, 76, 175, 79),
          textColor: const Color.fromARGB(255, 0, 0, 0),
          fontSize: 16.0
      );
      emit(LoadingState());
      final produtividades = await repository.getAll();
      emit(LoadedState(produtividades));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  void deleteProdutividade({required int id}) async {
    try {
      await repository.deleteById(id: id);
      Fluttertoast.showToast(
          msg: "Produtividade excluída com sucesso!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color.fromARGB(150, 76, 175, 79),
          textColor: const Color.fromARGB(255, 0, 0, 0),
          fontSize: 16.0
      );
      emit(LoadingState());
      final produtividades = await repository.getAll();
      emit(LoadedState(produtividades));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
