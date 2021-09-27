import 'package:easy_localization/easy_localization.dart';
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
  DateTime _fecha = DateTime.now();

  _CustomSelectDateState(this.inputFieldDataController, this.texto);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6),
    
      child: TextFormField(
        enableInteractiveSelection: false,
        controller: inputFieldDataController,
        validator: (value) {
          if (value != null && value.length > 0) {
            return null;
          } else {
            return 'alertsGlobals.fechaNac.null'.tr();
          }
        },
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            prefixIcon: Icon(Icons.calendar_today),
            
            //focusedBorder: InputBorder.none,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            hintText: this.texto != null ? this.texto : 'inputsGlobals.fechaNacimiento'.tr()),
        
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
        firstDate: new DateTime(1925),
        lastDate: new DateTime.now());

    if (picked != null) {
      setState(() {
        //_fecha = '${picked.year}-${picked.month}-${picked.day}';
        _fecha = picked;
        inputFieldDataController.text = _fecha.toString();
      });
    }
  }
}
