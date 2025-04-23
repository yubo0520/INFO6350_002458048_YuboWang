import 'package:flutter/material.dart';

class BackgroundExpansionHero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Background Expansion Hero")),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return BackgroundExpansionHeroDetails();
                },
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  var radius = Tween<double>(begin: 0.0, end: 1.0).animate(animation);
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(100),
                    ),
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
            tag: 'background-expansion-radial-hero',
            child: Image.asset(
              'assets/images/A5.jpg',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class BackgroundExpansionHeroDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Background Expansion Hero Details")),
      body: Center(
        child: Hero(
          tag: 'background-expansion-radial-hero',
          child: Image.asset(
            'assets/images/A5.jpg',
            width: 300,
            height: 300,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
} 