import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/bloc/mapa/mapa_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';

import 'package:flutter_viaje_express_cliente/src/pages/viajeNuevo/estructuraPage.dart';
import 'package:flutter_viaje_express_cliente/src/share_prefs/preferencias_usuario.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/global_widgets/sideBar_widgets/sideBar_widget.dart';

import 'package:flutter_viaje_express_cliente/src/widgets/mapa_widgets/btn_seguir_ubicacion.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/mapa_widgets/btn_ubicacion.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/viajeNuevo_widgets/marcador_manual_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();
  static const double fabHeightClosed = 90.0;
  double fabHeight = fabHeightClosed;
  final panelController = new PanelController();
  final prefs = new PreferenciasUsuario();

  @override
  void initState() {
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
    final panelHeightOpen = MediaQuery.of(context).size.height * 0.6;
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.070;
    return Scaffold(
      key: _scafoldKey,
      drawer: SideBar(),
      body: SafeArea(
        child: Stack(
          children: [
             /* SlidingUpPanel(
              controller: panelController,
              maxHeight: panelHeightOpen,
              minHeight: panelHeightClosed,
              parallaxEnabled: true,
              parallaxOffset: .5,
              body: BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
                  builder: (_, state) => crearMapa(state)),
              panelBuilder: (controller) => EstructuraPage(
                  controller: controller, panelController: panelController),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              onPanelSlide: (position) => setState(() {
                final panelMaxScrollExtent =
                    panelHeightOpen - panelHeightClosed;
                fabHeight = position * panelMaxScrollExtent + fabHeightClosed;
              }),
            ), */

            

            MarcadorManual(),
            Positioned(
              top: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buttonDrawer(),
                ],
              ),
            ),
            Positioned(right: 20, bottom: fabHeight, child: BtnUbicacion()),
            Positioned(
                right: 20, bottom: fabHeight + 70, child: BtnSeguirUbicacion())
          ],
        ),
      ),
      /* floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [BtnUbicacion(), BtnSeguirUbicacion(), BtnMiRuta()],
      ), */
    );
  }

  Widget _buttonDrawer() {
    return Container(
      alignment: Alignment.centerLeft,
      child: IconButton(
        onPressed: () => _scafoldKey.currentState!.openDrawer(),
        icon: Icon(
          Icons.menu,
          size: 35,
          color: Colors.black,
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

    return GoogleMap(
      initialCameraPosition: cameraPosition,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      onMapCreated: mapaBloc
          .initMapa, // el primer argumento de onMapCreated se asignara al mapaBloc.initMap
      polylines: mapaBloc.state.polylines.values.toSet(),
      onCameraMove: (cameraPosition) {
        // cameraPosition.target = LatLng central del mapa
        mapaBloc.add(OnMovioMapa(cameraPosition.target));
      },
    );
  }
}
