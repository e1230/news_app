import 'package:flutter/material.dart';
import 'package:news_app/src/pages/tab1_page.dart';
import 'package:news_app/src/pages/tab2_page.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new _NavigationModel(),
      child: Scaffold(
        body: _Pages(),
        bottomNavigationBar: _Navigation(),
      ),
    );
  }
}

class _Navigation extends StatelessWidget {
  const _Navigation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavigationModel>(context);
    return BottomNavigationBar(
      onTap: (i) => navigationModel.pagActual = i,
      currentIndex: navigationModel.pagActual,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), label: "Para ti"),
        BottomNavigationBarItem(icon: Icon(Icons.public), label: "Encabezados"),
      ],
    );
  }
}

class _Pages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final paginationModel = Provider.of<_NavigationModel>(context);
    return PageView(
      controller: paginationModel.pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Tab1Page(),
        Tab2Page(),
      ],
    );
  }
}

class _NavigationModel with ChangeNotifier {
  int _pagActual = 0;
  PageController _pageController = PageController();
  int get pagActual => this._pagActual;
  set pagActual(int valor) {
    this._pagActual = valor;
    _pageController.animateToPage(valor,duration: Duration(milliseconds: 250), curve: Curves.easeOut);
    notifyListeners();
  }

  PageController get pageController => _pageController;
}
