import 'package:flutter/material.dart';
import '../models/productos_model.dart';
import '../providers/productos_providers.dart';

class BuscarDatos extends SearchDelegate {
  String seleccion = "";

  final productosProvider = new ProductosProvider();

  final productos = [
    'Jordan',
    'Superman',
    'Batman',
    'Gordar',
    'Jordan Volador',
    'Superman 2',
    'Superman 3',
    'Superman 4',
    'Aquam  de Papel'
  ];

  final productosRecientes = ['Superman', 'Guason', 'Aquaman'];

  @override
  List<Widget> buildActions(BuildContext context) {
    // la acciones de nuestros app
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          print('click !!!');
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // icono a las izquirda appbar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        print('Leading Icons Press ');
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamos a mostrar
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Color.fromARGB(255, 223, 171, 0),
        child: Text(seleccion),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Es la sugerencias que aparece cuando se ecribe.

    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: productosProvider.buscarD3xdProductos(query),
      builder: (BuildContext context, AsyncSnapshot<List<Producto>> snapshot) {
        print(query);
        if (snapshot.hasData) {
          final productos = snapshot.data;

          return ListView(
              children: productos.map((producto) {
            return ListTile(
              leading: FadeInImage(
                // assets/img/no-image.jpg
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(producto.getImagen()),
                width: 50.0,
                fit: BoxFit.contain,
              ),
              title: Text(producto.pdescribe),
              subtitle: Text(producto.pventa1.toStringAsPrecision(3)),
              onTap: () {
                print('pulsaste aqui');
                print(query);
                //primero cerramos la busqueda
                close(context, null);
                producto.pcode = '';
                //producto.pcode = 0;
                Navigator.pushNamed(context, 'detalle', arguments: producto);
              },
            );
          }).toList());
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
