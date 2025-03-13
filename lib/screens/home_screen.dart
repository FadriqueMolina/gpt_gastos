import 'package:flutter/material.dart';
import 'package:gpt_gastos/models/transaction_type.dart';
import 'package:gpt_gastos/providers/transaction_provider.dart';
import 'package:gpt_gastos/screens/add_transaction_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
      builder: (context, transactionProvider, child) {
        return Scaffold(
          appBar: AppBar(title: Text("Gastos")),
          body: ListView.builder(
            itemCount: transactionProvider.transactionList.length,
            itemBuilder: (context, index) {
              final item = transactionProvider.transactionList[index];
              final isIncome = item.transactionType == TransactionType.income;
              final amountColor = isIncome ? Colors.green : Colors.red;
              final icon = isIncome ? Icons.arrow_downward : Icons.arrow_upward;
              return ListTile(
                leading: Icon(icon, color: amountColor),
                title: Text(
                  item.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(item.category),
                    Text(
                      // Formatea la fecha de manera legible
                      '${item.date.day}/${item.date.month}/${item.date.year}',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                trailing: Text(
                  // Formatea el monto como moneda
                  '\$${item.amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: amountColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => AddTransactionScreen(
                        saveTransaction: (transaction) {
                          transactionProvider.addTransaction(
                            transaction: transaction,
                          );
                          Navigator.pop(context);
                        },
                      ),
                ),
              );
            },
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}
