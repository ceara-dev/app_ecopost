// pages/home/home_page.dart
// ignore_for_file: unused_field

import 'package:app_ecopost/pages/home/Inicio_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/home_provider.dart';
import '../../services/location/localizacao.dart';
import '../../wigets/custom_avatar.dart';
import 'mapa_page.dart';
import 'perfil_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textController = TextEditingController();
  final localizacao = Localizacao();
  List<double> localizacaos = [];

  @override
  void initState() {
    super.initState();
    _localizacao();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeProvider>(context, listen: false).loadTests();
    });
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _localizacao() async {
    localizacaos = await localizacao.getobterLocalizacaoAtual();
    setState(() => localizacao);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CustomAppBarWithAvatar()),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          InicioPage(),
          Center(child: Text('Página Buscar')),
          localizacaos.isNotEmpty
              ? MapaPage(
                  title: '2',
                  latitudeInit: localizacaos[0],
                  longitudeInit: localizacaos[1],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
          PerfilPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_sharp),
            label: 'Mapa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
