import 'package:clay_rigging_bridle/utils/app_assets.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;

  var screensList =
      [
        AppAssets.info,
        AppAssets.bridleLegIcon,
        AppAssets.bridleApexIcon,
        AppAssets.weightShiftingIcon,
        AppAssets.udlIcon,
        AppAssets.complexUDLIcon,
        AppAssets.cantivleverUDLIcon,
        AppAssets.cantivleverIcon,
        AppAssets.breastingLineIcon,
        AppAssets.unitConverterIcon,
      ].obs;
}
