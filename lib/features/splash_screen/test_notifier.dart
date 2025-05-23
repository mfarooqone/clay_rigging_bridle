import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskNotifier extends StateNotifier<List<String>> {
  TaskNotifier() : super(['Flutter', 'React Native', 'Android']);

  void addTask(String task) {
    if (task.isNotEmpty && !state.contains(task)) {
      state = [...state, task];
    }
  }

  void removeTask(int index) {
    final updated = [...state]..removeAt(index);
    state = updated;
  }
}

final taskListProvider = StateNotifierProvider<TaskNotifier, List<String>>(
  (ref) => TaskNotifier(),
);

final isLoadingProvider = StateProvider<bool>((ref) => false);
