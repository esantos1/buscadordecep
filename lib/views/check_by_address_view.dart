import 'package:buscadordecep/controller/check_by_address_controller.dart';
import 'package:buscadordecep/shared/widgets/search_form_field.dart';
import 'package:flutter/material.dart';

class CheckByAddressView extends StatelessWidget {
  CheckByAddressView({super.key});

  final controller = CheckByAddressController();

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          children: [
            Expanded(child: _form()),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.amber,
              ),
            )
          ],
        ),
      );

  Widget _form() => Form(
        child: Column(
          children: [
            SearchFormField(
              controller: controller.model.txtStreetNameController,
              labelText: 'Insira o nome da rua',
              hintText: 'Ex.: Praça da Sé, Rua Guaianazes',
            ),
            Spacer(),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: SearchDropdownButtonFormField(
                    hintText: 'UF',
                    items: controller.model.dropdownUfItems,
                    onChanged: (value) {},
                  ),
                ),
                Spacer(),
                Expanded(
                  flex: 9,
                  child: SearchDropdownButtonFormField(
                    hintText: 'Cidade',
                    items: controller.model.dropdowncityTestItems,
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.search),
                    label: Text('Pesquisar'),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}

class SearchDropdownButtonFormField extends StatelessWidget {
  final String hintText;
  final List<DropdownMenuItem<dynamic>> items;
  final ValueChanged onChanged;

  const SearchDropdownButtonFormField({
    super.key,
    required this.hintText,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      hint: Text(hintText),
      items: items,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
    );
  }
}
