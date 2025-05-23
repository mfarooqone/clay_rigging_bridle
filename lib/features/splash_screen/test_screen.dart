import 'package:clay_rigging_bridle/features/splash_screen/test_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});
  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  ///
  ///
  ///
  final TestController controller = Get.put(TestController());
  final TextEditingController taskTextController = TextEditingController();

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
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
        child: Obx(() {
          return controller.isLoading.value
              ? CircularProgressIndicator()
              : Column(
                children: [
                  ///
                  /* -------------------------------------------------------------------------- */
                  /*                                 tasks list                                 */
                  /* -------------------------------------------------------------------------- */
                  ///
                  ///
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.taskList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: width * 0.05,
                            vertical: height * 0.01,
                          ),
                          child: SizedBox(
                            width: width,

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
                                            controller.taskList[index],
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                /* -------------------------------------------------------------------------- */
                                /*                                  close btn                                 */
                                /* -------------------------------------------------------------------------- */

                                ///
                                ///
                                ///
                                ///
                                GestureDetector(
                                  onTap: () {
                                    deleteDialog(width, height, index);
                                  },
                                  child: Container(
                                    width: width * 0.1,
                                    height: width * 0.1,
                                    decoration: BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),

                                ///
                                ///
                                ///
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  ///
                  ///
                  ///
                  /* -------------------------------------------------------------------------- */
                  /*                                   add btn                                  */
                  /* -------------------------------------------------------------------------- */
                  CustomButton(
                    buttonTitle: "Add New",
                    buttonHeight: height * 0.06,
                    buttonWidth: width * 0.7,
                    onPressed: () {
                      addDialog(width, height);
                    },
                  ),
                  SizedBox(height: height * 0.02),
                ],
              );
        }),
      ),
    );
  }

  Future<dynamic> deleteDialog(double width, double height, int index) {
    return Get.defaultDialog(
      title: "",
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.symmetric(horizontal: width * 0.05),
      content: SizedBox(
        height: height * 0.18,
        width: width * 0.7,
        child: Center(
          child: Column(
            children: [
              Text("Are you sure, You want to delete?", style: TextStyle()),

              ///
              SizedBox(height: height * 0.05),

              Row(
                children: [
                  ///
                  ///
                  CustomButton(
                    buttonTitle: "Yes",
                    buttonHeight: height * 0.05,
                    buttonWidth: width * 0.3,
                    onPressed: () {
                      Get.back();

                      controller.removeTask(index: index);
                    },
                  ),
                  SizedBox(width: width * 0.05),
                  CustomButton(
                    buttonTitle: "No",
                    buttonHeight: height * 0.05,
                    buttonWidth: width * 0.3,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> addDialog(double width, double height) {
    return Get.defaultDialog(
      title: "",
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.symmetric(horizontal: width * 0.05),
      content: SizedBox(
        height: height * 0.18,
        width: width * 0.7,
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: taskTextController,
                decoration: InputDecoration(
                  hintText: "Enter Your Skill",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              ///
              SizedBox(height: height * 0.05),

              ///
              ///
              CustomButton(
                buttonTitle: "Add",
                buttonHeight: height * 0.05,
                buttonWidth: width * 0.3,
                onPressed: () {
                  Get.back();
                  if (taskTextController.text.isEmpty) {
                    Get.snackbar("Error", "Please Enter Your Skill");
                  } else {
                    controller.addTask(taskTextController.text);
                    taskTextController.clear();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatefulWidget {
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
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        width: widget.buttonWidth,
        height: widget.buttonHeight,
        child: Center(
          child: Text(
            widget.buttonTitle,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
