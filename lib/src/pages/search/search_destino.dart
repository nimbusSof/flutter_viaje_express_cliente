import 'package:flutter/material.dart';
import 'package:flutter_viaje_express_cliente/src/models/search_result.dart';


class SearchDestino extends SearchDelegate<SearchResult> {
  @override
  final String searchFieldLabel;
  SearchDestino() : this.searchFieldLabel = 'Buscar';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => this.query = '', icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) { // cuando la persona sale del search
  
    return IconButton(
        onPressed: () => this.close(context, SearchResult(cancelo: true)),
        icon: Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Icon(Icons.location_on),
          title: Text('Colocar ubicación manualmente'),
          onTap: () {
            this.close(context, SearchResult(cancelo: false, manual: true));
          },
        )
      ],
    );
  }
}
