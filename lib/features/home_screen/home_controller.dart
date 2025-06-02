import 'package:get/get.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;

  // RxString selectedScreen = AppAssets.info.obs;
  RxInt selectedIndex = 0.obs;

  final List<String> screensList = [
    "Information",
    "Bridle Leg",
    "Bridle Apex",
    "Weight Shifting",
    "UDL",
    "Complex UDL",
    "Cantilever",
    "Cantilever UDL",
    "Breasting Line",
    "Unit Converter",
  ];

  // var screensList =
  //     [
  //       AppAssets.info,
  //       AppAssets.bridleLegIcon,
  //       AppAssets.bridleApexIcon,
  //       AppAssets.weightShiftingIcon,
  //       AppAssets.udlIcon,
  //       AppAssets.complexUDLIcon,
  //       AppAssets.cantivleverIcon,
  //       AppAssets.cantivleverUDLIcon,
  //       AppAssets.breastingLineIcon,
  //       AppAssets.unitConverterIcon,
  //     ].obs;
}
