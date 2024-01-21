part of 'task_bloc.dart';

@immutable
sealed class TaskEvent {}

class TaskLoadEvent extends TaskEvent{
    final List<Tasks> tasks;
    TaskLoadEvent({
        this.tasks = const []
    });
} 

class TaskAddEvent extends TaskEvent {
    final Tasks task;
    TaskAddEvent({
        required this.task,
    });
}

class TaskDeleteEvent extends TaskEvent {
    final Tasks task;
    TaskDeleteEvent({ required this.task,});
}