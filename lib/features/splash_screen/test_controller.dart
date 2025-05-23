import 'package:get/get.dart';

class TestController extends GetxController {
  RxBool isLoading = false.obs;

  List<String> taskList = [
    "Flutter",
    "React Native",
    "Android",
    "Flutter",
    "React Native",
    "Android",
    "Flutter",
    "React Native",
    "Android",
  ];

  void addTask(String task) {
    isLoading.value = true;
    taskList.add(task);
    isLoading.value = false;
  }

  void removeTask({required index}) {
    isLoading.value = true;
    taskList.removeAt(index);
    isLoading.value = false;
  }
}
