part of 'busqueda_bloc.dart';

@immutable
abstract class BusquedaEvent {}

class OnActivaMarcadorManual extends BusquedaEvent{}
class OnDesactivaMarcadorManual extends BusquedaEvent{}
