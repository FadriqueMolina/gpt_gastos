import 'package:flutter/material.dart';
import 'package:gpt_gastos/models/transaction_type.dart';
import 'package:gpt_gastos/models/transactions_model.dart';
import 'package:gpt_gastos/providers/transaction_provider.dart';
import 'package:gpt_gastos/screens/home_screen.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionTypeAdapter());
  Hive.registerAdapter(TransactionAdapter());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TransactionProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      title: "App para gastos y transacciones",
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
