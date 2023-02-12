import 'dart:async';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productos/providers/productos_providers.dart';
import '../models/productos_model.dart';
import '../utilis/utilis.dart' as util;

class ProductoDetalle extends StatelessWidget {
  // esta en una forma final Pelicula pelicula;
  static final String routerName = 'detalle';

  // contructor PeliculaDetalle(this.pelicula);

  @override
  Widget build(BuildContext context) {
    final Producto producto = ModalRoute.of(context).settings.arguments;

    var pmoneydif = producto.pmoneydif;
    var moneda = (pmoneydif == 1)
        ? "\$."
        : (pmoneydif == 2)
            ? "Eur."
            : "Bs.";
    var precio1bs = (pmoneydif == 0)
        ? " "
        : "  Bs:" + (producto.pventa1 * producto.ptasac).toStringAsFixed(2);
    var precio2bs = (pmoneydif == 0)
        ? " "
        : "  Bs:" + (producto.pventa2 * producto.ptasac).toStringAsFixed(2);
    var precio3bs = (pmoneydif == 0)
        ? " "
        : "  Bs:" + (producto.pventa3 * producto.ptasac).toStringAsFixed(2);
    var precio4bs = (pmoneydif == 0)
        ? " "
        : "  Bs:" + (producto.pventa4 * producto.ptasac).toStringAsFixed(2);
    var precio5bs = (pmoneydif == 0)
        ? " "
        : "  Bs:" + (producto.pventa5 * producto.ptasac).toStringAsFixed(2);
    var precio1 =
        'Precio1: $moneda${producto.pventa1.toStringAsFixed(2)} $precio1bs ';
    var precio2 = (producto.pventa2 == 0)
        ? ""
        : 'Precio2: $moneda${producto.pventa2.toStringAsFixed(2)} $precio2bs ';
    var precio3 = (producto.pventa3 == 0)
        ? ""
        : 'Precio3: $moneda${producto.pventa3.toStringAsFixed(2)} $precio3bs ';
    var precio4 = (producto.pventa4 == 0)
        ? ""
        : 'Precio4: $moneda${producto.pventa4.toStringAsFixed(2)} $precio4bs ';
    var precio5 = (producto.pventa5 == 0)
        ? ""
        : 'Precio5: $moneda${producto.pventa5.toStringAsFixed(2)} $precio5bs ';

    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        _crearAppbar(context, producto),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              // SizedBox(height: 10.0),
              _campoFormulario(producto, 'Nombre: ${producto.pdescribe}'), //1
              //SizedBox(height: 1.0),
              _campoFormulario(producto, precio1), //1
              (producto.pventa2 == 0)
                  ? SizedBox(height: 0.0)
                  : _campoFormulario(producto, precio2), //1

              (producto.pventa3 == 0)
                  ? SizedBox(height: 0.0)
                  : _campoFormulario(producto, precio3), //1
              (producto.pventa4 == 0)
                  ? SizedBox(height: 0.0)
                  : _campoFormulario(producto, precio4), //1
              (producto.pventa5 == 0)
                  ? SizedBox(height: 0.0)
                  : _campoFormulario(producto, precio5), //1
              _campoFormulario(
                  producto, 'Tasa de Cambio: ${producto.ptasac}'), //1
              _campoFormulario(
                  producto, 'Saldo cantidade(s): ${producto.pexiste}'),
              _campoFormulario(producto, 'Medida: ${producto.pmedida}'), //1
              _campoFormulario(producto,
                  'Empaque: ${producto.pempaque} Med del Empaque:${producto.pmedempaque}'), //1
              //_campoFormulario(producto, 'Medida de Empaque: ${producto.pmedempaque}'), //1
              _posterTitulo(context, producto),
              _campoFormulario(producto, producto.pdepartamento), //1
              _campoFormulario(producto, producto.preferencia), //1
              _campoFormulario(producto, producto.pintercode), //1
              _campoFormulario(producto, producto.pdepartamento), //1

              // _posterTitulo(context, producto),
              SizedBox(height: 1.0),
              //   _crearCasting(producto),
            ],
          ),
        )
      ],
    ));
  }

  Widget _crearAppbar(BuildContext context, Producto producto) {
    return SliverAppBar(
        elevation: 2.0,
        backgroundColor: Colors.orange,
        expandedHeight: 200.0,
        floating: false,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Text(
            producto.pdescribe,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 18, 18, 15),
                fontSize: 16.0),
            textAlign: TextAlign.center,
          ),
          background: FadeInImage(
            //image: NetworkImage(producto.getFondoImagen()),
            image: NetworkImage(
                "https://img.freepik.com/fotos-premium/manos-mujer-joven-escaner-escanear-productos-cliente-gran-centro-comercial_310913-84.jpg?w=826"),
            placeholder: AssetImage('assets/img/loading.gif'),
            fadeInDuration: Duration(milliseconds: 150),
            fit: BoxFit.cover,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_circle),
            tooltip: 'Add new entry',
            onPressed: () {
              //print("grbar algo ");
              //util.showAlertgmd(context, "Prueba de Grabar");
              _scan23(context, producto.pcode);
            },
          ),
        ]);
  }

  Widget _posterTitulo(BuildContext context, Producto producto) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 9.0, vertical: 0.5),
      child: Row(
        children: <Widget>[
          Hero(
            tag: producto.pcode,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(producto.getImagen()),
                height: 105.0,
                width: 105.0,
              ),
            ),
          ),

          // SizedBox(width: 20.0,),

          Flexible(
            child: new InkWell(
              onTap: () {
                _scan23(context, producto.pcode);
              },
              child: Row(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Icon(Icons.barcode_reader),
                      Text(
                        producto.pcode.toString(),
                        style: Theme.of(context).textTheme.titleMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _campoFormulario(Producto producto, String valor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Text(
        valor,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Future<void> _scan23(BuildContext context, String codigo) async {
    try {
      final _flashOnController = TextEditingController(text: 'Activar Flash');
      final _flashOffController =
          TextEditingController(text: 'Desactivar Flash');
      final _cancelController = TextEditingController(text: 'Salir');
      final productoProvider = ProductosProvider();
      var _aspectTolerance = 0.00;
      // ignore: unused_field
      //var _numberOfCameras = 0;
      var _selectedCamera = -1;
      var _useAutoFocus = true;
      var _autoEnableFlash = false;

      // ignore: unused_local_variable
      final result = await BarcodeScanner.scan(
        options: ScanOptions(
          strings: {
            'cancel': _cancelController.text,
            'flash_on': _flashOnController.text,
            'flash_off': _flashOffController.text,
          },
          //restrictFormat: selectedFormats,
          useCamera: _selectedCamera,
          autoEnableFlash: _autoEnableFlash,
          android: AndroidOptions(
            aspectTolerance: _aspectTolerance,
            useAutoFocus: _useAutoFocus,
          ),
        ),
      );

      final String codigoBarra =
          (result.rawContent != "") ? result.rawContent : "";
      //String grabar = "";
      if (codigoBarra.length != null && codigoBarra.length > 2) {
        util.showAlertgmd(
            context,
            await productoProvider.grbarCodigoDeBarraEnD3xdProductoas(
                codigo, codigoBarra));
      }
      //grabar = await productoProvider.grbarCodigoDeBarraEnD3xdProductoas(
      //codigoBarra, codigo);
      // ignore: unnecessary_statements
      //if grabar != null {
      //util.showAlertgmd(context, grabar);
      //}
    } on PlatformException catch (e) {
      // ignore: unused_local_variable
      var scanResult = ScanResult(
        type: ResultType.Error,
        format: BarcodeFormat.unknown,
        rawContent: e.code == BarcodeScanner.cameraAccessDenied
            ? '¡El usuario no le dio permiso a la cámara!'
            : 'Error desconocido: $e',
      );
      //aqui voy ver
      // util.showAlertgmd(context, ' $scanResult.rawContent aqui va el $codigo ');
    }
  }
}
