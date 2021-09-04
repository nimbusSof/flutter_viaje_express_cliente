import 'package:flutter/material.dart';
import 'package:flutter_viaje_express_cliente/src/services/services.dart';
import 'package:provider/provider.dart';

class CustomDropDown extends StatefulWidget {
  final List<String> lista;
  const CustomDropDown(
      {required this.lista}); // constructor para traer la lista desde otro widget

  @override
  _CustomDropDownState createState() => _CustomDropDownState(lista);
}

class _CustomDropDownState extends State<CustomDropDown> {
  final List<String> listaGenero;
  _CustomDropDownState(this.listaGenero);

  String dropdownValue =
      'masculino'; //si este valor fuera diferente a los que hay en la lista, daría error

  @override
  Widget build(BuildContext context) {
    final signUpService = Provider.of<SignUpServide>(context);

    //se valida que haya un genero seleccionado en el estado de signUpService
    dropdownValue = signUpService.cliente.genero!=''?signUpService.cliente.genero:dropdownValue;

    return Container(
      padding: EdgeInsets.only(top: 5, left: 40, bottom: 5, right: 20),
      margin:  EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          // define las caracteristicas visuales del container
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: Offset(0, 5),
                blurRadius: 5)
          ]),
      child: DropdownButton(
        value: dropdownValue,
        isExpanded: true,
        icon: const Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple, fontSize: 17),
        underline: SizedBox(),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
            signUpService.agregarGenero(dropdownValue);
          });
        },
        items: getOpcionesDropdown(),
      ),
    );
  }

// esta función recorre la lista para crear los items del DropDown
  List<DropdownMenuItem<String>> getOpcionesDropdown() {
    List<DropdownMenuItem<String>> lista = [];
    this.listaGenero.forEach((genero) {
      lista.add(DropdownMenuItem(
        child: Text(genero),
        value: genero,
      ));
    });

    return lista;
  }
}
