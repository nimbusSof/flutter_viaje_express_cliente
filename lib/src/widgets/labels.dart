import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/bloc/signUp_bloc/signUp_bloc.dart';

import 'package:flutter_viaje_express_cliente/src/services/services.dart';
import 'package:provider/provider.dart';

class Labels extends StatelessWidget {
  final String ruta;
  final String titulo;
  final String subtitulo;

  const Labels(
      {Key? key,
      required this.ruta,
      required this.titulo,
      required this.subtitulo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final signUpService = Provider.of<SignUpProvider>(context);
    return Container(
      child: Column(
        children: <Widget>[
          Text(this.titulo,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15,
                  fontWeight: FontWeight.w300)),
          SizedBox(height: 10),
          GestureDetector(
            child: Text(this.subtitulo,
                style: TextStyle(
                    color: Colors.blue[600],
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            onTap: () {
              signUpService.removerCliente();
              Navigator.pushReplacementNamed(context, this.ruta);
            },
          )
        ],
      ),
    );
  }
}

class LabelCancelar extends StatelessWidget {
  final String subtitulo;

  const LabelCancelar({Key? key, required this.subtitulo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final signUpService = Provider.of<SignUpProvider>(context);
    return Container(
      padding: EdgeInsets.only(top: 25),
      child: GestureDetector(
        child: Text(this.subtitulo,
            style: TextStyle(
                color: Colors.blue[600],
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        onTap: () {
          signUpService.removerCliente();
          BlocProvider.of<SignUpBloc>(context).add(CambiarPanel(0));
        },
      ),
    );
  }
}

class LabelOlvideClave extends StatelessWidget {
  final String subtitulo;

  const LabelOlvideClave({Key? key, required this.subtitulo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5),
      child: GestureDetector(
        child: Text(this.subtitulo,
            style: TextStyle(
                color: Colors.blue[600],
                fontSize: 18,
                fontWeight: FontWeight.w300)),
        onTap: () {
          Navigator.pushReplacementNamed(context, 'reiniciar_clave');
        },
      ),
    );
  }
}



class LabelSignUp extends StatelessWidget {
  final String ruta;
  final String subtitulo;

  const LabelSignUp(
      {Key? key,
      required this.ruta,
      required this.subtitulo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final signUpService = Provider.of<SignUpProvider>(context);
    return Container(
      child: Column(
        children: <Widget>[
          
          GestureDetector(
            child: Text(this.subtitulo,
                style: TextStyle(
                    color: Colors.blue[600],
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            onTap: () {
              signUpService.removerCliente();
              Navigator.pushReplacementNamed(context, this.ruta);
            },
          )
        ],
      ),
    );
  }
}