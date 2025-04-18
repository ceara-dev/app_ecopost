import 'package:flutter/material.dart';

class CustomHomeMenu extends StatelessWidget {
  CustomHomeMenu({super.key});

  final List<String> opicoes = [
    'Histórico',
    'Fichário',
    'Requerimento',
    'Agendamento'
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: opicoes.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _onOptionSelected(context, opicoes[index]);
            },
            child: Card(
              elevation: 4,
              child: Center(
                child: Text(
                  opicoes[index],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _onOptionSelected(BuildContext context, String option) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Você selecionou: $option'),
      ),
    );
  }
}
