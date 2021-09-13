import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/bloc/busqueda/busqueda_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/models/search_result.dart';
import 'package:flutter_viaje_express_cliente/src/pages/search/search_destino.dart';


import 'package:provider/provider.dart';

class CustomInputSearchDestino extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
  
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric( horizontal: 30 ),
        width: width,
        child: GestureDetector(
          onTap: () async {
            
            final resultado = await showSearch(context: context, delegate: SearchDestino());
            this.retornoBusqueda( context, resultado! );
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
            width: double.infinity,
            child: Text('Escoje tu destino', style: TextStyle( color: Colors.black87 )),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: <BoxShadow>[
                BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 5))
              ]
            ),
          ),
        ),
      ),
    );  
  }

  void retornoBusqueda(BuildContext context, SearchResult result) {
    if (result.cancelo) return;

    if (result.manual!) {
      context.read<BusquedaBloc>().add(OnActivarMarcadorManual());
      return;
    }
  }
}
