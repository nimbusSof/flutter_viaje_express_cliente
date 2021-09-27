import 'package:flutter/material.dart';
import 'package:flutter_viaje_express_cliente/src/pages/configuraciones/acercaApp_page.dart';
import 'package:flutter_viaje_express_cliente/src/pages/configuraciones/cambiarFormatos_page.dart';
import 'package:flutter_viaje_express_cliente/src/pages/configuraciones/cambiarIdioma_page.dart';
import 'package:flutter_viaje_express_cliente/src/pages/configuraciones/cambiarNumero_page.dart';
import 'package:flutter_viaje_express_cliente/src/pages/configuraciones/configuraciones_inicio_page.dart';
import 'package:flutter_viaje_express_cliente/src/pages/historialViajes/historialViajes_inicio_page.dart';
import 'package:flutter_viaje_express_cliente/src/pages/historialViajes/viajesCancelados_page.dart';
import 'package:flutter_viaje_express_cliente/src/pages/historialViajes/viajesConcluidos_page.dart';
import 'package:flutter_viaje_express_cliente/src/pages/inicio/inicio_page.dart';

import 'package:flutter_viaje_express_cliente/src/pages/metodoPago/metodoPago_inicio_page.dart';
import 'package:flutter_viaje_express_cliente/src/pages/metodoPago/pagoEfectivo_page.dart';
import 'package:flutter_viaje_express_cliente/src/pages/metodoPago/pagoTarjeta_page.dart';
import 'package:flutter_viaje_express_cliente/src/pages/perfil/clasificacionPerfil_page.dart';
import 'package:flutter_viaje_express_cliente/src/pages/perfil/configuracionPerfil_page.dart';
import 'package:flutter_viaje_express_cliente/src/pages/perfil/perfil_inicio_page.dart';
import 'package:flutter_viaje_express_cliente/src/pages/principal/check_auth_screen.dart';
import 'package:flutter_viaje_express_cliente/src/pages/principal/signIn_page.dart';
import 'package:flutter_viaje_express_cliente/src/pages/principal/signUp_page.dart';
import 'package:flutter_viaje_express_cliente/src/pages/principal/splash_screen_page.dart';
import 'package:flutter_viaje_express_cliente/src/pages/rutasGuardadas/rutasGuardadas_inicio_page.dart';
import 'package:flutter_viaje_express_cliente/src/pages/rutasGuardadas/visualizarRutas_page.dart';
import 'package:flutter_viaje_express_cliente/src/pages/viajeNuevo/acceso_gps_page.dart';
import 'package:flutter_viaje_express_cliente/src/pages/viajeNuevo/loading_page.dart';
import 'package:flutter_viaje_express_cliente/src/pages/viajeNuevo/mapa_page.dart';


final Map<String, Widget Function(BuildContext)> appRoutes = {
  '/'                            :  (_) => SplashScreen(),
  'login'                        :  (_) => LoginPage(),
  'signin'                       :  (_) => SignInPage(), 
  'checking'                     :  (_) => CheckAuthScreen(), 
  'inicio'                       :  (_) => InicioPage(),
  'metodoPago_inicio'            :  (_) => MetodoPagoInicioPage(),
  'historialViajes_inicio'       :  (_) => HistorialViajesInicioPage(),
  'configuraciones_inicio'       :  (_) => ConfiguracionesInicioPage(),
  'rutasGuardadas_inicio'        :  (_) => RutasGuardadasInicioPage(),
  'perfil_inicio'                :  (_) => PerfilInicioPage(),
  
  'configuracionPerfil'          :  (_) => ConfiguracionPerfilPage(),
  'clasificaciónPerfil'          :  (_) => ClasificacionPerfilPage(),
  'cambiarNumero'                :  (_) => CambiarNumeroPage(),
  'cambiarIdioma'                :  (_) => CambiarIdiomaPage(),
  'cambiarFormatos'              :  (_) => CambiarFormatosPage(),
  'acercaApp'                    :  (_) => AcercaAppPage(),
  'viajesConcluidos'             :  (_) => ViajesConcluidosPage(),
  'viajesCancelados'             :  (_) => ViajesCanceladosPage(),
  'visualizarRutas'              :  (_) => VisualizarRutasPage(),
  'pagoTarjeta'                  :  (_) => PagoTarjetaPage(),
  'pagoEfectivo'                 :  (_) => PagoEfectivoPage(),


  //mapas
  'acceso_gps'                   :  (_) => AccesoGpsPage(),
  'loadingMapa'                  :  (_) => LoadingPage(),
  'mapa_page'                    :  (_) => MapaPage(),


};
