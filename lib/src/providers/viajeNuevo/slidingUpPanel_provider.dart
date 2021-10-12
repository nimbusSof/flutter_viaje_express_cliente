import 'package:flutter/cupertino.dart';

class SlidingUpPanelProvider extends ChangeNotifier {
  double _fabHeight = 90.0;

  double get fabHeight => this._fabHeight;

  set fabHeight(double fabHeight) {
    this._fabHeight = fabHeight;
    notifyListeners();
  }

  void reiniciar() {
    this.fabHeight = 90.0;
    notifyListeners();
  }
}
