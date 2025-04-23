import 'package:flutter/material.dart';

class Photo extends StatelessWidget {
  const Photo({ super.key, required this.photo, this.color, this.onTap });

  final String photo;
  final Color? color; // color is nullable as per tutorial
  final VoidCallback? onTap; // onTap is nullable

  @override
  Widget build(BuildContext context) {
    return Material(

      color: color ?? Theme.of(context).primaryColor.withAlpha(25),
      child: InkWell(
        onTap: onTap,
        child: Image.asset(
          photo,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
} 