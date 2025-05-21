import 'package:clay_rigging_bridle/common/controllers/preference_controller.dart';
import 'package:clay_rigging_bridle/common/network_client/network_client.dart';
import 'package:clay_rigging_bridle/widgets/internet_check_connectivity.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

BindingsBuilder createBindings(BuildContext context) {
  return BindingsBuilder(() {
    Get.put<NetworkClient>(NetworkClient(), permanent: true);
    Get.put(InternetConnectionController(), permanent: true);
    Get.put(AppPreferencesController(), permanent: true);
  });
}
