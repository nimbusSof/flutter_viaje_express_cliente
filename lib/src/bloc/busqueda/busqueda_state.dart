part of 'busqueda_bloc.dart';

@immutable
class BusquedaState {
  final bool seleccionManual;
  final bool seleccionManualRecogida;
  final List<SearchResult>? historial;

  BusquedaState({
    this.seleccionManual = false,
    this.seleccionManualRecogida= false, 
    List<SearchResult>? historial
    }): this.historial = historial==null ?[]:historial;

  BusquedaState copyWith({bool? seleccionManual, bool? seleccionManualRecogida, List<SearchResult>? historial}) =>
      BusquedaState(
      seleccionManual: seleccionManual ?? this.seleccionManual,
      seleccionManualRecogida: seleccionManualRecogida ?? this.seleccionManualRecogida,
      historial: historial??this.historial);
}
