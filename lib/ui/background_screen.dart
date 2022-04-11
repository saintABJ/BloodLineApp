import 'package:flutter/material.dart';
import 'package:flutter_polygon_clipper/flutter_polygon_clipper.dart';

class BaseScreen extends StatefulWidget {
  final Widget child;
  const BaseScreen({Key? key, required this.child}) : super(key: key);
  @override
  _BasescreenState createState() => _BasescreenState();
}

class _BasescreenState extends State<BaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff44130f),
      child: Stack(clipBehavior: Clip.none, children: <Widget>[
        Align(
          alignment: Alignment.topRight,
          child: FractionalTranslation(
            translation: const Offset(0.35, -0.20),
            child: Container(
              child: SizedBox(
                height: 300,
                child: FlutterClipPolygon(
                  sides: 6,
                  rotate: 120,
                  borderRadius: 15,
                  child: Container(
                    // alignment: Alignment.bottomLeft,
                    color: Colors.red,
                    child: const Icon(
                              Icons.water,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: FractionalTranslation(
            translation: const Offset(-.50, 0.45),
            child: Container(
              child: SizedBox(
                height: 300,
                width: 300,
                child: FlutterClipPolygon(
                  sides: 6,
                  rotate: 300,
                  borderRadius: 15,
                  child: Container(
                    color: Colors.red,
                    child: Container(
                      alignment: Alignment.topRight,
                      child: const Icon(
                        Icons.water,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 900,
          child: SizedBox(
            height: 100,
            child: FlutterClipPolygon(
              sides: 6,
              rotate: 120,
              borderRadius: 20,
              child: Container(
                child: const SizedBox(
                  height: 2,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
              child: Container(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height),
                  child: widget.child)),
        ),
      ]),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = Path();

    p.moveTo(size.width / 2, 0);
    p.arcToPoint(const Offset(-20, -20));
    p.lineTo(size.width, size.height / 3);
    p.lineTo(size.width, size.width * 2 / 3);
    p.lineTo(size.width / 2, size.height);
    p.lineTo(0, size.height * 2 / 3);
    p.lineTo(0, size.height / 3);
    p.lineTo(size.width / 2, 0);
    return p;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
