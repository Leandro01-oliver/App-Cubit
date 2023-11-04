import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:produtividade/app/cubits/produtivade_cubit.dart';

import '../cubits/produtividade_states.dart';
import '../models/produtividade_model.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  TextEditingController controllerDescriptonEdite = TextEditingController();

  Future<void> _formCreateBuilder(BuildContext context,
      {required ProdutividadeCubit metodoCriar}) {
    controllerDescriptonEdite.clear();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cadastrar de atividade'),
          content: SizedBox(
            child: Column(
              children: [
                TextField(
                  controller: controllerDescriptonEdite,
                  decoration: const InputDecoration(
                    labelText: 'Descrição',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (controllerDescriptonEdite.text != "") {
                        metodoCriar.createProdutividade(
                            produtividadeModel: ProdutividadeModel(
                                description: controllerDescriptonEdite.text));
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text("Adicionar"),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      controllerDescriptonEdite.clear();
                    },
                    child: const Text("Cancelar"),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> _formUpdateBuilder(BuildContext context,
      {int? id,
      String? description,
      required ProdutividadeCubit metodoAtualizar}) {
    controllerDescriptonEdite.text = description!;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar de atividade'),
          content: SizedBox(
            child: Column(
              children: [
                TextField(
                  controller: controllerDescriptonEdite,
                  decoration: const InputDecoration(
                    labelText: 'Descrição',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      metodoAtualizar.updateProdutividade(
                          produtividadeModel: ProdutividadeModel(
                              id: id,
                              description: controllerDescriptonEdite.text));
                      Navigator.of(context).pop();
                    },
                    child: const Text("Adicionar"),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      controllerDescriptonEdite.clear();
                    },
                    child: const Text("Cancelar"),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProdutividadeCubit, ProdutividadesState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ErrorState) {
          return SingleChildScrollView(
            child:
                Padding(padding: EdgeInsets.all(10), child: Text(state.erro)),
          );
        } else if (state is LoadedState) {
          final produtividades = state.produtividades;
          return SafeArea(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    _formCreateBuilder(context,
                        metodoCriar: context.read<ProdutividadeCubit>());
                  },
                  child: const Text("Cadastrar"),
                ),
                Expanded(
                  child: ListView.builder(
                  itemCount: produtividades.length,
                  itemBuilder: (context, index) {
                    return Card(
                          child: Column(
                            children: [
                              Text("${produtividades[index].description}"),
                              ElevatedButton(
                                onPressed: () {
                                  ProdutividadeCubit metodoAtualizar =
                                      context.read<ProdutividadeCubit>();
                                  _formUpdateBuilder(
                                    context,
                                    id: produtividades[index].id!,
                                    description:
                                        produtividades[index].description,
                                    metodoAtualizar: metodoAtualizar,
                                  );
                                },
                                child: const Text("Editar"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  context
                                      .read<ProdutividadeCubit>()
                                      .deleteProdutividade(
                                          id: produtividades[index].id!);
                                },
                                child: const Text("Excluir"),
                              ),
                            ],
                          ),
                        );
                  }
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
