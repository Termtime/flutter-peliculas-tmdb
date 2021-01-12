import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:peliculas/src/modelos/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {

  final List<Pelicula> peliculas;
  final Function siguientePagina;
  MovieHorizontal({@required this.peliculas, @required this.siguientePagina});
  final _pageController = new PageController(
      initialPage: 1,
      viewportFraction: 0.25,
  );

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener( () {
      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent-200)
        siguientePagina();
    });


    return Container(
      height: _screenSize.height*0.2,
      child: PageView.builder(
        controller: _pageController,
        pageSnapping: false,
        itemCount: peliculas.length,
        itemBuilder: (context, index) {
          return _tarjetaHorizontal(context, peliculas[index]);
        },
        // children: _tarjetas(context),
      ),
    );
  }

  Widget _tarjetaHorizontal(BuildContext context, Pelicula pelicula)
  {

    pelicula.uniqueId = '${pelicula.id}-peque';

    final tarjeta = Container(
        margin: EdgeInsets.only(right: 15),
        child: Column(
          children: <Widget>[
            Hero(
              tag: pelicula.uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  image: NetworkImage(pelicula.getPosterImg()),
                  placeholder: AssetImage('assets/img/loading.gif'),
                  fit: BoxFit.cover,
                  height: 113,
                ),
              ),
            ),
            SizedBox(height:0.5),
            Text(pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      );

    return GestureDetector(
      child: tarjeta,
      onTap: (){
        timeDilation = 1.5;
        Navigator.pushNamed(context, 'detalle', arguments: pelicula);
      },
    );  
  }

  List<Widget> _tarjetas(BuildContext context)
  {
    return peliculas.map((pelicula) {
      return Container(
        margin: EdgeInsets.only(right: 15),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
              image: NetworkImage(pelicula.getPosterImg()),
              placeholder: AssetImage('assets/img/loading.gif'),
              fit: BoxFit.cover,
              height: 113,
              ),
            ),
            SizedBox(height:0.5),
            Text(pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      );
    }).toList();
  }
}