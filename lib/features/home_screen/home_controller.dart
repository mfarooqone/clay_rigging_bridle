import 'package:get/get.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;

  var selectedScreen = "Select Calculator".obs;

  var screensList =
      [
        "Select Calculator", // Add this option for the initial value
        "Bridle Leg Length",
        "Bridle Apex and Point Position",
        "Weight Shifting",
        "UDL",
        "Complex UDL",
        "Cantivlever",
        "Breasting Line",
        "Calculator",
      ].obs;
}
