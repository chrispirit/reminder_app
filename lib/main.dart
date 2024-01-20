import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_app/core/colors.dart';
import 'package:reminder_app/screens/task_home.dart';


import 'bloc/task_bloc.dart';
import 'core/lists.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider (
      create: (context) => TaskBloc()..add(TaskLoadEvent(
        tasks: TaskLists.taskCards,
      )),
        child: MaterialApp(
          theme: ThemeData(
            primarySwatch: CustomColors.primarySwatch,
          ), 
          debugShowCheckedModeBanner: false,
          home: const TaskHome(),
        ),
    );
  }
}
