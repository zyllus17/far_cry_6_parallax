import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:far_cry_6_parallax/model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ParallaxWidget extends StatefulWidget {
  final List parallaxData;

  const ParallaxWidget({
    Key? key,
    required this.parallaxData,
  }) : super(key: key);

  @override
  State<ParallaxWidget> createState() => _ParallaxWidgetState();
}

class _ParallaxWidgetState extends State<ParallaxWidget> {
  late double _pixel;

  @override
  void initState() {
    super.initState();
    _pixel = 0;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notif) {
        setState(() {
          _pixel = notif.metrics.pixels;
        });
        return true;
      },
      child: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ParallaxBody(
                  index: index,
                  pixel: _pixel,
                  parallaxLength: widget.parallaxData.length,
                  data: widget.parallaxData[index],
                );
              },
              childCount: widget.parallaxData.length,
            ),
          ),
        ],
      ),
    );
  }
}

class ParallaxBody extends StatelessWidget {
  final int index;
  final Parallax data;
  final double pixel;
  final int parallaxLength;

  const ParallaxBody({
    Key? key,
    required this.index,
    required this.data,
    required this.pixel,
    required this.parallaxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TornEffect(intensity: 21),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          fit: StackFit.expand,
          children: [
            FractionalTranslation(
              translation: Offset(
                0.0,
                -_calculateParallax(context),
              ),
              child: Image.asset(
                data.image,
                alignment: data.alignment,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 200,
              left: 10,
              child: Container(
                color: const Color(0xffF3B21A),
                child: Text(
                  data.title,
                  style: GoogleFonts.secularOne(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 95,
              right: 20,
              left: 10,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  data.description,
                  style: GoogleFonts.cabin(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _calculateParallax(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double pageHeight = height * index;
    final double childPosition = (pageHeight - pixel) / height;
    return childPosition.isNaN ? 0.0 : childPosition;
  }
}

class TornEffect extends CustomClipper<Path> {
  ///how much the torn effect will be
  final int intensity;

  TornEffect({required this.intensity});

  @override
  ui.Path getClip(ui.Size size) {
    var path = Path();
    //make sure path on left top corner
    path.moveTo(0.0, 0.0);

    var random = math.Random();

    //to prevent blankSpace, move y to top (must always negative):
    double ybase = -20.0;

    //top:
    double topProgress = 0.0;
    while (topProgress < size.width) {
      bool curve = random.nextBool();
      if (curve) {
        double cpx =
            topProgress + random.nextInt(intensity) * 0.5 * negativePositive();
        double cpy =
            ybase + (random.nextInt(intensity) * 0.25 * negativePositive());

        double x =
            topProgress + random.nextInt(intensity) * 1.0 * negativePositive();
        double y =
            ybase + (random.nextInt(intensity) * 0.5 * negativePositive());

        path.quadraticBezierTo(cpx, cpy, x, y);
        topProgress += x.abs();
      } else {
        double x =
            topProgress + random.nextInt(intensity) * 1.0 * negativePositive();
        double y =
            ybase + (random.nextInt(intensity) * 0.5 * negativePositive());
        path.lineTo(x, y);
        topProgress += x.abs();
      }
    }
    //make sure top right corner got shape
    path.lineTo(size.width, 0.0);

    // line to bottom right corner
    path.lineTo(size.width, size.height);

    // you can build bottom rip effect later:
    //double bottomProgress = 0.0;
    //while(){}

    // bottom left
    path.lineTo(0.0, size.height);

    //close it with another line
    path.close();
    return path;
  }

  double negativePositive() {
    var random = math.Random();
    bool negativePositive = random.nextBool();
    double result = negativePositive ? 1.0 : -1.0;
    return result;
  }

  @override
  bool shouldReclip(covariant CustomClipper<ui.Path> oldClipper) {
    return false;
  }
}
