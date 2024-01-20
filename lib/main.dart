import 'package:flutter/material.dart';
import 'package:reminder_app/core/colors.dart';
import 'package:reminder_app/screens/task_home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: CustomColors.primarySwatch,
      ),
      debugShowCheckedModeBanner: false,
      home: const TaskHome(),
    );
  }
}
