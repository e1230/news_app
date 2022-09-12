import 'package:flutter/material.dart';
import 'package:news_app/src/models/news_models.dart';
import 'package:news_app/src/themes/theme.dart';

class ListaNoticias extends StatelessWidget {
  final List<Article>? noticias;

  const ListaNoticias(this.noticias);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: this.noticias!.length,
        itemBuilder: (BuildContext context, int index) {
          return _Noticia(index: index, noticia: this.noticias![index]);
        });
  }
}

class _Noticia extends StatelessWidget {
  final Article noticia;
  final int index;

  const _Noticia({required this.index, required this.noticia});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _TarjetaTopBar(noticia, index),
      _TarjetaTitulo(noticia),
      _TarjetaImagen(noticia),
      _TarjetaBody(noticia),
      _TarjetaBotones(),
      SizedBox(
        height: 10,
      ),
      Divider(),
    ]);
  }
}

class _TarjetaBotones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RawMaterialButton(
          onPressed: () {},
          fillColor: myTheme.colorScheme.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(Icons.star_border),
        ),
        SizedBox(
          width: 10,
        ),
        RawMaterialButton(
          onPressed: () {},
          fillColor: myTheme.colorScheme.tertiary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(Icons.airline_seat_legroom_extra_sharp),
        ),
      ],
    );
  }
}

class _TarjetaBody extends StatelessWidget {
  final Article noticia;
  const _TarjetaBody(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child:
          Text((noticia.description != null) ? "${noticia.description}" : ""),
    );
  }
}

class _TarjetaImagen extends StatelessWidget {
  final Article noticia;
  const _TarjetaImagen(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        child: Container(
          child: (noticia.urlToImage != null)
              ? FadeInImage(
                  placeholder: AssetImage("assets/img/giphy.gif"),
                  image: NetworkImage("${noticia.urlToImage}"),
                )
              : Image(image: AssetImage("assets/img/no-image.png")),
        ),
      ),
    );
  }
}

class _TarjetaTitulo extends StatelessWidget {
  final Article noticia;

  const _TarjetaTitulo(this.noticia);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        "${noticia.title}",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _TarjetaTopBar extends StatelessWidget {
  final Article noticia;
  final int index;

  const _TarjetaTopBar(this.noticia, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, top: 0, right: 10, bottom: 10),
      child: Row(
        children: [
          Text("${index + 1}. ",
              style: TextStyle(color: myTheme.colorScheme.secondary)),
          Text("${noticia.source!.name}. "),
        ],
      ),
    );
  }
}
