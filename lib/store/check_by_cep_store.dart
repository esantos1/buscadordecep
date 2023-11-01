import 'package:buscadordecep/classes/address.dart';
import 'package:buscadordecep/controller/check_by_cep_controller.dart';
import 'package:flutter/material.dart';

class CheckByCepStore extends ChangeNotifier {
  final controller = CheckByCepController();

  bool isLoading = false;
  String error = '';
  Address address = Address.empty();

  void getAddress(String cep) async {
    isLoading = true;
    error = '';
    notifyListeners();

    try {
      address = await controller.fetchData(cep);
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
