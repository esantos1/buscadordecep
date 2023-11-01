import 'package:buscadordecep/controller/check_by_cep_controller.dart';
import 'package:buscadordecep/shared/widgets/search_form_field.dart';
import 'package:buscadordecep/views/address_details.dart';
import 'package:flutter/material.dart';

class CheckByCepView extends StatelessWidget {
  CheckByCepView({super.key});

  final controller = CheckByCepController();

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.77,
          ),
          child: Column(
            children: [
              _form(context),
              Expanded(
                flex: 2,
                child: AddressDetails(),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Verificar outro CEP'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );

  Widget _form(BuildContext context) => Form(
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
              child: SizedBox(
                height: 58,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Icon(Icons.search),
                ),
              ),
            ),
          ],
        ),
      );
}
