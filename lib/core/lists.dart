import 'package:flutter/material.dart';
import 'package:reminder_app/core/colors.dart';

import '../models/tasks.dart';

class TaskLists {
  static List<Map<String, dynamic>> tasks = [
    {
      'color': CustomColors.lightBlueColor,
      'icon': Icons.book,
    },
    {
      'color': CustomColors.lightPurpleColor,
      'icon': Icons.fitness_center,
    },
    {
      'color': CustomColors.lightOrangeColor,
      'icon': Icons.music_note,
    },
    {
      'color': CustomColors.lightGreenColor,
      'icon': Icons.coffee,
    },
    {
      'color': CustomColors.lightPinkColor,
      'icon': Icons.movie,
    },

  ];

  static List<Tasks> taskCards = [
    Tasks(
      task: 'Reading',
      howLong: 'one hour',
      color: CustomColors.lightBlueColor,
      icon: Icons.book,
    ),
    Tasks(
      task: 'Watch movies',
      howLong: '30 min',
      color: CustomColors.lightPinkColor,
      icon: Icons.movie,
    ),
    Tasks(
      task: 'Workout',
      howLong: 'one and a half hour',
      color: CustomColors.lightPurpleColor,
      icon: Icons.fitness_center,
    ),
    Tasks(
      task: 'drink coffee',
      howLong: '10 mins',
      color: CustomColors.lightGreenColor,
      icon: Icons.coffee,
    ),
  ];
}