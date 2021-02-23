import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:peliculas/models/peliculas_model.dart';

class CardSwiper extends StatelessWidget {
  //const CardSwiper({Key key}) : super(key: key);
  final List<Pelicula> peliculas;

  CardSwiper({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    // MediaQuery te da referencia deldispositivo
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 8.0),
      // width: _screenSize.width * 0.7,
      // height: _screenSize.height * 0.5,
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.499,
        itemBuilder: (BuildContext context, int index) {

          peliculas[index].idUnico = '${peliculas[index].id}-tarjeta';



          return Hero(
            tag: peliculas[index].idUnico,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: GestureDetector(
                  onTap: ()=>Navigator.pushNamed(context,'detalle',arguments: peliculas[index]),
                  child: FadeInImage(
                    image: NetworkImage(peliculas[index].getImagen()),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    fit: BoxFit.cover,
                  ),
                )
                ),
          );
        
        },

        itemCount: peliculas.length,
        // pagination: new SwiperPagination(),
        // control: new SwiperControl(),
      ),
    );
  }
}
