import 'package:flutter/material.dart';
import 'package:news_app/src/services/news_service.dart';
import 'package:news_app/src/themes/theme.dart';
import 'package:news_app/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab1Page extends StatefulWidget {
  @override
  State<Tab1Page> createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page> with AutomaticKeepAliveClientMixin{
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
      
    return Scaffold(
      body: (newsService.headlines.length == 0) ?
        Center(
          child: CircularProgressIndicator(color: myTheme.colorScheme.primary,),
        ):(
          ListaNoticias(newsService.headlines)
        ),
    );
  } 

  @override
  bool get wantKeepAlive => true;
}
