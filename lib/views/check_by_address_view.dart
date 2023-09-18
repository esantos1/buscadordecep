import 'package:buscadordecep/controller/check_by_address_controller.dart';
import 'package:flutter/material.dart';

class CheckByAddressView extends StatelessWidget {
  CheckByAddressView({super.key});

  final viewController = CheckByAddressController();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        label: Text('Insira o nome da rua'),
                        hintText: 'Ex.: Praça da Sé',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: DropdownButtonFormField(
                            items: viewController.model.dropdownUfItems,
                            onChanged: (value) {
                              print(value);
                              print('Valor alterado!\n');
                            },
                          ),
                        ),
                        Expanded(flex: 3, child: Text('Texto 2')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.amber,
                child: Text('Lista vai aqui'),
              ),
            ),
          ],
        ),
      );
}
