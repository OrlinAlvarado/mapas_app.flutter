import 'package:flutter/material.dart';
import 'package:mapas_app/custom_markers/custom_markers.dart';

class TestMarkerPage extends StatelessWidget {

@override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
           title: Text('TestMarker', textAlign: TextAlign.center,)
      ),
      body: Center(
        child: Container(
          width: 350,
          height: 150,
          color: Colors.red,
          child: CustomPaint(
            // painter: MarkerInicioPainter(25),
            painter: MarkerDestinoPainter(
              'Mi casa por cualquier lado del mundo, esta aqui, otra cosa', 
              360904),
          ),
        )
      ),
    );
  }
}