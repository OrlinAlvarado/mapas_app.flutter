part of 'busqueda_bloc.dart';

@immutable
abstract class BusquedaEvent {}

class OnActivaMarcadorManual extends BusquedaEvent{}
class OnDesactivaMarcadorManual extends BusquedaEvent{}
class OnAgregarHistorial extends BusquedaEvent{
  final SearchResult result;

  OnAgregarHistorial(this.result);
}
