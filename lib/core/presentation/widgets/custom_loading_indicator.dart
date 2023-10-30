import 'package:flutter/material.dart';
import 'package:news_app_flutter/core/presentation/helpers/app_colors.dart';

class CustomLoadingIndicator extends StatelessWidget {
  final Color color;
  final double strokeWidth;
  final double? value;

  const CustomLoadingIndicator({
    Key? key,
    this.color = AppColors.primary,
    this.strokeWidth = 4.0,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      value: value,
      strokeWidth: strokeWidth,
      valueColor: AlwaysStoppedAnimation<Color>(color),
    );
  }
}
