import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LogoutBtn extends StatelessWidget {
  final VoidCallback onTap;
  const LogoutBtn({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          width: 37,
          decoration: BoxDecoration(
              color: const Color(0xffF7F8F8),
              borderRadius: BorderRadius.circular(10)),
          child: SvgPicture.asset(
            'assets/icons/logout.svg',
            height: 20,
            width: 20,
            colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),
          )),
    );
  }
}