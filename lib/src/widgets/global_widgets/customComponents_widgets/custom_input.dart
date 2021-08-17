import 'package:flutter/material.dart';


class CustomInput extends StatefulWidget {
  final IconData icon;
  final String placeHolder;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final bool isPassword;
  final IconData? sufixIcon;

  const CustomInput(
      {Key? key,
      required this.icon,
      required this.placeHolder,
      required this.textController,
      this.keyboardType = TextInputType.text,
      this.isPassword = false,
      this.sufixIcon})
      : super(key: key);

  @override
  _CustomInputState createState() => _CustomInputState(
      icon, placeHolder, textController, keyboardType, isPassword, sufixIcon);
}

class _CustomInputState extends State<CustomInput> {
  _CustomInputState(
      IconData icon,
      String placeHolder,
      TextEditingController textController,
      TextInputType keyboardType,
      bool isPassword,
      IconData? sufixIcon);
  bool passwordVisible = true;
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
        // propiedades el tipo de input

        controller: this.widget.textController,
        autocorrect: false,
        keyboardType: this.widget.keyboardType,
        obscureText: this.widget.isPassword == true
            ? passwordVisible
            : this.widget.isPassword,

        //propiedades visuales del input
        decoration: InputDecoration(
            prefixIcon: Icon(this.widget.icon),
            
            suffixIcon: this.widget.sufixIcon != null
                ? InkWell(// al iconono se le da la propiedad de poder ejecutar un evento
                    onTap:  _togglePasswordView,
                    child: Icon(this.widget.sufixIcon),
                  )
                : null,
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: this.widget.placeHolder),
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
