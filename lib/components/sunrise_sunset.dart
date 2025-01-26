import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:project/utils/screen_util.dart';

class MovingWave extends StatefulWidget {
  const MovingWave({super.key});

  @override
  _MovingWaveState createState() => _MovingWaveState();
}

class _MovingWaveState extends State<MovingWave>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1), // Updates every second
    )..repeat(); // Infinite loop
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Determine the gradient based on the time of day
  LinearGradient _getGradientForTimeOfDay() {
    TimeOfDay currentTime = TimeOfDay.now();
    if (currentTime.hour >= 5 && currentTime.hour < 12) {
      // Morning: Light blue to blue to black
      return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.lightBlue.shade300,
          Colors.blue.shade600,
          Colors.black,
        ],
      );
    } else if (currentTime.hour >= 12 && currentTime.hour < 17) {
      // Afternoon: Sky blue to medium blue to black
      return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.lightBlue.shade500,
          Colors.blue.shade700,
          Colors.black,
        ],
      );
    } else if (currentTime.hour >= 17 && currentTime.hour < 20) {
      // Evening: Medium blue to dark blue to black
      return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.blue.shade600,
          Colors.blue.shade900,
          Colors.blueGrey.shade900,
        ],
      );
    } else {
      // Night: Deep blue to darker blue to black
      return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.blue.shade800,
          Colors.blue.shade900,
          Colors.black,
        ],
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final screenUtils = ScreenUtil(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background container with the wave
          Container(
            width: screenUtils.widthPercentage(100),
            height: screenUtils.scaleHeight(120),
            decoration: BoxDecoration(
              gradient: _getGradientForTimeOfDay(),
              borderRadius: BorderRadius.circular(20),
            ),
            child: CustomPaint(
              painter: WaveWithMovingCirclePainter(_controller),
            ),
          ),
          // Top-left text
          Positioned(
            top: 10,
            left: 15,
            child: Row(
              spacing: 5,
              children: [
                Icon(
                  Icons.sunny,
                  color: Colors.yellow,
                  size: 16,
                ),
                Text(
                  'Sunrise 6:40am',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Top-right text
          Positioned(
            top: 10,
            right: 15,
            child: Row(
              spacing: 5,
              children: [
                Icon(
                  Icons.sunny_snowing,
                  color: Colors.yellow,
                  size: 16,
                ),
                Text(
                  'Sunset 6:40am',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WaveWithMovingCirclePainter extends CustomPainter {
  final Animation<double> animation;

  WaveWithMovingCirclePainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    Paint wavePaint = Paint()
      ..color = Colors.white70
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    Paint traveledPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    Paint linePaint = Paint()
      ..color = Colors.white70.withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Draw the horizontal line at 3/4 of the container height
    double lineHeight = size.height * 3 / 4;
    canvas.drawLine(
      Offset(0, lineHeight),
      Offset(size.width, lineHeight),
      linePaint,
    );

    // Draw the wave
    Path wavePath = Path();
    wavePath.moveTo(0, size.height - 10);
    wavePath.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.1 - 10,
      size.width,
      size.height - 10,
    );

    // Calculate wave path metrics
    PathMetrics pathMetrics = wavePath.computeMetrics();
    PathMetric pathMetric = pathMetrics.first;
    double pathLength = pathMetric.length;

    // Map current time to path position
    DateTime now = DateTime.now();
    int totalSeconds = now.hour * 3600 + now.minute * 60 + now.second;
    double t = (totalSeconds / (24 * 3600)) * pathLength;

    // Draw the traveled and untraveled paths
    Path traveledPath = pathMetric.extractPath(0, t);
    Path untraveledPath = pathMetric.extractPath(t, pathLength);

    canvas.drawPath(traveledPath, traveledPaint);
    canvas.drawPath(untraveledPath, wavePaint);

    // Draw the moving circle
    Tangent? position = pathMetric.getTangentForOffset(t);
    if (position != null) {
      Offset circlePosition = position.position;

      // Glowing effect
      double glowRadius = 15;
      Paint glowPaint = Paint()
        ..shader = RadialGradient(
          colors: [
            Colors.white.withOpacity(0.8),
            Colors.white.withOpacity(0.0)
          ],
          stops: [0.0, 1.0],
        ).createShader(
            Rect.fromCircle(center: circlePosition, radius: glowRadius));

      canvas.drawCircle(circlePosition, glowRadius, glowPaint);

      // Solid circle
      Paint circlePaint = Paint()..color = Colors.white;
      canvas.drawCircle(circlePosition, 10, circlePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
