import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:produtividade/app/page/profile_paage.dart';
import 'package:produtividade/app/repositorye/produtividade_repositorye.dart';

import 'app/cubits/produtivade_cubit.dart';
import 'app/page/home_page.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  static const int _cardIndex = 0;

    final List<Widget> _pages = <Widget>[
    HomePage(),
    ProfileHome(),
  ];

  int _currentIndex = _cardIndex;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider<ProdutividadeCubit>(
          create: (context) {
            final repository = ProdutividadeRepositorye();
            var moveis = ProdutividadeCubit(repository: repository);
            return moveis;
          },
          child: Scaffold(
          body: IndexedStack(
            index: _currentIndex,
            children: _pages,
          ),
           bottomNavigationBar: BottomNavigationBar(
              fixedColor: Colors.blue,
              currentIndex: _currentIndex,
              onTap: _onItemTapped,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'HOME',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Perfil',
                ),
              ],
            ),
          ),
          ),
    );
  }
}
