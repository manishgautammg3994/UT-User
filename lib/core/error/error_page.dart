import 'package:flutter/material.dart';
import '../../../../common/common.dart';
import '../utils/custom_text.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // In New [Start] USed a column and Image as well as Used MyText Widget Instead of simple Text , Also Text is change
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          Image.asset(AppImages.noInternet),
          const Center(
            child:
                MyText(text: 'Please try again after sometimes', maxLines: 3),
          ),
        ],
      ),
      // In New [End]
    );
  }
}
