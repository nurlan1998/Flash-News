import 'package:flutter/material.dart';
import 'package:news_app_flutter/core/presentation/widgets/custom_loading_indicator.dart';

class PageLoading extends StatelessWidget {
  final Color indicatorColor;

  const PageLoading({
    Key? key,
    this.indicatorColor = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CustomLoadingIndicator(
            color: indicatorColor,
          ),
        ],
      ),
    );
  }
}
