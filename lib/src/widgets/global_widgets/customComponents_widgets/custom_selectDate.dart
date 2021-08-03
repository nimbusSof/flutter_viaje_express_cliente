import 'package:flutter/material.dart';

class CustomSelectDate extends StatefulWidget {
  final TextEditingController inputFieldDataController;
  final String? texto;

  const CustomSelectDate({required this.inputFieldDataController, this.texto});

  @override
  _CustomSelectDateState createState() =>
      _CustomSelectDateState(inputFieldDataController, texto);
}

class _CustomSelectDateState extends State<CustomSelectDate> {
  final TextEditingController inputFieldDataController;
  final String? texto;
  String _fecha = '';

  _CustomSelectDateState(this.inputFieldDataController, this.texto);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          // define las caracteristicas visuales del container
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: Offset(0, 5),
                blurRadius: 5)
          ]),
      child: TextField(
        enableInteractiveSelection: false,
        controller: inputFieldDataController,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.calendar_today),
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: this.texto!=null?this.texto:'Fecha de nacimiento',
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          _selectDate(context);
        },
      ),
    );
  }

  void _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2020),
        lastDate: new DateTime(2025));

    if (picked != null) {
      setState(() {
        _fecha = picked.toString();
        inputFieldDataController.text = _fecha;
      });
    }
  }
}
