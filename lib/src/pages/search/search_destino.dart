import 'package:flutter/material.dart';
import 'package:flutter_viaje_express_cliente/src/models/search_response.dart';
import 'package:flutter_viaje_express_cliente/src/models/search_result.dart';
import 'package:flutter_viaje_express_cliente/src/services/viajeNuevo/traffic_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class SearchDestino extends SearchDelegate<SearchResult> {
  @override
  final String searchFieldLabel;
  final TrafficService _trafficService;
  final LatLng proximidad;
  final List<SearchResult> historial;

  SearchDestino(this.proximidad, this.historial)
      : this.searchFieldLabel = 'Buscar',
        this._trafficService = new TrafficService();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => this.query = '', icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // cuando la persona sale del search

    return IconButton(
        onPressed: () => this.close(context, SearchResult(cancelo: true)),
        icon: Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    return _construirResultadosSugerencias();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (this.query.length == 0) {
      return ListView(
        children: [
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Colocar ubicación manualmente'),
            onTap: () {
              this.close(context, SearchResult(cancelo: false, manual: true));
            },
          ),
          ...this.historial.map(
            (result) => ListTile(
              leading: Icon(Icons.history),
              title: Text(result.nombreDestino??''),
              subtitle: Text(result.descripcion??''),
              onTap: (){
                this.close(
                      context,
                      result);
              },
            )).toList()
        ],
      );
    } 
    return this._construirResultadosSugerencias();
  }

  Widget _construirResultadosSugerencias() {
    if (this.query == 0) {
      return Container();
    }
    this
        ._trafficService
        .getSugerenciasPorQuery(this.query.trim(), this.proximidad);
    //(this.query.trim(), proximidad)
    return StreamBuilder(
      stream: this._trafficService.sugerenciasStream,
      builder: (BuildContext context, AsyncSnapshot<SearchResponse> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final lugares = snapshot.data!.features;

        if (lugares!.length == 0) {
          return ListTile(title: Text('No hay resultados con $query'));
        }

        return ListView.separated(
            itemBuilder: (_, i) {
              final lugar = lugares[i];
              return ListTile(
                leading: Icon(Icons.place),
                title: Text(lugar.textEs ?? ''),
                subtitle: Text(lugar.placeName ?? ''),
                onTap: () {
                  this.close(
                      context,
                      SearchResult(
                          cancelo: false,
                          manual: false,
                          position: LatLng(lugar.center![1], lugar.center![0]),
                          nombreDestino: lugar.placeNameEs,
                          descripcion: lugar.placeName));
                },
              );
            },
            separatorBuilder: (_, i) => Divider(),
            itemCount: lugares.length);
      },
    );
  }
}
