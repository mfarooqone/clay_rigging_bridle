import 'package:clay_rigging_bridle/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  final String? title;
  final List<Widget>? actions;
  final VoidCallback? onBackPressed;
  final bool? trailing;
  const AppHeader({
    super.key,
    this.title,
    this.actions,
    this.onBackPressed,
    this.trailing = false,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Column(
      children: [
        SizedBox(height: height * 0.01),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: onBackPressed ?? () => Navigator.of(context).pop(),
              child: Padding(
                padding: EdgeInsets.only(left: width * 0.03),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: width * 0.6,
              child: Text(
                title ?? '',
                textAlign: TextAlign.center,
                style: appTheme.textTheme.bodyMedium?.copyWith(
                  fontSize: 17.0,
                  color: appTheme.iconTheme.color,
                ),
              ),
            ),
            trailing == true
                ? Padding(
                  padding: EdgeInsets.only(right: width * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: actions ?? [],
                  ),
                )
                : IconButton(
                  splashColor: AppColors.transparent,
                  highlightColor: AppColors.transparent,
                  onPressed: () {},
                  icon: const Icon(Icons.add, color: AppColors.transparent),
                ),
          ],
        ),
      ],
    );
  }
}
