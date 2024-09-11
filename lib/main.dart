import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:task_id_03/shopping.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<String>('shoppingBox');
  runApp(const Shopping());
}
