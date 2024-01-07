import 'package:buscadordecep/classes/address.dart';
import 'package:buscadordecep/controller/check_by_address_controller.dart';
import 'package:flutter/material.dart';

class CheckByAddressStore extends ChangeNotifier {
  final controller = CheckByAddressController();

  bool isLoading = false;
  String error = '';
  List<Address> addresses = [];

  void getAddresses({
    required String logradouro,
    required String cidade,
    required String uf,
  }) async {
    isLoading = true;
    error = '';
    notifyListeners();

    try {
      addresses = await controller.getAddresses(logradouro, uf, cidade);
      error = '';
      notifyListeners();
    } catch (e) {
      error = e.toString().replaceAll('Exception: ', '');
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
