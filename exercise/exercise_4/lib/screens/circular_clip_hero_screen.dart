import 'package:flutter/material.dart';

class CircularClipHero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Circular Clip Hero")),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return CircularClipHeroDetails();
                },
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  var radius = Tween<double>(begin: 0.0, end: 1.0).animate(animation);
                  return ClipOval(
                    child: AnimatedBuilder(
                      animation: animation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: radius.value,
                          child: child,
                        );
                      },
                      child: child,
                    ),
                  );
                },
              ),
            );
          },
          child: Hero(
            tag: 'circular-clip-hero',
            child: Container(
              width: 100,
              height: 100,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}

class CircularClipHeroDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Circular Clip Hero Details")),
      body: Center(
        child: Hero(
          tag: 'circular-clip-hero',
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/A4.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
} 