import 'package:buscadordecep/classes/address.dart';
import 'package:buscadordecep/shared/widgets/search_dropdown_button_form_field.dart';
import 'package:buscadordecep/shared/widgets/search_form_field.dart';
import 'package:buscadordecep/store/check_by_address_store.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:diacritic/diacritic.dart' as diacritc;

class CheckByAddressView extends StatefulWidget {
  const CheckByAddressView({super.key});

  @override
  State<CheckByAddressView> createState() => _CheckByAddressViewState();
}

class _CheckByAddressViewState extends State<CheckByAddressView> {
  final store = CheckByAddressStore();
  final txtLogradouroController = TextEditingController();
  final txtDropdownSearchBarController = TextEditingController();

  bool isLoadingCities = false;
  bool isFilledStreetName = false;

  @override
  void initState() {
    super.initState();

    txtLogradouroController.addListener(() => setState(
        () => isFilledStreetName = txtLogradouroController.text.isNotEmpty));
  }

  @override
  Widget build(BuildContext context) => ListenableBuilder(
        listenable: store,
        builder: (context, child) => Container(
          padding: EdgeInsets.all(16.0),
          constraints: BoxConstraints(
            maxHeight: store.addresses.isNotEmpty
                ? double.infinity
                : MediaQuery.of(context).size.height - 200,
          ),
          child: _getBody(),
        ),
      );

  Widget _getBody() {
    if (store.isLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (store.error.isNotEmpty ||
        (store.addresses.isEmpty && store.error.isNotEmpty)) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(store.error, style: TextStyle(fontSize: 16.0)),
            SizedBox(height: 16),
            _newSearchButton(),
          ],
        ),
      );
    } else if (store.addresses.isEmpty ||
        (store.addresses.isEmpty && store.error.isEmpty)) {
      return _form();
    } else {
      return _buildListItems();
    }
  }

  Widget _form() => Form(
        child: Column(
          children: [
            SearchFormField(
              clearButton: false,
              controller: txtLogradouroController,
              labelText: 'Logradouro',
              hintText: 'Ex.: Rua Guaianazes, Domingos',
              helperText: '* Pode ser apenas uma parte do logradouro.',
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-ZÀ-ú ]'))
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: SearchDropdownButtonFormField<String>(
                    hintText: 'UF',
                    items: store.controller.model.buildDropdownUfItems(),
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
                    onPressed: isFilledStreetName &&
                            store.controller.model.ufValue.isNotEmpty &&
                            store.controller.model.cityValue.isNotEmpty
                        ? _searchAddresses
                        : null,
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
        filterFn: (item, filter) => diacritc
            .removeDiacritics(item.toLowerCase())
            .contains(diacritc.removeDiacritics(filter.toLowerCase())),
        enabled: !isLoadingCities && store.controller.model.ufValue.isNotEmpty,
        popupProps: PopupProps.menu(
          showSearchBox: true,
          searchDelay: Duration(milliseconds: 0),
          searchFieldProps: TextFieldProps(
            controller: txtDropdownSearchBarController,
            textInputAction: TextInputAction.go,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Digite a cidade',
              hintStyle: TextStyle(color: Colors.grey[500]),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-ZÀ-ú0-9 ]'))
            ],
          ),
          emptyBuilder: (context, searchEntry) => Center(
            child: Text(
              'Nenhuma cidade foi encontrada.',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
        ),
        items: store.controller.model.cities,
        selectedItem: store.controller.model.cityValue.isEmpty
            ? null
            : store.controller.model.cityValue,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(fontSize: 16),
          dropdownSearchDecoration: InputDecoration(
            icon: isLoadingCities ? CircularProgressIndicator() : null,
            hintText: isLoadingCities ? null : "Cidade",
            border: OutlineInputBorder(),
          ),
        ),
        onChanged: (value) =>
            setState(() => store.controller.model.cityValue = value!),
      );

  Widget _buildListItems() => Column(
        children: [
          Expanded(
            flex: 8,
            child: SingleChildScrollView(
              child: ExpansionPanelList.radio(
                materialGapSize: 32.0,
                expandIconColor: Theme.of(context).primaryColor,
                expandedHeaderPadding: EdgeInsets.symmetric(vertical: 0),
                elevation: 4,
                children: store.addresses.map(_buildItem).toList(),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 78.0,
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: _newSearchButton(),
          ),
        ],
      );

  ExpansionPanelRadio _buildItem(Address item) {
    String headerText = '';

    if (item.complemento.contains('(') && item.complemento.contains(')')) {
      headerText = '${item.logradouro}, ${item.bairro} ${item.complemento}';
    } else if (item.complemento.isNotEmpty) {
      headerText = '${item.logradouro}, ${item.bairro} (${item.complemento})';
    } else if (item.logradouro.isEmpty) {
      headerText = '${item.localidade} - ${item.uf}';
    } else {
      headerText = '${item.logradouro}, ${item.bairro}';
    }

    return ExpansionPanelRadio(
      backgroundColor: CardTheme.of(context).color,
      canTapOnHeader: true,
      value: item,
      headerBuilder: (context, isExpanded) => ListTile(
        title: Text(
          headerText,
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      body: ListTile(
        // title: Text(item.cep),
        leading: TextButton.icon(
          onPressed: () => _copyCep(item.cep),
          icon: Icon(Icons.copy),
          label: Text(item.cep),
        ),
      ),
    );
  }

  Widget _newSearchButton() => ElevatedButton(
        onPressed: _searchNewAddresses,
        child: Text('Nova pesquisa'),
      );

  void onUfDropdownChanged(value) async {
    List<String> cities = [];

    txtDropdownSearchBarController.clear();
    setState(() {
      store.controller.model.cityValue = '';
      store.controller.model.ufValue = value;
    });

    try {
      isLoadingCities = true;

      cities = await store.controller.getCities(value);
    } on Exception catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    } finally {
      isLoadingCities = false;
    }

    setState(() {
      store.controller.model.cities.clear();
      store.controller.model.cities = cities;
    });
  }

  void _searchAddresses() {
    FocusScope.of(context).unfocus();

    store.getAddresses(
      logradouro: txtLogradouroController.text,
      cidade: store.controller.model.cityValue,
      uf: store.controller.model.ufValue,
    );
  }

  void _copyCep(String value) {
    Clipboard.setData(ClipboardData(text: value));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('CEP $value copiado para a área de transferência'),
      ),
    );
  }

  void _searchNewAddresses() {
    store.addresses.clear();
    store.error = '';

    txtLogradouroController.clear();
    store.controller.model.ufValue = '';
    store.controller.model.cityValue = '';
    txtDropdownSearchBarController.clear();
  }
}
