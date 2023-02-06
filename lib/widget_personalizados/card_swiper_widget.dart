//import 'dart:async';port

//import 'package:barcode_scan2/gen/protos/protos.pbjson.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../models/productos_model.dart';
//import '../productos../models/productos_model.dart';

class CardSwiper extends StatelessWidget {
  //const CardSwiper({Key key}) : super(key: key);
  final List<Producto> productos;
  final textController = TextEditingController();
  final String quienMellamo;

  CardSwiper({@required this.productos, @required this.quienMellamo});

  get style => null;

  @override
  Widget build(BuildContext context) {
    // MediaQuery te da referencia deldispositivo

    //var data = InheritedElement(of(context).data;
    //textController.text = data.value.text;
    //of(context.dependOnInheritedElement(ancestor));

    //final _FocusMarker? marker = context.dependOnInheritedWidgetOfExactType<_FocusMarker>();

    print("**********inicio*****************");

    print(quienMellamo);
    print("*************fin**************");
    final _screenSize = MediaQuery.of(context).size;
    final _estilo = TextStyle(
      fontSize: 16,
      color: Color.fromARGB(255, 255, 249, 249),
      fontWeight: FontWeight.w900,
    );
    print("********************************");
    print(_screenSize.height);
    print(_screenSize.width);
    print(_screenSize);
    print("******************************");

    return Container(
      padding: EdgeInsets.only(top: 2.0),

      // width: _screenSize.width * 0.7,
      //height: _screenSize.height * 0.3,

      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.45,
        // itemWidth: 400,
        //itemHeight: 225,
        itemBuilder: (BuildContext context, int index) {
          var titulo = (quienMellamo == "INICIOPAGINA")
              ? "     Lista de Productos     "
              : " Producto Scaneado   ";
          var pmoneydif = productos[index].pmoneydif;
          var moneda = (pmoneydif == 1)
              ? "\$."
              : (pmoneydif == 2)
                  ? "Eur."
                  : "Bs.";

          //var preciocon = productos[index].pventa1.toStringAsFixed(2);
          //var preciomo = '$moneda$preciocon';
          var preciomo1 =
              '$moneda${productos[index].pventa1.toStringAsFixed(2)}';
          //var preciomo2 =$moneda${productos[index].pventa2.toStringAsFixed(2)}';
          var tasa =
              'Tasa Cambio Bs. ${productos[index].ptasac.toStringAsFixed(2)}';
          var precioBs1 = (productos[index].pventa1 * productos[index].ptasac)
              .toStringAsFixed(2);
          var precioBsText = 'Precio Bs.$precioBs1';
          var saldoText =
              'Saldo Cant: ${productos[index].pexiste.toStringAsFixed(2)}';
          //print(productos[index].pdescribe);

          var text1 = Text(
            productos[index].pdescribe,
            style: _estilo,
            textAlign: TextAlign.center,
          );
          var precio1 = Text(
            preciomo1,
            style: _estilo,
            textAlign: TextAlign.right,
          );
          /*
          var precio2 = Text(
            preciomo2,
            style: _estilo,
            textAlign: TextAlign.right,
          );
          */
          var tasavalor = Text(
            tasa,
            style: _estilo,
            textAlign: TextAlign.right,
          );
          var precioBsvalor = Text(
            precioBsText,
            style: _estilo,
            textAlign: TextAlign.right,
          );
          var saldovalor = Text(
            saldoText,
            style: _estilo,
            textAlign: TextAlign.right,
          );
          //return Hero(
          // tag: productos[index].pcode,
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: GestureDetector(
              // onTap: () => Navigator.pushNamed(context, 'detalle',arguments: productos[index]),
              //onTap: () =>  _dialogBuilder(context, productos[index]),
              onTap: () => (quienMellamo == "CODIGODEBRRA")
                  ? _dialogBuilder(context, productos[index])
                  : Navigator.pushNamed(context, 'detalle',
                      arguments: productos[index]),

              child: Stack(children: <Widget>[
                SizedBox(height: 4),
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                  color: Color.fromARGB(255, 243, 139, 36),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(titulo, style: _estilo),
                        SizedBox(height: 8.0),
                        Text(
                          "Codigo:" + productos[index].pcode,
                          style: _estilo,
                          textAlign: TextAlign.right,
                        ),
                        SizedBox(height: 8.5),
                        text1,
                        SizedBox(height: 8.5),
                        //Text(productos[index].preferencia, style: _estilo),
                        Divider(
                          color: Color.fromARGB(179, 247, 245, 242),
                          //height: 20,
                          thickness: 5,
                        ),
                        SizedBox(height: 8.5),
                        precio1,
                        SizedBox(height: 8.5),
                        tasavalor,
                        precioBsvalor,
                        SizedBox(height: 8.5),
                        saldovalor,
                        FadeInImage(
                          image: AssetImage('assets/img/barra.png'),
                          // image: NetworkImage(productos[index].getImagen()),
                          placeholder: AssetImage('assets/img/barra.png'),
                          fit: BoxFit.cover,
                        ),
                        //Image.asset('assets/img/barra.png'),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          );
          // );
        },

        itemCount: productos.length,
        // pagination: new SwiperPagination(),
        // control: new SwiperControl(),
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context, Producto producto) {
    // Producto producto1;
    // var codigo2 = codigo;

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
    final _estilo = TextStyle(
      fontSize: 12,
      color: Color.fromARGB(255, 20, 20, 20),
      fontWeight: FontWeight.w600,
    );
    return showDialog<void>(
      context: context,
      //codigo2: codigo2,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Detalle Producto'),
          //content: const Text('codigo\n'
          //    'appears in front of app content to\n'
          //    'provide critical information, or prompt\n'
          //    'for a decision to be made.'),
          //TextAlign textAlign,
          actions: <Widget>[
            Text(
              producto.pcode,
              style: _estilo,
              textAlign: TextAlign.justify,
            ),
            //child: Padding( padding: const EdgeInsets.all(2.0),
            //crossAxisAlignment: CrossAxisAlignment.center,
            SizedBox(height: 4),
            //Text("CODIGO : ${producto.pcode}"),
            Text(
              "NOMBRE : ${producto.pdescribe}",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.justify,
            ),
            Text("---------Precios---------"),
            Text(
              (producto.pventa1 == 0)
                  ? " "
                  : "$moneda ${producto.pventa1.toStringAsFixed(2)} $precio1bs ",
              style: _estilo,
              textAlign: TextAlign.right,
            ),
            Text(
              (producto.pventa2 == 0)
                  ? " "
                  : "$moneda ${producto.pventa2.toStringAsFixed(2)} $precio2bs ",
              style: _estilo,
              textAlign: TextAlign.right,
            ),
            Text(
              (producto.pventa3 == 0)
                  ? " "
                  : "$moneda ${producto.pventa3.toStringAsFixed(2)} $precio3bs ",
              style: _estilo,
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 10),
            Text(
              "SALDO  : ${producto.pexiste.toStringAsFixed(2)}",
              style: _estilo,
              textAlign: TextAlign.right,
            ),
            Text(
              "MEDIDA : ${producto.pmedida} ${producto.pmedempaque}",
              style: _estilo,
              textAlign: TextAlign.right,
            ),

            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
