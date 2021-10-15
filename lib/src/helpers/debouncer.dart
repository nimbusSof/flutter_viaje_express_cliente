import 'dart:async';
// Creditos
// https://stackoverflow.com/a/52922130/7834829

//Objetivo de la clse Debouncer
//Emitir el valor que se captura en el parámetro onVlaue 
//a un stream luego de que pase el tiempo determinado
//afignado a el parámetro duration

//Esta clase es utilizada en el SearchDelegate para emitir
//el servicio de busqueda con el nombre del lugar 
//luego de que se termine de escribir y no con cada letra que se presione


class Debouncer<T> {

  Debouncer({ 
    required this.duration, 
    this.onValue 
  });

  final Duration duration;

  void Function(T value)? onValue;

  T? _value;
  Timer? _timer;
  
  T get value => _value!;

  set value(T val) {
    _value = val;
    _timer?.cancel();
    _timer = Timer(duration, () => onValue!(_value!));
  }  
}