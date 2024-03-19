import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ItemText extends StatelessWidget {
  const ItemText({
    super.key,
    required this.title,
    required this.data,
    required this.iconData,
  });
  final String title;
  final String data;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(iconData),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: SelectableText.rich(
            TextSpan(
              text: title.tr(),
              style: const TextStyle(
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w200,
              ),
              children: [
                TextSpan(
                  text: "\n$data",
                  style: const TextStyle(
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
