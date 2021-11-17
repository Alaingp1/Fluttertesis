import 'package:flutter/material.dart';

class TrabajadorBottomBar extends StatelessWidget {
  final String barItem;
  final Map<String, int> _barItemIndexMap = {
    'datostrabajador': 0,
    'trabajador': 1,
    'instalaciones': 2,
    'horario': 3,
  };

  TrabajadorBottomBar(this.barItem);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _barItemIndexMap[barItem],
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Perfil',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Instalaciones',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.watch_later_rounded),
          label: 'Horario',
        ),
      ],
      onTap: (index) => _handleNavigationAction(context, index),
    );
  }

  void _handleNavigationAction(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, 'datostrabajador');
        break;

      case 1:
        Navigator.pushReplacementNamed(context, 'trabajador');
        break;

      case 2:
        Navigator.pushReplacementNamed(context, 'instalaciones');
        break;

      case 3:
        Navigator.pushReplacementNamed(context, 'horario');

        break;
    }
  }
}

class ClienteBottomBar extends StatelessWidget {
  final String barItem;
  final Map<String, int> _barItemIndexMap = {
    'alertas': 0,
    'home': 1,
    'cultivos': 2,
  };

  ClienteBottomBar(this.barItem, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _barItemIndexMap[barItem],
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'notificaciones',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: 'cultivo',
        ),
      ],
      onTap: (index) => _handleNavigationAction(context, index),
    );
  }

  void _handleNavigationAction(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, 'alertas');
        break;

      case 1:
        Navigator.pushReplacementNamed(context, 'home');
        break;

      case 2:
        Navigator.pushReplacementNamed(context, 'cultivos');

        break;
    }
  }
}
