import 'package:flutter/material.dart';
import 'package:studymate/widgets/ActivitiesGraph/GraphData.dart';

class Graph extends StatelessWidget {
  final AnimationController animationController;
  final List<GraphData> values;
  final double height;

  Graph({this.animationController, this.height = 120, this.values});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildBars(values),
      ),
    );
  }

  _buildBars(List<GraphData> values) {
    List<GraphBar> _bars = List();
    GraphData _maxGraphData = values.reduce(
        (current, next) => (next.compareTo(current) >= 1 ? next : current));

    values.forEach((graphData) {
      double percentage = graphData.value / _maxGraphData.value;
      _bars.add(GraphBar(
        height: height,
        percentage: percentage,
        graphBarAnimationController: animationController,
      ));
    });

    return _bars;
  }
}

class GraphBar extends StatefulWidget {
  final double height;
  final double percentage;
  final AnimationController graphBarAnimationController;

  GraphBar({this.height, this.percentage, this.graphBarAnimationController});

  @override
  _GraphBarState createState() => _GraphBarState();
}

class _GraphBarState extends State<GraphBar> {
  Animation<double> _percentageAnimation;

  @override
  void initState() {
    super.initState();
    _percentageAnimation = Tween<double>(begin: 0, end: widget.percentage)
        .animate(widget.graphBarAnimationController);

    _percentageAnimation.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      // painter: BarPainter(_percentageAnimation.value),
      painter: BarPainter(widget.percentage),
      child: Container(
        height: widget.height,
        color: Colors.deepPurpleAccent,
      ),
    );
  }
}

class BarPainter extends CustomPainter {
  final double percentage;

  BarPainter(this.percentage);

  @override
  void paint(Canvas canvas, Size size) {
    Paint greyPaint = Paint()
      ..color = Colors.white70
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    Offset topPoint = Offset(0, 0);
    Offset bottomPoint = Offset(0, (size.height + 20));
    Offset centerPoint = Offset(0, (size.height + 20) / 2);

    canvas.drawLine(topPoint, bottomPoint, greyPaint);

    Paint filledPaint = Paint()
      ..shader = LinearGradient(
              colors: [Colors.pink.shade500, Colors.blue.shade500],
              begin: Alignment.topCenter)
          .createShader(Rect.fromPoints(topPoint, bottomPoint))
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    double filledHeight = percentage * size.height;
    double filledHalfHeight = filledHeight / 2;

    canvas.drawLine(
        centerPoint, Offset(0, centerPoint.dy - filledHalfHeight), filledPaint);
    canvas.drawLine(
        centerPoint, Offset(0, centerPoint.dy + filledHalfHeight), filledPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
