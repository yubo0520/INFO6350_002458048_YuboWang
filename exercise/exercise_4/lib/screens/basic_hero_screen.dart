import 'package:flutter/material.dart';
import '../widgets/photo_hero.dart'; // Import PhotoHero

const String _heroImage = 'assets/images/A1.jpg';

class BasicHero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Basic Hero Animation")),
      body: Center(
        // Use PhotoHero for the source hero
        child: PhotoHero(
          photo: _heroImage,
          width: 100.0,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute<void>(
              builder: (context) {
                return BasicHeroDetails();
              }
            ));
          },
        ),
      ),
    );
  }
}

class BasicHeroDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Basic Hero Animation Details")),
      body: Center(
        // use PhotoHero for the destination hero
        child: PhotoHero(
          photo: _heroImage,
          width: 300.0, // destination width
          onTap: () {
            Navigator.of(context).pop(); // pop route on tap
          },
        ),
      ),
    );
  }
} 