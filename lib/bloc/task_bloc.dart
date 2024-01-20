import 'package:bloc/bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:meta/meta.dart';
import 'package:reminder_app/models/tasks.dart';
import 'package:timezone/timezone.dart' as tz;

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

  TaskBloc() : super(TasksLoadedState()) {
    on<TaskLoadEvent>((event, emit) { 
      emit(TasksLoadedState(tasks: event.tasks));
    });

    on<TaskAddEvent>((event, emit) {
      emit(TasksLoadedState(tasks: List.from(state.tasks)..add(event.task)));

    });
  }

  Future<void> scheduleNotification(String taskName, DateTime scheduledTime) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'my_chan_1',
        'Task Reminder',
        importance: Importance.high,
        priority: Priority.high,
    );

    var iOSPlatformChannelSpecifics = DarwinNotificationDetails();
    
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    final scheduledTimeZone = tz.getLocation('Africa/Douala');
    final tzDateTime = tz.TZDateTime.from(scheduledTime, scheduledTimeZone);
    
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Task Reminder',
      'It\'s time to accomplish your task: $taskName',
      tzDateTime,
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
