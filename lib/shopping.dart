import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:task_id_03/feature/shopping/controller/shopping_cubit.dart';
import 'package:task_id_03/feature/shopping/presentation/screens/shopping_home.dart';

class Shopping extends StatelessWidget {
  const Shopping({super.key, required this.shoppingBox});
  final Box<String> shoppingBox;

  // MyApp({required this.shoppingBox});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
        ),
      ),
      home: BlocProvider(
        create: (context) => ShoppingCubit(shoppingBox),
        child: ShoppingListPage(),
      ),
    );
  }
}
