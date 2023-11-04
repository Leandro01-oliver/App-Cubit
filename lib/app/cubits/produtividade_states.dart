import 'package:equatable/equatable.dart';

import '../models/produtividade_model.dart';

abstract class ProdutividadesState extends Equatable {}

class InitialState extends ProdutividadesState {
  @override
  List<Object> get props => [];
}
class LoadingState extends ProdutividadesState {
  @override
  List<Object> get props => [];
}
class LoadedState extends ProdutividadesState {
  LoadedState(this.produtividades);
  
  final List<ProdutividadeModel> produtividades;
  
  @override
  List<Object> get props => [produtividades];
}
class ErrorState extends ProdutividadesState {
  final String erro;
  ErrorState(this.erro);
  @override
  List<Object> get props => [];
}