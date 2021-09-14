part of 'validaciones.dart';

bool cedulaEcuatorianaValida(String cedula) {
  int sum = 0;
  try {
    if (cedula.trim().length != 10) {
      return false;
    }
    List<String> data = cedula.split("");
    int verifier = int.parse(data[0] + data[1]);
    if (verifier < 1 || verifier > 24) {
      return false;
    }
    List<int> digits = new List<int>.filled(data.length, 0,
        growable:
            false); // growable significa que la lista tendrá un tamaño fijo no modificable

    for (var i = 0; i < digits.length; i++) {
      digits[i] = int.parse(data[i]);
    }
    if (digits[2] > 6) {
      return false;
    }
    for (var i = 0; i < digits.length-1; i++) {
      if (i % 2 == 0) {
        verifier = digits[i] * 2;
        if (verifier > 9) {
          verifier = verifier - 9;
        }
      } else {
        verifier = digits[i] * 1;
      }
      sum = sum + verifier;
    }
    if ((sum - (sum % 10) + 10 - sum) == digits[9]) {
      return true;
    }
  } catch (e) {
    print(e);
  }

  return false;
}
