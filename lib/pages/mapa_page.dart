import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas_app/bloc/mapa/mapa_bloc.dart';
import 'package:mapas_app/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:mapas_app/widgets/widgets.dart';

class MapaPage extends StatefulWidget {

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  
  @override
  void initState() {
    context.bloc<MiUbicacionBloc>().iniciarSeguimiento();
    super.initState();
  }
  
  @override
  void dispose() {
    context.bloc<MiUbicacionBloc>().cancelarSeguimiento();
    super.dispose();
  }
@override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
           title: Text('Mapa', textAlign: TextAlign.center,)
      ),
      body: Stack(
        children: [
          BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
            builder: (_, state) => crearMapa(state)
          ),
          //TODO: Hacer el toggle cuando estoy manualmente
          Positioned(
            top: 5,
            child: SearchBar()
          ),
          
          MarcadorManual()
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BtnUbicacion(),
          BtnSeguirUbicacion(),
          BtnMiRuta(),
        ],
      ),
    );
  }
  
  Widget crearMapa( MiUbicacionState state ){
    if( !state.existeUbicacion) return Center(child: Text('Ubicando...'));
    
    final mapaBloc = BlocProvider.of<MapaBloc>(context);
    
    mapaBloc.add(OnNuevaUbicacion( state.ubicacion));
    //return Text('${ state.ubicacion.latitude }, ${ state.ubicacion.longitude }');
    final cameraPosition = new CameraPosition(
      target: state.ubicacion,
      zoom: 15
    );
    
    return BlocBuilder<MapaBloc, MapaState>(
      builder: (context, _) {
        return GoogleMap(
          initialCameraPosition: cameraPosition,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          onMapCreated: mapaBloc.initMapa,
          polylines: mapaBloc.state.polylines.values.toSet(),
          onCameraMove: ( cameraPosition ) {
            mapaBloc.add( OnMovioMapa( cameraPosition.target ));
          }
        );
      },
    );
    
    
  }
}