import 'package:clay_rigging_bridle/utils/app_text_styles.dart';
import 'package:clay_rigging_bridle/utils/show_snackbar.dart';
import 'package:clay_rigging_bridle/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class NotFoundWifiPage extends StatelessWidget {
  const NotFoundWifiPage({super.key});

  Future<void> checkInternetConnection() async {
    showErrorMessage("Please check your connection and try again.");
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return PopScope(
      canPop: false,
      // ignore: deprecated_member_use
      onPopInvoked: ((didPop) {
        if (didPop) {
          return;
        }
      }),
      child: Scaffold(
        body: SizedBox(
          height: height,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("No Internet", style: AppTextStyle.bodyLarge),
              SizedBox(height: height * 0.08),

              ///
              ///
              ///
              PrimaryButton(title: "Try Again", onPressed: () {}),

              ///
              ///
              ///
            ],
          ),
        ),
      ),
    );
  }
}
