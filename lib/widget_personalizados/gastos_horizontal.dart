import 'package:flutter/material.dart';
import '../models/gastos_model.dart';

class GastosHorizontal extends StatelessWidget {
  final List<Gasto> gastos;
  final Function siguientePagina;

  GastosHorizontal(
      //{@required this.gastos, @required this.siguientePagina});
      {@required this.gastos,
      this.siguientePagina});

  final _paginaCtl = new PageController(initialPage: 1, viewportFraction: 0.3);

  @override
  Widget build(BuildContext context) {
    final _medidaPantalla = MediaQuery.of(context).size;

    _paginaCtl.addListener(() {
      if (_paginaCtl.position.pixels >=
          _paginaCtl.position.maxScrollExtent - 200) {
        print('cargas siguiente gasto');
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
        itemCount: gastos.length,
        itemBuilder: (context, i) {
          return _unaTarjeta(context, gastos[i]);
        },
      ),
      // PageView sirve para delizar Widget, contenedores, paginas, card, etc.
    );
  }

  Widget _unaTarjeta(BuildContext context, Gasto gasto) {
    gasto.codart = '${gasto.codart}';

    var pmoneydif = gasto.posren;
    var moneda = (pmoneydif == 1)
        ? "\$."
        : (pmoneydif == 2)
            ? "Eur."
            : "Bs.";
    var precio = '$moneda${gasto.precio.toString()}';

    final productoTarjeta = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 3.0),
          Text(
            "Cant:" + gasto.precioMm.toStringAsPrecision(4),
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
            tag: gasto.codart,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: AssetImage('assets/img/barra1.png'),
                //image: NetworkImage(gasto.getImagen()),
                fit: BoxFit.cover,
                height: 90.0,
                width: 210.0,
              ),
            ),
          ),
          SizedBox(height: 1.0),
          Text(
            gasto.nomart,
            overflow: TextOverflow.clip,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
    return GestureDetector(
      child: productoTarjeta,
      onTap: () {
        print('Pulsaste click aqui! el de la producto es Id ${gasto.codart}');
        Navigator.pushNamed(context, 'detalle', arguments: gasto);
      },
    );
  }
}
