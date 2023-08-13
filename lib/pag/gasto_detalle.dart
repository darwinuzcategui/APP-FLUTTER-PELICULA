import 'dart:async';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productos/providers/gastos_providers.dart';
import '../models/gastos_model.dart';
import '../utilis/utilis.dart' as util;

// ignore: camel_case_types
class gastoDetalle extends StatelessWidget {
  // esta en una forma final Pelicula pelicula;
  static final String routerName = 'detalle';

  // contructor PeliculaDetalle(this.pelicula);

  @override
  Widget build(BuildContext context) {
    final Gasto gasto = ModalRoute.of(context).settings.arguments;

    /*
    var pmoneydif = gasto.pmoneydif;
    var moneda = (pmoneydif == 1)
        ? "\$."
        : (pmoneydif == 2)
            ? "Eur."
            : "Bs.";
    var precio1bs = (pmoneydif == 0)
        ? " "
        : "  Bs:" + (gasto.pventa1 * gasto.ptasac).toStringAsFixed(2);
    var precio2bs = (pmoneydif == 0)
        ? " "
        : "  Bs:" + (gasto.pventa2 * gasto.ptasac).toStringAsFixed(2);
    var precio3bs = (pmoneydif == 0)
        ? " "
        : "  Bs:" + (gasto.pventa3 * gasto.ptasac).toStringAsFixed(2);
    var precio4bs = (pmoneydif == 0)
        ? " "
        : "  Bs:" + (gasto.pventa4 * gasto.ptasac).toStringAsFixed(2);
    var precio5bs = (pmoneydif == 0)
        ? " "
        : "  Bs:" + (gasto.pventa5 * gasto.ptasac).toStringAsFixed(2);
    var precio1 =
        'Precio1: $moneda${gasto.pventa1.toStringAsFixed(2)} $precio1bs ';
    var precio2 = (gasto.pventa2 == 0)
        ? ""
        : 'Precio2: $moneda${gasto.pventa2.toStringAsFixed(2)} $precio2bs ';
    var precio3 = (gasto.pventa3 == 0)
        ? ""
        : 'Precio3: $moneda${gasto.pventa3.toStringAsFixed(2)} $precio3bs ';
    var precio4 = (gasto.pventa4 == 0)
        ? ""
        : 'Precio4: $moneda${gasto.pventa4.toStringAsFixed(2)} $precio4bs ';
    var precio5 = (gasto.pventa5 == 0)
        ? ""
        : 'Precio5: $moneda${gasto.pventa5.toStringAsFixed(2)} $precio5bs ';

*/
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        _crearAppbar(context, gasto),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              // SizedBox(height: 10.0),
              _campoFormulario(gasto, 'Nombre: ${gasto.nomart}'), //1
              //SizedBox(height: 1.0),
              _campoFormulario(gasto, gasto.valor), //1
              /*
              (gasto.pventa2 == 0)
                  ? SizedBox(height: 0.0)
                  : _campoFormulario(gasto, precio2), //1

              (gasto.pventa3 == 0)
                  ? SizedBox(height: 0.0)
                  : _campoFormulario(gasto, precio3), //1
              (gasto.pventa4 == 0)
                  ? SizedBox(height: 0.0)
                  : _campoFormulario(gasto, precio4), //1
              (gasto.pventa5 == 0)
                  ? SizedBox(height: 0.0)
                  : _campoFormulario(gasto, precio5), //1
                  */
              _campoFormulario(gasto, 'Tasa de Cambio: ${gasto.tasa}'), //1

              //_campoFormulario(gasto, 'Saldo cantidade(s): ${gasto.pexiste}'),
              //_campoFormulario(gasto, 'Medida: ${gasto.pmedida}'), //1
              //_campoFormulario(gasto,'Empaque: ${gasto.pempaque} Med del Empaque:${gasto.pmedempaque}'), //1
              //_campoFormulario(gasto, 'Medida de Empaque: ${gasto.pmedempaque}'), //1
              _posterTitulo(context, gasto),
              // _campoFormulario(gasto, gasto.pdepartamento), //1
              // _campoFormulario(gasto, gasto.preferencia), //1
              // _campoFormulario(gasto, gasto.pintercode), //1
              // _campoFormulario(gasto, gasto.pdepartamento), //1

              // _posterTitulo(context, gasto),
              SizedBox(height: 1.0),
              //   _crearCasting(gasto),
            ],
          ),
        )
      ],
    ));
  }

  Widget _crearAppbar(BuildContext context, Gasto gasto) {
    return SliverAppBar(
        elevation: 2.0,
        backgroundColor: Colors.orange,
        expandedHeight: 200.0,
        floating: false,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Text(
            gasto.nomart,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 18, 18, 15),
                fontSize: 16.0),
            textAlign: TextAlign.center,
          ),
          background: FadeInImage(
            //image: NetworkImage(gasto.getFondoImagen()),
            image: NetworkImage(
                "https://img.freepik.com/fotos-premium/manos-mujer-joven-escaner-escanear-gastos-cliente-gran-centro-comercial_310913-84.jpg?w=826"),
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
              _scan23(context, gasto.codart);
            },
          ),
        ]);
  }

  Widget _posterTitulo(BuildContext context, Gasto gasto) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 9.0, vertical: 0.5),
      child: Row(
        children: <Widget>[
          Hero(
            tag: gasto.codart,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(gasto.getImagen1()),
                height: 105.0,
                width: 105.0,
              ),
            ),
          ),

          // SizedBox(width: 20.0,),

          Flexible(
            child: new InkWell(
              onTap: () {
                _scan23(context, gasto.codart);
              },
              child: Row(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Icon(Icons.barcode_reader),
                      Text(
                        gasto.codart.toString(),
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

  Widget _campoFormulario(Gasto gasto, String valor) {
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
      final gastoProvider = GastosProvider();
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
            await gastoProvider.grbarCodigoDeBarraEnD3xdProductoas(
                codigo, codigoBarra));
      }
      //grabar = await gastoProvider.grbarCodigoDeBarraEnD3xdgastoas(
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
