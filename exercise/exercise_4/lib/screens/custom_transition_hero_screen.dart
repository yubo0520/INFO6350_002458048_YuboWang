import 'package:flutter/material.dart';

class CustomTransitionHero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Custom Transition Hero")),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return CustomTransitionHeroDetails();
                },
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.easeOut;

                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                  var offsetAnimation = animation.drive(tween);

                  return SlideTransition(position: offsetAnimation, child: child);
                },
              ),
            );
          },
          child: Hero(
            tag: 'custom-transition-hero-tag',
            child: Image.asset('assets/images/A2.jpg', width: 100),
          ),
        ),
      ),
    );
  }
}

class CustomTransitionHeroDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Custom Transition Hero Details")),
      body: Center(
        child: Hero(
          tag: 'custom-transition-hero-tag',
          child: Image.asset('assets/images/A2.jpg', width: 300),
        ),
      ),
    );
  }
} 