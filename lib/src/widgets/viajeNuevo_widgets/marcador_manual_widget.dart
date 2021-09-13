import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/bloc/busqueda/busqueda_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/providers/slidingUpPanel_provider.dart';

import 'package:provider/provider.dart';

class MarcadorManual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {
        if (state.seleccionManual) {
          return _BuildMarcadorManual();
        } else {
          return Container();
        }
      },
    );
  }
}

class _BuildMarcadorManual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        //Boton regresar
        Positioned(
            top: 30,
            left: 20,
            child: CircleAvatar(
              maxRadius: 25,
              backgroundColor: Colors.white,
              child: IconButton(
                  onPressed: () {
                    //context.read<SlidingUpPanelProvider>().reiniciar();
                    context
                        .read<BusquedaBloc>()
                        .add(OnDesactivarMarcadorManual());
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black87,
                  )),
            )),

        Center(
          child: Transform.translate(
            offset: Offset(0, -12),
            child: Icon(
              Icons.location_on,
              size: 50,
            ),
          ),
        ),

        //boton confirmar destino
        Positioned(
            bottom: 30,
            left: 50,
            child: MaterialButton(
              minWidth: width - 120,
              child: Text(
                'Confirmar destino',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.black,
              shape: StadiumBorder(),
              elevation: 0,
              splashColor: Colors.transparent,
              onPressed: () {},
            ))
      ],
    );
  }
}
