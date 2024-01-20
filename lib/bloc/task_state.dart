part of 'task_bloc.dart';

@immutable
abstract class TaskState {
    final List<Tasks> tasks;
    TaskState({
        this.tasks = const [],
        });

}

class TasksLoadingState extends TaskState {}

class TasksLoadedState extends TaskState {
    final List<Tasks> tasks;
    TasksLoadedState({
        this.tasks = const [],
        });
}
