import 'package:gpt_gastos/models/transaction_type.dart';
import 'package:hive/hive.dart';

part 'transactions_model.g.dart';

@HiveType(typeId: 0)
class Transaction {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final double amount;
  @HiveField(3)
  final TransactionType transactionType; // Considera cambiar a enum más adelante
  @HiveField(4)
  final String category;
  @HiveField(5)
  final DateTime date;

  Transaction({
    required this.id,
    required this.name,
    required this.amount,
    required this.transactionType,
    required this.category,
    required this.date,
  });
}
