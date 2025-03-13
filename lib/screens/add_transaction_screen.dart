import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gpt_gastos/models/transaction_type.dart';
import 'package:gpt_gastos/models/transactions_model.dart';
import 'package:intl/intl.dart';

class AddTransactionScreen extends StatefulWidget {
  final Function(Transaction) saveTransaction;
  const AddTransactionScreen({super.key, required this.saveTransaction});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  String transactionName = "";
  String category = "";
  double amount = 0;
  DateTime time = DateTime.now();

  TransactionType _transactionType = TransactionType.income;
  final TextEditingController _dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Agregar transaccion")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: _formKey,

          child: Column(
            children: [
              SizedBox(height: 10),
              TextFormField(
                maxLength: 20,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Nombre de la transaccion",
                ),
                validator: (value) {
                  if (value == null || value == "") {
                    return "Debes agregar un nombre a la transaccion";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  transactionName = newValue!;
                },
              ),

              SizedBox(height: 10),
              TextFormField(
                maxLength: 10,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Monto",
                ),
                validator: (value) {
                  if (value == null || value == "") {
                    return "Debes agregar un monto a la transaccion";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  amount = double.parse(newValue!);
                },
              ),
              SizedBox(height: 10),

              TextFormField(
                maxLength: 20,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Categoria",
                ),
                validator: (value) {
                  if (value == null || value == "") {
                    return "Debes agregar una categoria a la transaccion";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  category = newValue!;
                },
              ),
              SizedBox(height: 10),

              DropdownButtonFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: _transactionType.name,
                ),
                items:
                    TransactionType.values.map((e) {
                      return DropdownMenuItem(value: e, child: Text(e.name));
                    }).toList(),
                onChanged: (value) {
                  setState(() {
                    _transactionType = value!;
                  });
                },
              ),

              SizedBox(height: 30),

              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Fecha de la transacción',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    String formattedDate = DateFormat(
                      'yyyy-MM-dd',
                    ).format(pickedDate);
                    setState(() {
                      time = pickedDate;
                      _dateController.text = formattedDate;
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value == "") {
                    return "Debes agregar una fecha";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    widget.saveTransaction(
                      Transaction(
                        id: DateTime.now().microsecondsSinceEpoch,
                        name: transactionName,
                        amount: amount,
                        transactionType: _transactionType,
                        category: category,
                        date: time,
                      ),
                    );
                  }
                },
                child: Text("Agregar transaccion"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
