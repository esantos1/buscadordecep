import 'package:buscadordecep/controller/check_by_cep_controller.dart';
import 'package:buscadordecep/shared/widgets/search_form_field.dart';
import 'package:flutter/material.dart';

class CheckByCepView extends StatelessWidget {
  CheckByCepView({super.key});

  final controller = CheckByCepController();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            _form(),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.yellow,
              ),
            ),
          ],
        ),
      );

  Widget _form() => Form(
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: SearchFormField(
                controller: controller.model.txtCepController,
                labelText: 'Insira o CEP',
                hintText: 'Ex.: 99999999',
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                child: Icon(Icons.search),
              ),
            ),
          ],
        ),
      );
}
