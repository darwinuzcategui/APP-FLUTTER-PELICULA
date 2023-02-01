//import 'dart:async';port

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../models/productos_model.dart';
//import '../productos../models/productos_model.dart';

class CardSwiper extends StatelessWidget {
  //const CardSwiper({Key key}) : super(key: key);
  final List<Producto> productos;

  CardSwiper({@required this.productos});

  get style => null;

  @override
  Widget build(BuildContext context) {
    // MediaQuery te da referencia deldispositivo
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
      padding: EdgeInsets.only(top: 8.0),

      // width: _screenSize.width * 0.7,
      //height: _screenSize.height * 0.3,

      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.43,
        // itemWidth: 400,
        //itemHeight: 225,
        itemBuilder: (BuildContext context, int index) {
          // productos[index].pcode = '${productos[index].pcode}-tarjeta';
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
          return Hero(
            tag: productos[index].pcode,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'detalle',
                    arguments: productos[index]),
                child: Stack(children: <Widget>[
                  SizedBox(height: 8),
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
                          Text("     Lista de Productos     ", style: _estilo),
                          SizedBox(height: 25.5),
                          Text(
                            "Codigo:" + productos[index].pcode,
                            style: _estilo,
                            textAlign: TextAlign.right,
                          ),
                          SizedBox(height: 9.5),
                          text1,
                          SizedBox(height: 9.5),
                          //Text(productos[index].preferencia, style: _estilo),
                          Divider(color: Color.fromARGB(179, 247, 245, 242),
                           //height: 20,
            thickness: 10,
            ),
                          SizedBox(height: 9.5),
                          precio1,
                          SizedBox(height: 9.5),
                          tasavalor,
                          precioBsvalor,
                          SizedBox(height: 19.5),
                          saldovalor,
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          );
        },

        itemCount: productos.length,
        // pagination: new SwiperPagination(),
        // control: new SwiperControl(),
      ),
    );
  }
}
/*
FadeInImage(
                  
                  image: NetworkImage(productos[index].getImagen()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.contain,
                ),

*/
/*
Stack(children: <Widget>[
            SizedBox(height: 100),
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
              ),
              color: Color.fromARGB(255, 19, 90, 149),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // SizedBox(height: 100),
                    Text(
                      productos[index].pdescribe,
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: 24,
                        color: Color.fromARGB(255, 8, 7, 12),
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ]);
*/