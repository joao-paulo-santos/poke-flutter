import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UsernameDisplay extends StatelessWidget {
  const UsernameDisplay({
    super.key,
    required this.username,
  });

  final String username;

  @override
  Widget build(BuildContext context) {
    return Row(
       mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(width: 15),
        SvgPicture.asset(
            'assets/icons/user.svg',
            height: 20,
            width: 20,
            fit: BoxFit.scaleDown,
            colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
          ),
          const SizedBox(width: 15),
        Text(username)
      ]
    );
  }
}
