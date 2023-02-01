import 'package:flutter/material.dart';
import '../models/productos_model.dart';

class ProductosHorizontal extends StatelessWidget {
  final List<Producto> productos;
  final Function siguientePagina;

  ProductosHorizontal(
      //{@required this.productos, @required this.siguientePagina});
      {@required this.productos,
      this.siguientePagina});

  final _paginaCtl = new PageController(initialPage: 1, viewportFraction: 0.3);

  @override
  Widget build(BuildContext context) {
    final _medidaPantalla = MediaQuery.of(context).size;

    _paginaCtl.addListener(() {
      if (_paginaCtl.position.pixels >=
          _paginaCtl.position.maxScrollExtent - 200) {
        print('cargas siguiente producto');
        siguientePagina();
      } else {
        print('...');
      }
    });

    return Container(
      height: _medidaPantalla.height * 0.30,
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
    producto.pcode = '*${producto.pcode}*';

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
          SizedBox(height: 3.0),
          Text(
            "Cant:" + producto.pexiste.toStringAsPrecision(4),
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          SizedBox(height: 3.0),
          Text(
            precio,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          SizedBox(height: 3.0),
          Hero(
            tag: producto.pcode,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(producto.getImagen()),
                fit: BoxFit.cover,
                height: 90.0,
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
        print('Pulsaste click aqui! el de la pelicula es Id ${producto.pcode}');
        Navigator.pushNamed(context, 'detalle', arguments: producto);
      },
    );
  }
}
