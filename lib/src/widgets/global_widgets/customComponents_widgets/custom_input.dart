import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInput extends StatefulWidget {
  final IconData icon;
  final String placeHolder;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final bool isPassword;
  final IconData? sufixIcon;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatter;

  const CustomInput(
      {Key? key,
      required this.icon,
      required this.placeHolder,
      required this.textController,
      FormFieldValidator<String>? validator,
      List<TextInputFormatter>? inputFormatter,
      this.keyboardType = TextInputType.text,
      this.isPassword = false,
      this.sufixIcon})
      : this.validator = validator,
        this.inputFormatter = inputFormatter;

  @override
  _CustomInputState createState() => _CustomInputState(icon, placeHolder,
      textController, keyboardType, isPassword, sufixIcon, validator!);
}

class _CustomInputState extends State<CustomInput> {
  _CustomInputState(
      IconData icon,
      String placeHolder,
      TextEditingController textController,
      TextInputType keyboardType,
      bool isPassword,
      IconData? sufixIcon,
      void Function(String item) validator);

  bool passwordVisible =
      true; //se modifica si el parametro isPassword==false //metodo _togglePasswordView()

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        // propiedades el tipo de input
        //autofocus: true,
        key: this.widget.key,
        controller: this.widget.textController,
        onChanged: (value) => this.widget.textController.text,
        autocorrect: false,
        keyboardType: this.widget.keyboardType,
        obscureText: this.widget.isPassword == true
            ? passwordVisible
            : this.widget.isPassword,

        //propiedades visuales del input
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            prefixIcon: Icon(this.widget.icon),
            suffixIcon: this.widget.sufixIcon != null
                ? InkWell(
                    // al iconono se le da la propiedad de poder ejecutar un evento
                    onTap: _togglePasswordView,
                    child: Icon(this.widget.sufixIcon),
                  )
                : null,
            //focusedBorder: InputBorder.none,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            hintText: this.widget.placeHolder),

        validator: this.widget.validator,
        inputFormatters: this.widget.inputFormatter!.length > 0
            ? this.widget.inputFormatter
            : [],
      ),
    );
  }

//evento para hacer visible el password
  void _togglePasswordView() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }
}
