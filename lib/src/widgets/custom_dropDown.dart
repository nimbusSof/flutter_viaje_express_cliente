import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  final List<String> lista;

  const CustomDropDown({required this.lista});

  @override
  _CustomDropDownState createState() => _CustomDropDownState(lista);
}

class _CustomDropDownState extends State<CustomDropDown> {

 
  final List<String> listaGenero;
  _CustomDropDownState(this.listaGenero);

  String dropdownValue = 'masculino'; //si este valor fuera diferente a los que hay en la lista, dará error
 


  
  @override
  Widget build(BuildContext context) {
    
    //print('comprobando lista: ${this.listaGenero.length}');
    return Container(
      padding: EdgeInsets.only(top: 5, left: 40, bottom: 5, right: 20),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration( // define las caracteristicas visuales del container
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
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
        style: const TextStyle(color: Colors.deepPurple),
        underline: SizedBox(),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
        items: getOpcionesDropdown(),
      ),
    );
  }


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
