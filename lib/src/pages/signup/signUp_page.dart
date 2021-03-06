import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/bloc/signUp_bloc/signUp_bloc.dart';


import 'package:flutter_viaje_express_cliente/src/providers/signup/forms_signUp_provider.dart';


import 'package:flutter_viaje_express_cliente/src/widgets/signUp_widget/forms.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/signUp_widget/logo_signUp.dart';
import 'package:provider/provider.dart';



class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SignUpBloc(),
        )
      ],
      child: Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics:
                BouncingScrollPhysics(), //animacion rebote tanto en IOs como en android
            child: Container(
              //height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  LogoSignIn(),
                  SizedBox(height: 35),
                  SiguientePanel(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SiguientePanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (_, state) {
      if (state.opcion == 0) {
        return ChangeNotifierProvider(
          create: (_) => SignUpFormProvider(),
          child: Form0());
      } else if (state.opcion == 1) {
        return ChangeNotifierProvider(
          create: (_) => SignUpFormProvider(),
          child: Form1());
      } else if (state.opcion == 2) {
        return ChangeNotifierProvider(
          create: (_) => SignUpFormProvider(),
          child: Form2());
      } else {
        return ChangeNotifierProvider(
          create: (_) => SignUpFormProvider(),
          child: Form0());
      }
    });
  }
}







