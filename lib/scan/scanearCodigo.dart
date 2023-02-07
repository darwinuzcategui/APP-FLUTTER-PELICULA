//import 'dart:io';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productos/models/productos_model.dart';
//import '../models/productos_model.dart';
import '../pag/inicio_pagina.dart';
import '../preferencia/preferencia_usuarios.dart';
import '../providers/productos_providers.dart';
//import '../widget_personalizados/menu_lateral_widget.dart';
import '../widget_personalizados/productos_vertical.dart';
import '../widget_personalizados/card_swiper_widget.dart';

class ScanearCodigo extends StatefulWidget {
//class ScanearCodigo extends StatelessWidget {
//class ScanearCodigo extends StatelessWidget {
  const ScanearCodigo({Key key}) : super(key: key);
  @override
  _AppState createState() => _AppState();

  static final String routerName = 'scan';
}

class _AppState extends State<ScanearCodigo> {
  ScanResult scanResult;
  String resulta2;

  final llame = "CODIGODEBRRA";

  Producto producto;

  //get result2 => null;
  //String codigo;

  final _flashOnController = TextEditingController(text: 'Flash on');
  final _flashOffController = TextEditingController(text: 'Flash off');
  final _cancelController = TextEditingController(text: 'Cancel');
  final productosProvider = new ProductosProvider();
  final productos = new Productos();
  final prefs = new PreferenciaUsuarios();
  var _aspectTolerance = 0.00;
  // ignore: unused_field
  var _numberOfCameras = 0;
  var _selectedCamera = -1;
  var _useAutoFocus = true;
  var _autoEnableFlash = false;

  static final _possibleFormats = BarcodeFormat.values.toList()
    ..removeWhere((e) => e == BarcodeFormat.unknown);

  List<BarcodeFormat> selectedFormats = [..._possibleFormats];

  @override
  void initState() {
    super.initState();
    prefs.ultimaPagVisitada = ScanearCodigo.routerName;

    Future.delayed(Duration.zero, () async {
      _numberOfCameras = 0; //await BarcodeScanner.numberOfCameras;
      setState(() {
        _scan();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final scanResult = this.scanResult;
    //final codigo = this.codigo;
    if (scanResult != null) {
      //final productosProvider = new ProductosProvider();
      productosProvider.GetProducto(scanResult.rawContent);
      //print("***1111111111111*******************");

      //print((producto.pcode != null) ? producto.pcode : "codigo texto");
    }
    return MaterialApp(
        //backgroundColor: Colors.orangeAccent,
        theme: ThemeData(
            colorSchemeSeed: Color.fromARGB(255, 194, 131, 23),
            useMaterial3: true),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.orangeAccent,
              title: const Text('Productos Scaneados Barcode '),
              actions: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_rounded),
                  //icon: const Icon(Icons.barcode_reader),
                  tooltip: 'Regresar inicio',
                  onPressed: () {
                    (InicioPagina.routerName != null)
                        ? Navigator.pushReplacementNamed(
                            context, InicioPagina.routerName)
                        : Navigator.pop(context);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.barcode_reader),
                  tooltip: 'Scan',
                  onPressed: _scan,
                )
              ],
            ),
            body: Card(
                child: Column(children: <Widget>[
              //Tex( const Text('Result Type'),
              // if (scanResult != null)
              //   Text(
              //     (scanResult != null) ? scanResult.type.toString() : "tipo"),
              Text((scanResult != null)
                  ? scanResult.rawContent.toString()
                  : "Resultado"),
              (scanResult != null)
                  ? _swiperTarjeta(scanResult.rawContent.toString())
                  : Text(""),
              //_swiperTarjeta(scanResult.rawContent.toString()),
              if (scanResult != null) _productoResultado(context),
              if (scanResult != null) _botonesFlotante2(context),
            ]))));
  }

  Future<void> _scan() async {
    try {
      final result = await BarcodeScanner.scan(
        options: ScanOptions(
          strings: {
            'cancel': _cancelController.text,
            'flash_on': _flashOnController.text,
            'flash_off': _flashOffController.text,
          },
          restrictFormat: selectedFormats,
          useCamera: _selectedCamera,
          autoEnableFlash: _autoEnableFlash,
          android: AndroidOptions(
            aspectTolerance: _aspectTolerance,
            useAutoFocus: _useAutoFocus,
          ),
        ),
      );
      setState(() => scanResult = result);
    } on PlatformException catch (e) {
      setState(() {
        scanResult = ScanResult(
          type: ResultType.Error,
          format: BarcodeFormat.unknown,
          rawContent: e.code == BarcodeScanner.cameraAccessDenied
              ? '¡El usuario no le dio permiso a la cámara!'
              : 'Error desconocido: $e',
        );
      });
    }
  }

// aqui
  Widget _productoResultado(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10.0),
            child: Text("Lista Producto Escaneado.",
                //Theme.of(context).textTheme.subtitle1
                //  style: Theme.of(context).textTheme.subhead),
                style: Theme.of(context).textTheme.titleMedium),
          ),
          SizedBox(height: 2.00),
          StreamBuilder(
            // esto es observarble que se ejecuta cada vez que cambie el stream
            stream: productosProvider.gmdAppListaProductostream,
            //builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              //snapshot.data?.forEach((prod)=> print(prod.pdescribe));

              //snapshot.data?.forEach((prod) => prod = prod.pdescribe);

              if (snapshot.hasData) {
                return ProductosVertical(
                  productos: snapshot.data,
                  //codigo: productos.items,

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

  Widget _swiperTarjeta(String codigoBarra) {
    //productosProvider.GetProducto(scanResult.rawContent);
    final productosProvider = new ProductosProvider();
    //var scanResult;
    return FutureBuilder(
      future: productosProvider.GetProducto(codigoBarra),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        //if (snapshot.data.length == 1) {
        if (snapshot.hasData) {
          print(snapshot.data.length);
          return (snapshot.data.length == 1)
              ? CardSwiper(
                  productos: snapshot.data,
                  quienMellamo: llame,
                )
              : Container(
                  height: 300.0,
                  child: Center(child: CircularProgressIndicator()));
        } else {
          return Container(
              height: 300.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  //Row _botonesFlotantes() {
  Widget _botonesFlotante2(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
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
                  _scan();
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
