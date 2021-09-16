import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/bloc/busqueda/busqueda_bloc.dart';

class CustomButtonDrawer extends StatefulWidget {
  final GlobalKey<ScaffoldState> scafoldKey;

  const CustomButtonDrawer({required this.scafoldKey});


  @override
  _CustomButtonDrawerState createState() => _CustomButtonDrawerState();
}

class _CustomButtonDrawerState extends State<CustomButtonDrawer> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (BuildContext context, state) {
        if (state.seleccionManual) {
          return Container();
        } else if(state.seleccionManualRecogida){
          return Container();
        }else{
          return _buildButtonDrawer();
        }
      },
    );
  }


  Widget _buildButtonDrawer(){
     return Container(
      alignment: Alignment.centerLeft,
      child: IconButton(
        onPressed: () => this.widget.scafoldKey.currentState!.openDrawer(),
        icon: Icon(
          Icons.menu,
          size: 35,
          color: Colors.black,
        ),
      ),
    );
  }
}
