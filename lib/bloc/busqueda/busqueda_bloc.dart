import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mapas_app/models/search_result.dart';
import 'package:meta/meta.dart';

part 'busqueda_event.dart';
part 'busqueda_state.dart';

class BusquedaBloc extends Bloc<BusquedaEvent, BusquedaState> {
  BusquedaBloc() : super( BusquedaState() );

  @override
  Stream<BusquedaState> mapEventToState(BusquedaEvent event) async* {
    if( event is OnActivaMarcadorManual ){
      yield state.copyWith(seleccionManual: true);
    } else if( event is OnDesactivaMarcadorManual ){
      yield state.copyWith(seleccionManual: false);
    } else if( event is OnAgregarHistorial){
      
      final existe = state.historial.where(
        (result) => result.nombreDestino == event.result.nombreDestino
      );
       
      if(existe.length == 0)
      {
        final newHistorial = [ ...state.historial, event.result ];
        yield state.copyWith( historial: newHistorial );
      }
      
    }
  }
}
