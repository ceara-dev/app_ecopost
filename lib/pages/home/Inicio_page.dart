import 'package:flutter/material.dart';
import '../../wigets/custom_home_menu.dart'; // Importe o arquivo correto

class InicioPage extends StatefulWidget {
  const InicioPage({super.key});

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return SizedBox(
      width: media.width,
      child: ListView(
        children: [
          CustomHomeMenu(),
        ],
      ),
    );
  }
}
