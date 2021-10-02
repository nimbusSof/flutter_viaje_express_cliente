import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class RbtnMetodoPago extends StatefulWidget {
  @override
  _RbtnMetodoPagoState createState() => _RbtnMetodoPagoState();
}

class _RbtnMetodoPagoState extends State<RbtnMetodoPago> {
  int _pago = 1;

  void _setSelectedRadio(dynamic valor) {
    _pago = valor;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.only(top: 10, bottom: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'viajeNuevo.radioButton.titulo'.tr(),
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.only(top: 2, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                      value: 1,
                      
                      groupValue: _pago,
                      onChanged: _setSelectedRadio,
                    ),
                    Icon(Icons.credit_card),
                    SizedBox(width: 10,),
                    Text('viajeNuevo.radioButton.tarjeta'.tr()),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                      value: 2,
                      
                      groupValue: _pago,
                      onChanged: _setSelectedRadio,
                    ),
                    Icon(Icons.paid),
                    SizedBox(width: 10,),
                    Text('viajeNuevo.radioButton.efectivo'.tr()),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
