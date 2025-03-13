import 'package:flutter/material.dart';
import 'package:gpt_gastos/models/transactions_model.dart';
import 'package:hive/hive.dart';

class TransactionProvider extends ChangeNotifier {
  late Box<Transaction> _transactionBox;

  List<Transaction> _transactionList = [];
  List<Transaction> get transactionList => _transactionList;

  TransactionProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    _transactionBox = await Hive.openBox("transaction_box");
    _transactionList = _transactionBox.values.toList();

    notifyListeners();
  }

  Future<void> addTransaction({required Transaction transaction}) async {
    await _transactionBox.add(transaction);
    _transactionList = _transactionBox.values.toList();

    notifyListeners();
  }

  Future<void> deleteTransaction({required int index}) async {
    await _transactionBox.deleteAt(index);
    _transactionList = _transactionBox.values.toList();
    notifyListeners();
  }

  //Entiendo que las funciones para interactuar con las cajas de Hive (bases de datos) es conveniente hacerlo de manera asincrona para mantener la estabilidad d el a aplicacion
}
