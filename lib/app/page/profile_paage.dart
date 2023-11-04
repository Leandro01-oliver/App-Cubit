import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:produtividade/app/cubits/produtivade_cubit.dart';

class ProfileHome extends StatefulWidget {
  const ProfileHome({super.key});

  @override
  State<ProfileHome> createState() => _ProfileHomeState();
}

class _ProfileHomeState extends State<ProfileHome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: 
    SingleChildScrollView(
      child: ElevatedButton(onPressed: (){
       context.read<ProdutividadeCubit>().getProdutividade();
      }, child: Text("Atualizar")),
    ),
    );
  }
}