import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions; 
  final bool showBackButton; 
  final VoidCallback? onBackPressed;

  const AppBarWidget({
    Key? key,
    required this.title,
    this.actions,
    this.showBackButton = true,
    this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      elevation: 1, 
      automaticallyImplyLeading: showBackButton, 
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              // use custom back press or default pop navigation
              onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
            )
          : null, // no back button if showBackButton is false
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}