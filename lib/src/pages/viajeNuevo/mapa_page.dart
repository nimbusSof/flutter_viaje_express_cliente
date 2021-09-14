import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/bloc/busqueda/busqueda_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/bloc/mapa/mapa_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/pages/viajeNuevo/estructuraPage.dart';
import 'package:flutter_viaje_express_cliente/src/providers/slidingUpPanel_provider.dart';

import 'package:flutter_viaje_express_cliente/src/share_prefs/preferencias_usuario.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/global_widgets/sideBar_widgets/sideBar_widget.dart';

import 'package:flutter_viaje_express_cliente/src/widgets/mapa_widgets/btn_seguir_ubicacion.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/mapa_widgets/btn_ubicacion.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/viajeNuevo_widgets/customButtomDrawer.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/viajeNuevo_widgets/marcador_manual_widget.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/viajeNuevo_widgets/slidingPanel.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();
  static const double fabHeightClosed = 90.0;
  //double fabHeight = fabHeightClosed;

  final prefs = new PreferenciasUsuario();

  @override
  void initState() {
    context.read<SlidingUpPanelProvider>().reiniciar();
    BlocProvider.of<MiUbicacionBloc>(context).iniciarSeguimiento();
    super.initState();
  }

  @override
  void dispose() {
    //BlocProvider.of<MiUbicacionBloc>(context).cancelarSeguimiento();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    prefs.ultimaPagina = 'loadingMapa';
    final panel = Provider.of<SlidingUpPanelProvider>(context);

    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (BuildContext context, state) {
        if (state.seleccionManual) {
          panel.reiniciar();
          return _estructuraPage();
        } else {
          return _estructuraPage();
        }
      },
    );
  }

  Widget _estructuraPage() {
    final panel = Provider.of<SlidingUpPanelProvider>(context);

    return Scaffold(
      key: _scafoldKey,
      drawer: SideBar(),
      body: SafeArea(
        child: Stack(
          children: [
            BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
                builder: (_, state) => crearMapa(state)),
            MarcadorManual(),
            FadeInUp(
                duration: Duration(milliseconds: 250),
                child: CustomSlidingPanel(fabHeightClosed: fabHeightClosed)),
            Positioned(
              top: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomButtonDrawer(scafoldKey: _scafoldKey),
                ],
              ),
            ),
            Positioned(
                right: 20, bottom: panel.fabHeight, child: BtnUbicacion()),
            Positioned(
                right: 20,
                bottom: panel.fabHeight + 70,
                child: BtnSeguirUbicacion())
          ],
        ),
      ),
    );
  }

  Widget crearMapa(MiUbicacionState state) {
    final ubicacionDefecto = LatLng(-0.16050138340851247, -78.47380863777701);
    if (!state.existeUbicacion) return Center(child: Text('Ubicando...'));
    final mapaBloc = BlocProvider.of<MapaBloc>(context);

    mapaBloc.add(OnNuevaUbicacion(state.ubicacion ?? ubicacionDefecto));

    final cameraPosition = new CameraPosition(
        target: state.ubicacion ??
            ubicacionDefecto, // se mostrara una ubicación por defecto si no se encuentra ninguna
        zoom: 15);

    return BlocBuilder<MapaBloc, MapaState>(
      builder: (BuildContext context, _) {
        return GoogleMap(
          initialCameraPosition: cameraPosition,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          onMapCreated: mapaBloc
              .initMapa, // el primer argumento de onMapCreated se asignara al mapaBloc.initMap
          polylines: mapaBloc.state.polylines.values.toSet(),
          markers: mapaBloc.state.markers.values.toSet(),
          onCameraMove: (cameraPosition) {
            // cameraPosition.target = LatLng central del mapa
            mapaBloc.add(OnMovioMapa(cameraPosition.target));
          },
        );
      },
    );
  }
}
