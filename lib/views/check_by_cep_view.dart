import 'package:brasil_fields/brasil_fields.dart';
import 'package:buscadordecep/controller/check_by_cep_controller.dart';
import 'package:buscadordecep/shared/widgets/search_form_field.dart';
import 'package:buscadordecep/store/check_by_cep_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CheckByCepView extends StatefulWidget {
  const CheckByCepView({super.key});

  @override
  State<CheckByCepView> createState() => _CheckByCepViewState();
}

class _CheckByCepViewState extends State<CheckByCepView> {
  final controller = CheckByCepController();
  late TextEditingController txtCepController;
  final store = CheckByCepStore();
  bool isButtonActive = false;

  final cepInputFormatters = [
    FilteringTextInputFormatter.digitsOnly,
    CepInputFormatter(ponto: false),
  ];

  @override
  void initState() {
    super.initState();

    txtCepController = TextEditingController();

    txtCepController.addListener(() {
      setState(() => isButtonActive = txtCepController.text.length == 9);
    });
  }

  @override
  Widget build(BuildContext context) => ListenableBuilder(
        listenable: store,
        builder: (context, child) {
          Widget body = SizedBox();

          if (store.isLoading) {
            body = Center(child: CircularProgressIndicator());
          } else if (store.error.isNotEmpty) {
            body = Center(
              child: Text(store.error, style: TextStyle(fontSize: 16.0)),
            );
          } else if (store.address.isEmpty()) {
            body = SizedBox();
          } else {
            body = _addressDetails(context);
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.77,
              ),
              child: Column(
                children: [
                  _form(context),
                  Expanded(flex: 2, child: body),
                ],
              ),
            ),
          );
        },
      );

  Widget _form(BuildContext context) => Form(
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: SearchFormField(
                  inputFormatters: cepInputFormatters,
                  keyboardType: TextInputType.number,
                  controller: txtCepController,
                  labelText: 'Insira o CEP',
                  hintText: 'Ex.: 99999-999',
                  onFieldSubmitted:
                      isButtonActive ? (value) => searchCep(context) : null,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: isButtonActive ? () => searchCep(context) : null,
                  child: Icon(Icons.search),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _addressDetails(BuildContext context) {
    final complemento =
        store.address.complemento.isNotEmpty ? store.address.complemento : '-';

    String enderecoCompleto = '';

    if (store.address.logradouro.isEmpty && store.address.bairro.isEmpty) {
      enderecoCompleto = '${store.address.localidade} - ${store.address.uf}';
    } else {
      enderecoCompleto =
          '${store.address.logradouro}, ${store.address.bairro}, ${store.address.localidade} - ${store.address.uf}';
    }

    return Padding(
      padding: EdgeInsets.only(top: 16.0),
      child: ListView(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _dataAddressItem(context, 'CEP', store.address.cep),
          SizedBox(height: 8),
          _dataAddressItem(
            context,
            'Endereço completo',
            enderecoCompleto,
            isThreeLine: true,
          ),
          SizedBox(height: 8),
          _dataAddressItem(context, 'Complemento', complemento),
        ],
      ),
    );
  }

  Widget _dataAddressItem(
    BuildContext context,
    String label,
    String value, {
    bool? isThreeLine,
  }) =>
      Card(
        child: ListTile(
          title: Text(
            label,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(value, style: TextStyle(fontSize: 16.0)),
          trailing: value == '-'
              ? null
              : IconButton(
                  icon: Icon(Icons.copy),
                  onPressed: () => _copyCep(label, value),
                ),
          isThreeLine: isThreeLine ?? false,
        ),
      );

  void searchCep(BuildContext context) {
    FocusScope.of(context).unfocus();
    setState(() => isButtonActive = false);

    store.getAddress(txtCepController.text);
  }

  void _copyCep(String label, String value) {
    Clipboard.setData(ClipboardData(text: value));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$label copiado para a área de transferência'),
      ),
    );
  }
}
