import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_viaje_express_cliente/src/models/search_result.dart';
import 'package:meta/meta.dart';

part 'busqueda_event.dart';
part 'busqueda_state.dart';

class BusquedaBloc extends Bloc<BusquedaEvent, BusquedaState> {
  BusquedaBloc() : super(BusquedaState());

  @override
  Stream<BusquedaState> mapEventToState(
    BusquedaEvent event,
  ) async* {
    if (event is OnActivarMarcadorManual) {
      yield state.copyWith(seleccionManual: true);
    } else if (event is OnDesactivarMarcadorManual) {
      yield state.copyWith(seleccionManual: false);
    } else if (event is OnAgregarHistorial) {
      final existe = state.historial
          ?.where(
              (result) => result.nombreLugar == event.result.nombreLugar)
          .length;

      if (existe == 0) {
        final newHistorial = [...state.historial!, event.result];
        yield state.copyWith(historial: newHistorial);
      }
    }else if (event is OnActivarMarcadorManualRecogida) {
      yield state.copyWith(seleccionManualRecogida: true);
    }else if (event is OnDesactivarMarcadorManualRecogida) {
      yield state.copyWith(seleccionManualRecogida: false);
    }
  }
}
