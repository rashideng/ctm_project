import 'package:ctm_project/pages/Divider.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as math;
import 'package:intl/intl.dart';

void main() {
  runApp(DashBoard());
}

class _RadialProgress extends StatelessWidget {
  final double height, width, progress;

  const _RadialProgress({Key key, this.height, this.width, this.progress})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _RadialPainter(progress: 1),
      child: Container(
        height: height,
        width: width,
        child: Center(
          child: RichText(
            text: TextSpan(children: [
              TextSpan(
                text: "14°C",
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

class _RadialPainter extends CustomPainter {
  final double progress;

  _RadialPainter({this.progress});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 10
      ..color = Colors.black54
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double relativeProgress = 270 * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: size.width / 2),
      math.radians(135),
      math.radians(relativeProgress),
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class DashBoard extends StatelessWidget {
  static const String idScreen = "Dashboard";
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final today = DateTime.now();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Dash Board"),
          backgroundColor: Color(0xFF4A4A58),
        ),
        drawer: Container(
          color: Color(0xFF4A4A58),
          width: 255,
          child: Drawer(
            child: ListView(
              children: [
                //drawer header
                Container(
                  height: 165.0,
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        colors: [
                          Color(0xFF4A4A58),
                          Colors.black87,
                        ],
                      ),
                    ),
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Mohamed Rashid",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              "View Profile",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                DividerWidget(),
                SizedBox(
                  height: 12,
                ),
                ListTile(
                  leading: Icon(Icons.add_chart),
                  title: Text(
                    "Dashboard",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.ac_unit),
                  title: Text(
                    "Humidity",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.auto_fix_off),
                  title: Text(
                    "Temperature",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.location_on_rounded),
                  title: Text(
                    "Location",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.build),
                  title: Text(
                    "Settings",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text(
                    "Visit Profile",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: const Color(0xFFE9E9E9),
        body: Stack(
          children: [
            Positioned(
              top: 0,
              height: height * 0.45,
              left: 0,
              right: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: const Radius.circular(40),
                ),
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 52,
                    right: 10,
                    bottom: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(
                          "${DateFormat("EEEE").format(today)}, ${DateFormat("d MMMM").format(today)},",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                        subtitle: Text(
                          "Stats",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      _RadialProgress(
                        width: height * 0.2,
                        height: height * 0.2,
                        progress: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: height * 0.48,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.white,
                height: height * 0.6,
              ),
            )
          ],
        ),
      ),
    );
  }
}
