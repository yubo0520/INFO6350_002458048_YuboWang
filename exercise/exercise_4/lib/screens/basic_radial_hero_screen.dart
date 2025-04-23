import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../widgets/photo.dart';
import '../widgets/radial_expansion.dart';

const String _heroImage = 'assets/images/A3.jpg';
const double _kMinRadius = 32.0;
const double _kMaxRadius = 128.0;
const double _photoDetailWidth = 300.0;

RectTween _createRectTween(Rect? begin, Rect? end) {
  return MaterialRectCenterArcTween(begin: begin, end: end);
}

class BasicRadialHero extends StatelessWidget {
  const BasicRadialHero({super.key});

  Widget _buildHero(BuildContext context, String photo) {
    return SizedBox(
      width: _kMinRadius * 2.0,
      height: _kMinRadius * 2.0,
      child: Hero(
        createRectTween: _createRectTween,
        tag: photo,
        child: Photo(
          photo: photo,
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder<void>(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return BasicRadialHeroDetails(
                    photo: photo,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Basic Radial Hero")),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        alignment: Alignment.center,
        child: _buildHero(context, _heroImage),
      ),
    );
  }
}

class BasicRadialHeroDetails extends StatelessWidget {
  final String photo;

  const BasicRadialHeroDetails({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    final double maxRadius = _photoDetailWidth * math.sqrt2 / 2.0;

    return Scaffold(
      appBar: AppBar(title: const Text("Radial Hero Details")),
      body: Container(
        color: Theme.of(context).canvasColor,
        child: Center(
          child: SizedBox(
            width: _photoDetailWidth,
            height: _photoDetailWidth,
            child: Hero(
              createRectTween: _createRectTween,
              tag: photo,
              child: RadialExpansion(
                maxRadius: maxRadius,
                child: Photo(
                  photo: photo,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
} 