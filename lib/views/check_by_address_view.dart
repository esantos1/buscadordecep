import 'package:buscadordecep/classes/address.dart';
import 'package:buscadordecep/shared/widgets/search_dropdown_button_form_field.dart';
import 'package:buscadordecep/shared/widgets/search_form_field.dart';
import 'package:buscadordecep/store/check_by_address_store.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CheckByAddressView extends StatefulWidget {
  const CheckByAddressView({super.key});

  @override
  State<CheckByAddressView> createState() => _CheckByAddressViewState();
}

class _CheckByAddressViewState extends State<CheckByAddressView>
    with TickerProviderStateMixin {
  final store = CheckByAddressStore();
  final txtLogradouroController = TextEditingController();
  final txtDropdownSearchBarController = TextEditingController();

  bool isLoadingCities = false;
  bool isFilledStreetName = false;
  int _expandedIndex = -1;

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
            maxHeight: MediaQuery.of(context).size.height - 200,
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
        enabled: !isLoadingCities && store.controller.model.ufValue.isNotEmpty,
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
            child: ListView(
              children: [
                Text(
                  'Exibindo ${store.addresses.length} resultados para ${store.controller.model.cityValue} - ${store.controller.model.ufValue}',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.black54),
                ),
                SizedBox(height: 16.0),
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: store.addresses.length,
                  itemBuilder: (context, index) {
                    final item = store.addresses[index];

                    return _buildItem(item, index);
                  },
                  separatorBuilder: (_, __) => SizedBox(height: 18.0),
                ),
              ],
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

  Widget _buildItem(Address item, int index) {
    final primaryColor = Theme.of(context).primaryColor;
    String headerText = '';

    if (item.complemento.contains('(') && item.complemento.contains(')')) {
      headerText = '${item.logradouro}, ${item.bairro} ${item.complemento}';
    } else if (item.complemento.isNotEmpty) {
      headerText = '${item.logradouro}, ${item.bairro} (${item.complemento})';
    } else {
      headerText = '${item.logradouro}, ${item.bairro}';
    }

    return Card(
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        key: Key(_expandedIndex.toString()),
        trailing: Icon(
          _expandedIndex == index
              ? Icons.arrow_drop_down_circle
              : Icons.arrow_drop_down,
          color: primaryColor,
        ),
        title: Text(headerText, style: TextStyle(color: primaryColor)),
        onExpansionChanged: (expanded) =>
            setState(() => _expandedIndex = expanded ? index : -1),
        initiallyExpanded: index == _expandedIndex,
        children: [
          ListTile(
            title: Text(item.cep),
            trailing: TextButton.icon(
              onPressed: _copyCep,
              icon: Icon(Icons.copy),
              label: Text('Copiar CEP'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _newSearchButton() => ElevatedButton(
        onPressed: _searchNewAddresses,
        child: Text('Nova pesquisa'),
      );

  void onUfDropdownChanged(value) async {
    List<String> ufs = [];

    store.controller.model.cityValue = '';
    store.controller.model.ufValue = value;

    try {
      isLoadingCities = true;

      ufs = await store.controller.getCities(value);
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
      store.controller.model.cities = ufs;
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

  void _copyCep() {}

  void _searchNewAddresses() {
    store.addresses.clear();
    store.error = '';

    txtLogradouroController.clear();
    store.controller.model.ufValue = '';
    store.controller.model.cityValue = '';
    txtDropdownSearchBarController.clear();
  }
}
