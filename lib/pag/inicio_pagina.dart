import 'package:flutter/material.dart';
import '../buscar/buscar_delegate.dart';
import '../scan/scanearCodigo.dart';
import '../providers/productos_providers.dart';
import '../widget_personalizados/card_swiper_widget.dart';
import '../widget_personalizados/productos_horizontal.dart';

class InicioPagina extends StatelessWidget {
  // const InicoPagina({Key key}) : super(key: key);
  final productosProvider = new ProductosProvider();

  @override
  Widget build(BuildContext context) {
    // aqui cuando se ejecuta
    productosProvider.getProductos();
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text('App-GMD Productos'),
          backgroundColor: Colors.orangeAccent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                    context: context, delegate: BuscarDatos(), query: '');
              },
            ),
            IconButton(
              icon: const Icon(Icons.barcode_reader),
              tooltip: 'Scan',
              // //_scan
              onPressed: () {
                //Navigator.pushNamed(context, 'scan', arguments: producto);
                Navigator.pushNamed(context, 'scan', arguments: ScanearCodigo());
                //ScanearCodigo();
              },
            ),
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _swiperTarjeta(),
              //Text("hola"),
              _footerOpiePag(context),
            ],
          ),
        ));
  }

  // van los nuevos metodos de la clases

  Widget _swiperTarjeta() {
    return FutureBuilder(
      future: productosProvider.getProductosDeD3xd(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          //print(snapshot.data);
          return CardSwiper(productos: snapshot.data);
        } else {
          return Container(
              height: 300.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget _footerOpiePag(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text("Productos Ordenado x Existencia..",
                //Theme.of(context).textTheme.subtitle1
                //  style: Theme.of(context).textTheme.subhead),
                style: Theme.of(context).textTheme.titleMedium),
          ),
          SizedBox(height: 5.0),
          StreamBuilder(
            // esto es observarble que se ejecuta cada vez que cambie el stream
            stream: productosProvider.popularesListaProductostream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              // snapshot.data?.forEach((peli)=> print(peli.title));
              if (snapshot.hasData) {
                // print(snapshot.data);
                return ProductosHorizontal(
                  productos: snapshot.data,
                  //  siguientePagina: productosProvider.getProductos(),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
