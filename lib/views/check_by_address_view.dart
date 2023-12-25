import 'package:buscadordecep/controller/check_by_address_controller.dart';
import 'package:buscadordecep/shared/widgets/search_dropdown_button_form_field.dart';
import 'package:buscadordecep/shared/widgets/search_form_field.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CheckByAddressView extends StatefulWidget {
  const CheckByAddressView({super.key});

  @override
  State<CheckByAddressView> createState() => _CheckByAddressViewState();
}

class _CheckByAddressViewState extends State<CheckByAddressView> {
  final checkByAddressController = CheckByAddressController();
  final txtLogradouroController = TextEditingController();
  final txtDropdownSearchBarController = TextEditingController();

  bool isLoadingCities = false;

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height - 200,
        ),
        child: _form(),
      );

  Widget _form() => Form(
        child: Column(
          children: [
            SearchFormField(
              controller: txtLogradouroController,
              labelText: 'Logradouro',
              hintText: 'Ex.: Rua Guaianazes, Domingos',
              helperText: '* Pode ser apenas uma parte do logradouro.',
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: SearchDropdownButtonFormField<String>(
                    hintText: 'UF',
                    items:
                        checkByAddressController.model.buildDropdownUfItems(),
                    onChanged: onUfDropdownChanged,
                  ),
                ),
                Spacer(),
                Expanded(flex: 9, child: _dropDownSearchCities()),
              ],
            ),
            SizedBox(height: 16),
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

  Widget _dropDownSearchCities() => DropdownSearch<String>(
        enabled: !isLoadingCities &&
            checkByAddressController.model.ufValue.isNotEmpty,
        popupProps: PopupProps.modalBottomSheet(
          showSearchBox: true,
          modalBottomSheetProps: ModalBottomSheetProps(
            padding: EdgeInsets.only(top: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            ),
          ),
          searchDelay: Duration(milliseconds: 0),
          searchFieldProps: TextFieldProps(
            controller: txtDropdownSearchBarController,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Digite a cidade',
              hintStyle: TextStyle(color: Colors.grey[500]),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'))
            ],
          ),
          emptyBuilder: (context, searchEntry) => Center(
            child: Text(
              'Nenhuma cidade foi encontrada.',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
        ),
        items: checkByAddressController.model.cities,
        selectedItem: checkByAddressController.model.cityValue!.isEmpty
            ? null
            : checkByAddressController.model.cityValue,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(fontSize: 16),
          dropdownSearchDecoration: InputDecoration(
            icon: isLoadingCities ? CircularProgressIndicator() : null,
            hintText: isLoadingCities ? null : "Cidade",
            border: OutlineInputBorder(),
          ),
        ),
        onChanged: (value) {
          setState(() => checkByAddressController.model.cityValue = value!);
        },
      );

  void onUfDropdownChanged(value) async {
    List<String> ufs = [];

    setState(() {
      checkByAddressController.model.cityValue = '';
      checkByAddressController.model.ufValue = value;
    });

    try {
      isLoadingCities = true;

      ufs = await checkByAddressController.getCities(value);
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Ocorreu um erro ao buscar os municípios. Tente novamente mais tarde.')),
      );
    } finally {
      isLoadingCities = false;
    }

    setState(() {
      checkByAddressController.model.cities.clear();
      checkByAddressController.model.cities = ufs;
    });

    for (var element in checkByAddressController.model.cities) {
      print(element);
    }
  }
}
