import 'package:flutter/material.dart';

class EmAppBarButton extends StatelessWidget {
  const EmAppBarButton({
    Key? key,
    required this.iconData,
    required this.onTap,
  }) : super(key: key);

  final IconData iconData;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(blurRadius: 7, spreadRadius: 3, color: Colors.lightGreen)
        ],
        shape: BoxShape.circle,
        color: Colors.green.shade400,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Icon(
          iconData,
          size: 20,
        ),
      ),
    );
  }
}
