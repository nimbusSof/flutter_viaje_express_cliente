import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_viaje_express_cliente/src/bloc/signIn_bloc/signin_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/providers/signIn_provider.dart';

import 'package:flutter_viaje_express_cliente/src/widgets/principal_widgets/signIn_widget/forms.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/principal_widgets/signIn_widget/logo_signin.dart';
import 'package:provider/provider.dart';



class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SigninBloc(),
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
    return BlocBuilder<SigninBloc, SigninState>(builder: (_, state) {
      if (state.opcion == 0) {
        return ChangeNotifierProvider(
          create: (_) => SignInFormProvider(),
          child: Form0());
      } else if (state.opcion == 1) {
        return ChangeNotifierProvider(
          create: (_) => SignInFormProvider(),
          child: Form1());
      } else if (state.opcion == 2) {
        return ChangeNotifierProvider(
          create: (_) => SignInFormProvider(),
          child: Form2());
      } else {
        return ChangeNotifierProvider(
          create: (_) => SignInFormProvider(),
          child: Form0());
      }
    });
  }
}







