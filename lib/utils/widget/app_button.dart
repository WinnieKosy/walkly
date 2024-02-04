import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final IconData? icon;
  final Widget? image;
  final Function() onTap;
  final Color? color;
  final Color? iconColor;
  final double? iconSize;
  final double? height;
  final double? width;
  const AppButton(
      {Key? key,
      this.icon,
      required this.onTap,
      this.color,
      this.image,
      this.iconColor,
      this.iconSize, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 40,
        width: width ?? 40,
        decoration:
            BoxDecoration(color: color ?? Colors.white, shape: BoxShape.circle),
        child: image ??
            Icon(
              icon,
              size: iconSize ??  18,
              color: iconColor ?? Colors.black,
            ),
      ),
    );
  }
}
