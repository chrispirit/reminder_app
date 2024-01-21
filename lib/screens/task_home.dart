

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/bloc/task_bloc.dart';
import 'package:reminder_app/core/colors.dart';
import 'package:reminder_app/core/lists.dart';


import '../models/tasks.dart';
import 'custom_text_field.dart';

class TaskHome extends StatelessWidget {
  const TaskHome({super.key});
  static final TextEditingController _taskController = TextEditingController();
  static final TextEditingController _howLongController = TextEditingController();

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      body: SafeArea(
        child:Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(children: [
            _tasksHeader(),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Reminders',
                style: TextStyle(
                  fontSize: 40
                ),
              ),
            ),
            Container(
              height: size.height * 0.10,
              width: double.infinity,
              child: Card(
                elevation: 4,
                color: CustomColors.cardColor,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: TaskLists.tasks.length,
                  itemBuilder: (context, index){
                    final task = TaskLists.tasks[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 17),
                      child: GestureDetector(
                        onTap: (){
                          _showAddTasksSheet(context, task['color'], task['icon']);
                        },
                        child: CircleAvatar(
                          backgroundColor: task['color'],
                          radius: 20,
                          child: Icon(
                            task['icon'],
                            size: 28,
                            color: CustomColors.iconWhiteColor
                          ),
                        ),
                      ),
                    );
                  },
                )
              ),
            ),
            SizedBox(height: 10,),
            Expanded(
              child: BlocBuilder<TaskBloc, TaskState>(
                builder: (context, state) {

                  if(state is TasksLoadingState){
                    return const Center(
                      child: CircularProgressIndicator(backgroundColor:
                      Colors.purple),
                    );
                  }

                  if (state is TasksLoadedState){
                    return ListView.builder(
                                itemCount: state.tasks.length,
                                itemBuilder: (context, index) {
                                  
                                  final card = state.tasks[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 1.5),
                                    child: Slidable(
                                      endActionPane: ActionPane(
                                        motion: const ScrollMotion(),
                                        extentRatio: 0.2,
                                        children: [
                                          SlidableAction(onPressed: (context){
                                            BlocProvider.of<TaskBloc>(context).add(TaskDeleteEvent(task: card));
                                          },
                                          icon: Icons.close,
                                          foregroundColor: Colors.white,
                                          backgroundColor: Colors.black,
                                          borderRadius: BorderRadius.circular(10),
                                          )
                                        ]
                                      ),
                                      child: Card(
                                        color: card.color,
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    card.icon,
                                                    color: CustomColors.iconWhiteColor,
                                                    size: 20,
                                                  ),
                                                  SizedBox(width: 10,),
                                                  Text(
                                                     card.task!,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: CustomColors.iconWhiteColor,
                                                      fontWeight: FontWeight.w500,
                                                      letterSpacing: 1,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                card.howLong!,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: CustomColors.iconWhiteColor,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                });
                  }
                  else {
                    return Container();
                  }
                  
                },
              )
            )
          ],),
        )
      ),
    );
  }
  _tasksHeader(){
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
            Icons.dashboard_outlined,
            size: 30,
        ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      DateFormat('EEE').format(DateTime.now()),
                      style: TextStyle(
                        color: CustomColors.greyColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      DateFormat('MMM, yy').format(DateTime.now()),
                      style: TextStyle(
                        color: CustomColors.greyColor,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                SizedBox(width: 10),
                Text(
                  DateFormat('dd').format(DateTime.now()),
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            )
      ],
    );
  }
  void _showAddTasksSheet(context, color, icon){
    showModalBottomSheet(context: context,isScrollControlled: true, builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Wrap(
          children: [
            Center(
              child: Transform(
                transform: Matrix4.translationValues(0, -30, 0),

                child: CircleAvatar(
                backgroundColor: CustomColors.backgroundColor,
                radius: 40,
                child: CircleAvatar(
                  backgroundColor: color,
                  radius: 36,
                  child:  Icon(icon, size: 40, color: CustomColors.backgroundColor),
                )
              ),
            )
          ),
            Expanded(child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                child: Column(
                  children: [
                    CustomTextFormField(
                      title: 'Task Name:',
                      hintText: 'eg: reading a book',
                      color: color,
                      controller: _taskController,
                      validator: (value){
                        if(value == ''){
                          return "Task field is required";
                        }
                      },
                    ),
                    SizedBox(height: 10,),
                    CustomTextFormField(
                      title: 'How Long:',
                      hintText: 'eg: half an hour',
                      color: color,
                      controller: _howLongController,
                      validator: (value){
                        if(value == ''){
                          return "Task field is required";
                        }
                      },
                    ),
                    SizedBox(height: 30,),
                    _elevatedButton(color, icon),
                  ],
                ),
              ),
            ))
        ]
        ),
      );
    });
  }

  _elevatedButton(color, icon) {
    return Container(
      height: 50,
      width: double.infinity,
      child: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          return ElevatedButton(
            onPressed: () async {
              if(_formKey.currentState!.validate()){
                DateTime? scheduledTime = await _showDateTimePicker(context);
                if(scheduledTime != null) {
                  Tasks task = Tasks(
                    task: _taskController.text,
                    howLong: _howLongController.text,
                    color: color,
                    icon: icon,
                    scheduledTime: scheduledTime,
                  );
                  BlocProvider.of<TaskBloc>(context).add(
                      TaskAddEvent(task: task)
                  );

                  BlocProvider.of<TaskBloc>(context).scheduleNotification(
                      task.task!,
                      scheduledTime,
                  );

                  _taskController.text = '';
                  _howLongController.text = '';

                  Navigator.pop(context);
                }
             }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
            )
          ),
          child: const Text(
            'remind me',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          );
        }
        )
      );
    }
    Future<DateTime?> _showDateTimePicker(BuildContext context) async {
      DateTime selectedDate = DateTime.now();
      TimeOfDay selectedTime = TimeOfDay.now();

      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 10),
      );

      if (pickedDate != null) {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );

        if (pickedTime != null) {
          selectedDate = DateTime(
              pickedDate.year,
              pickedDate.month,
              pickedDate.day,
              pickedTime.hour,
              pickedTime.minute
          );
        }
      }
      return selectedDate;
    }

}
