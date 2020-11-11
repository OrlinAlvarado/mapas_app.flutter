part of 'custom_markers.dart';

class MarkerInicioPainter extends CustomPainter {
  
  final int minutos;

  MarkerInicioPainter(this.minutos);
    
  @override
  void paint(Canvas canvas, Size size) {
    
    final double circuloNegroR = 20;
    final double circuloBlanco = 7;
    Paint paint = new Paint()
    ..color = Colors.black;
    
    //Dibujar circulo negro
    canvas.drawCircle(
      Offset(circuloNegroR, size.height - circuloNegroR), 
      circuloNegroR, 
      paint
    ); 
    
    //Circulo Blanco
    paint.color = Colors.white;
    
    canvas.drawCircle(
      Offset(circuloNegroR, size.height - circuloNegroR), 
      circuloBlanco, 
      paint
    ); 
    
    final Path path = new Path();
    path.moveTo( 40, 20);
    path.lineTo( size.width - 10, 20);
    path.lineTo( size.width - 10, 100);
    path.lineTo( 40, 100);
    
    
    canvas.drawShadow(path, Colors.black87, 10, false);
    
    //Caja blanca
    final cajaBlanca = Rect.fromLTWH(40, 20, size.width - 50, 80);   
    canvas.drawRect( cajaBlanca, paint);
    
    //Caja negra
    paint.color = Colors.black;
    final cajaNegra = Rect.fromLTWH(40, 20, 70, 80);   
    canvas.drawRect( cajaNegra, paint);
        
    //Dibujar textos
    TextSpan textSpan = new TextSpan(
      style: TextStyle( color: Colors.white, fontSize: 30, fontWeight: FontWeight.w400),
      text: '$minutos'
    );
    
    TextPainter textPainter = new TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center
    )..layout(
      minWidth: 70,
      maxWidth: 70
    );
    
    textPainter.paint(canvas, Offset(40, 35));
    
    //Minutos
    textSpan = new TextSpan(
      style: TextStyle( color: Colors.white, fontSize: 25, fontWeight: FontWeight.w400),
      text: 'Min'
    );
    
    textPainter = new TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center
    )..layout(
      minWidth: 70,
      maxWidth: 70
    );
    
    textPainter.paint(canvas, Offset(40, 65));
    
    //Mi ubicacion
    textSpan = new TextSpan(
      style: TextStyle( color: Colors.black, fontSize: 22, fontWeight: FontWeight.w400),
      text: 'Mi ubicación'
    );
    
    textPainter = new TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center
    )..layout(
      maxWidth: size.width - 130
    );
    
    textPainter.paint(canvas, Offset(160, 50));
    
  }

  @override
  bool shouldRepaint(MarkerInicioPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(MarkerInicioPainter oldDelegate) => false;
}