import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'test_notifier.dart';

class TestScreen extends ConsumerStatefulWidget {
  const TestScreen({super.key});
  @override
  ConsumerState<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends ConsumerState<TestScreen> {
  final TextEditingController taskTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final taskList = ref.watch(taskListProvider);
    final isLoading = ref.watch(isLoadingProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Technical Skill",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SizedBox(
        height: height,
        width: width,
        child:
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: taskList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.05,
                              vertical: height * 0.01,
                            ),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: width * 0.05),
                                  child: Container(
                                    width: width,
                                    height: width * 0.2,
                                    decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.05,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            taskList[index],
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          const Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap:
                                      () => deleteDialog(width, height, index),
                                  child: Container(
                                    width: width * 0.1,
                                    height: width * 0.1,
                                    decoration: BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    CustomButton(
                      buttonTitle: "Add New",
                      buttonHeight: height * 0.06,
                      buttonWidth: width * 0.7,
                      onPressed: () => addDialog(width, height),
                    ),
                    SizedBox(height: height * 0.02),
                  ],
                ),
      ),
    );
  }

  Future<void> deleteDialog(double width, double height, int index) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.symmetric(horizontal: width * 0.05),
          content: SizedBox(
            height: height * 0.18,
            width: width * 0.7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Are you sure, You want to delete?"),
                SizedBox(height: height * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      buttonTitle: "Yes",
                      buttonHeight: height * 0.05,
                      buttonWidth: width * 0.3,
                      onPressed: () {
                        ref.read(taskListProvider.notifier).removeTask(index);
                        Navigator.of(context).pop();
                      },
                    ),
                    SizedBox(width: width * 0.05),
                    CustomButton(
                      buttonTitle: "No",
                      buttonHeight: height * 0.05,
                      buttonWidth: width * 0.3,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> addDialog(double width, double height) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.symmetric(horizontal: width * 0.05),
          content: SizedBox(
            height: height * 0.18,
            width: width * 0.7,
            child: Column(
              children: [
                SizedBox(height: height * 0.02),
                TextField(
                  controller: taskTextController,
                  decoration: InputDecoration(
                    hintText: "Enter Your Skill",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.01),
                CustomButton(
                  buttonTitle: "Add",
                  buttonHeight: height * 0.05,
                  buttonWidth: width * 0.3,
                  onPressed: () {
                    if (taskTextController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please Enter Your Skill"),
                        ),
                      );
                    } else {
                      ref
                          .read(taskListProvider.notifier)
                          .addTask(taskTextController.text.trim());
                      taskTextController.clear();
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CustomButton extends StatelessWidget {
  final String buttonTitle;
  final VoidCallback onPressed;
  final double buttonHeight;
  final double buttonWidth;

  const CustomButton({
    super.key,
    required this.buttonTitle,
    required this.onPressed,
    required this.buttonHeight,
    required this.buttonWidth,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: buttonHeight,
        width: buttonWidth,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(buttonTitle, style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
