import 'package:flutter/material.dart';
import '../models/productos_model.dart';

class ProductosVertical extends StatelessWidget {
  final List<Producto> productos;
  final Producto producto;
  final Function siguientePagina;

  ProductosVertical(
      //{@required this.productos, @required this.siguientePagina});
      {@required this.productos,
      this.siguientePagina,
      List codigo,
      this.producto});

  final _paginaCtl = new PageController(initialPage: 1, viewportFraction: 0.3);

  @override
  Widget build(BuildContext context) {
    final _medidaPantalla = MediaQuery.of(context).size;

    _paginaCtl.addListener(() {
      if (_paginaCtl.position.pixels >=
          _paginaCtl.position.maxScrollExtent - 200) {
        //print('cargas siguiente producto');
        //siguientePagina();
      } else {
        print('...');
      }
    });

    return Container(
      color: Color.fromARGB(255, 226, 244, 248),
      height: _medidaPantalla.height * 0.244,
      //width: _medidaPantalla.width * 105.50,
      child: PageView.builder(
        pageSnapping: false,
        controller: _paginaCtl,
        //children: _tarjetas(context),
        itemCount: productos.length,
        itemBuilder: (context, i) {
          return _unaTarjeta(context, productos[i]);
        },
      ),
      // PageView sirve para delizar Widget, contenedores, paginas, card, etc.
    );
  }

  Widget _unaTarjeta(BuildContext context, Producto producto) {
    //producto.pcode = '${producto.pcode}';
    //print(codigo.toString());

    var pmoneydif = producto.pmoneydif;
    var moneda = (pmoneydif == 1)
        ? "\$."
        : (pmoneydif == 2)
            ? "Eur."
            : "Bs.";
    var precio = '$moneda${producto.pventa1.toString()}';

    final productoTarjeta = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 2.0),
          Text(
            "Cant:" + producto.pexiste.toStringAsPrecision(4),
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          SizedBox(height: 2.0),
          Text(
            precio,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          SizedBox(height: 2.0),
          Hero(
            tag: producto.pcode,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(producto.getImagen()),
                fit: BoxFit.cover,
                height: 80.0,
                width: 210.0,
              ),
            ),
          ),
          SizedBox(height: 3.0),
          Text(
            producto.pdescribe,
            overflow: TextOverflow.clip,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
    return GestureDetector(
      child: productoTarjeta,
      onTap: () {
        //print('Pulsaste click aqui! el de la producto es Id ${producto.pcode}');
        // Navigator.pushNamed(context, '/', arguments: producto);
        // Navigator.pushNamed(context, 'detalle', arguments: producto);
        _dialogBuilder(context, producto);
      },
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
