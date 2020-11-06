import 'dart:async';

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:mapas_app/helpers/debouncer.dart';
import 'package:mapas_app/models/driving_response.dart';
import 'package:mapas_app/models/search_response.dart';

class TrafficService {
  
  //Singleton
  
  TrafficService._privateConstructor();
  
  static final TrafficService _instance = TrafficService._privateConstructor();
  
  factory TrafficService(){
    return _instance;
  }
  
  
  final _dio = new Dio();
  final debouncer = Debouncer<String>(duration: Duration(milliseconds: 400 ));
  
  final StreamController<SearchResponse> _sugerenciasStreamController = new StreamController<SearchResponse>.broadcast();
  
  Stream<SearchResponse> get sugerenciasStream => this._sugerenciasStreamController.stream;
  
  final _baseUrlDir = 'https://api.mapbox.com/directions/v5';
  final _baseUrlGeo = 'https://api.mapbox.com/geocoding/v5';
  final _apiKey = 'pk.eyJ1Ijoib3JsaW5hbHZhcmFkbyIsImEiOiJja2gwa3JvZDgwMmp5Mnhta2ozdG8zNndoIn0.i1OA_8KlPVV1vnXa9J_j9g';
  
  
  Future<DrivingResponse> getCoordsInicioYDestino( LatLng inicio, LatLng destino) async {
    final coordString = '${ inicio.longitude },${ inicio.latitude };${ destino.longitude },${ destino.latitude }';
    final url = '${ this._baseUrlDir }/mapbox/driving/$coordString';
    
    final resp = await this._dio.get(url, queryParameters: {
      'alternatives': 'true',
      'geometries'  : 'polyline6',
      'steps'       : 'false',
      'access_token': this._apiKey,
      'language'    : 'es',
    });
    
    final data = DrivingResponse.fromJson(resp.data);
    return data;
  }
  
  Future<SearchResponse> getResultadosPorQuery( String busqueda, LatLng proximidad) async{
    print('Buscando...');
    
    final url = '${ this._baseUrlGeo }/mapbox.places/$busqueda.json';
    
    try {
      final resp = await this._dio.get(url, queryParameters: {
        'access_token': this._apiKey,
        'autocomplete': 'true',
        'proximity'   : '${ proximidad.longitude },${ proximidad.latitude }',
        'language'    : 'es'
      });
      
      final searchResponse = searchResponseFromJson(resp.data);
      
      return searchResponse;
      
    } catch (e) {
      return SearchResponse(features:[]);
    }
  }
  
  void getSugerenciasPorQuery( String busqueda, LatLng proximidad ) {

  debouncer.value = '';
  debouncer.onValue = ( value ) async {
    final resultados = await this.getResultadosPorQuery(value, proximidad);
    this._sugerenciasStreamController.add(resultados);
  };

  final timer = Timer.periodic(Duration(milliseconds: 200), (_) {
    debouncer.value = busqueda;
  });

  Future.delayed(Duration(milliseconds: 201)).then((_) => timer.cancel()); 

}
}