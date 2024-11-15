import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RefreshFab extends StatelessWidget {
  const RefreshFab({
    super.key,
    required this.visible,
    required this.onPressed
  });

  final bool visible;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: visible,
        child: FloatingActionButton(
          onPressed: onPressed,
          child: SvgPicture.asset(
            'assets/icons/refresh.svg',
            height: 20,
            width: 20,
            colorFilter:
                const ColorFilter.mode(Colors.blue, BlendMode.srcIn),
          ),
        ));
  }
}