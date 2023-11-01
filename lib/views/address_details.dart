import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddressDetails extends StatelessWidget {
  const AddressDetails({super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(top: 16.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _dataAddressItem(context, 'CEP', 'Praça da Sé'),
            Spacer(),
            _dataAddressItem(context, 'Logradouro', 'Praça da Sé'),
            Spacer(),
            _dataAddressItem(context, 'Complemento:', 'Praça da Sé'),
            Spacer(),
            _dataAddressItem(context, 'Bairro:', 'Praça da Sé'),
            Spacer(),
            _dataAddressItem(context, 'Cidade', 'Praça da Sé'),
            Spacer(),
            _dataAddressItem(context, 'Estado/UF', 'Praça da Sé'),
            Spacer(),
            _dataAddressItem(context, 'Estado/UF', 'Praça da Sé'),
          ],
        ),
      );

  Widget _dataAddressItem(BuildContext context, String label, String value) =>
      Card(
        child: ListTile(
          title: Text(
            label,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(value, style: TextStyle(fontSize: 14.0)),
          trailing: IconButton(
            icon: Icon(Icons.copy),
            onPressed: () => copyData(value, context, label),
          ),
        ),
      );

  void copyData(String value, BuildContext context, String label) {
    Clipboard.setData(ClipboardData(text: value));

    showSnackBarData(context, label);
  }

  void showSnackBarData(BuildContext context, String label) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$label copiado para a área de transferência'),
        ),
      );
}
