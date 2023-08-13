//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:productos/widget_personalizados/menu_latera.dart';
import '../buscar/buscar_delegate.dart';
import '../preferencia/preferencia_usuarios.dart';
//import '../providers/provider.dart';
import '../scan/scanearCodigo.dart';
import '../providers/productos_providers.dart';
import '../providers/gastos_providers.dart';
//import '../widget_personalizados/card_swiper_widget.dart';
import '../widget_personalizados/card_swiper_widget_gastos.dart';
import '../widget_personalizados/menu_lateral_widget.dart';
import '../widget_personalizados/gastos_horizontal.dart';

class InicioPagina extends StatelessWidget {
  // const InicoPagina({Key key}) : super(key: key);
  final productosProvider = new ProductosProvider();
  final gastosProvider = new GastosProvider();
  final prefs = new PreferenciaUsuarios();
  static final String routerName = 'inicio';
  final llame = "INICIOPAGINA";

  @override
  Widget build(BuildContext context) {
    // aqui cuando se ejecuta
    prefs.ultimaPagVisitada = InicioPagina.routerName;
    //final bloc = Provider.of(context);
    //productosProvider.getProductos();
    gastosProvider.getGastosDeDosTorres();
    //final  FloatingActionButton floatingActionButton:
    // _botonesFlotantes();
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('GMD-App'),
        backgroundColor: Colors.orangeAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: BuscarDatos(), query: '');
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
      drawer: MenuWidgetDrawer(),
      //drawer: MenuLateral(),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            //Text('UserQweb : ${bloc.httpQwb}'),
            // _botonesFlotante2(context),
            _swiperTarjeta(),
            // _botonesFlotante2(context),
            _footerOpiePag(context),
            // _botonesFlotante(context),
            _botonesFlotante2(context),
            //_botonesFlotante(context),
          ],
        ),
      ),
    );
  }

  // van los nuevos metodos de la clases

  Widget _swiperTarjeta() {
    return FutureBuilder(
      future: gastosProvider.getGastosDeDosTorres(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          //print(snapshot.data);
          return CardSwiperGastos(gastos: snapshot.data, quienMellamo: llame);
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
            padding: EdgeInsets.only(left: 10.0),
            child: Text("Gastos Ordenado x Cod..",
                //Theme.of(context).textTheme.subtitle1
                //  style: Theme.of(context).textTheme.subhead),
                style: Theme.of(context).textTheme.titleMedium),
          ),
          SizedBox(height: 0.5),
          StreamBuilder(
            // esto es observarble que se ejecuta cada vez que cambie el stream
            stream: gastosProvider.gmdAppListaGastostream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              // snapshot.data?.forEach((peli)=> print(peli.title));
              if (snapshot.hasData) {
                // print(snapshot.data);
                return GastosHorizontal(
                  gastos: snapshot.data,
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

  //Row _botonesFlotantes() {
  Widget _botonesFlotante2(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          /*
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Scaner'),
              const SizedBox(width: 16),
              // An example of the small floating action button.
              //
              // https://m3.material.io/components/floating-action-button/specs#669a1be8-7271-48cb-a74d-dd502d73bda4
              FloatingActionButton.small(
                onPressed: () {
                  // Add your onPressed code here!
                },
                child: const Icon(Icons.barcode_reader),
              ),
            ],
          ),
          */
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //const Text('Extended'),
              //const SizedBox(height: 16),
              // An example of the extended floating action button.
              //
              // https://m3.material.io/components/extended-fab/specs#686cb8af-87c9-48e8-a3e1-db9da6f6c69b
              FloatingActionButton.extended(
                onPressed: () {
                  // Add your onPressed code here!
                  Navigator.pushNamed(context, 'scan',
                      arguments: ScanearCodigo());
                },
                label: const Text('Scaner'),
                icon: const Icon(Icons.barcode_reader),
              ),
              //SizedBox( height: 28,),
            ],
          ),
        ],
      ),
    );
  }
}
