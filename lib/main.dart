import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tesisv2/home.dart';
import 'package:flutter_tesisv2/login.dart';
import 'package:flutter_tesisv2/recuperar_contrasena.dart';
import 'package:flutter_tesisv2/src/cultivos/acciones/editar_cultivo.dart';
import 'package:flutter_tesisv2/src/cultivos/cultivos.dart';
import 'package:flutter_tesisv2/src/cultivos/sensores/Sensores.dart';
import 'package:flutter_tesisv2/src/empresa/contacto.dart';
import 'package:flutter_tesisv2/src/empresa/datos_empresa.dart';
import 'package:flutter_tesisv2/src/usuarios/ListadoOrdenes.dart';
import 'package:flutter_tesisv2/src/usuarios/acciones/orden_detalle.dart';
import 'package:flutter_tesisv2/src/productos/acciones/detalle_producto.dart';
import 'package:flutter_tesisv2/src/productos/acciones/ordenar_producto.dart';
import 'package:flutter_tesisv2/src/productos/productos.dart';
import 'package:flutter_tesisv2/src/trabajador/acciones/instalacion_reagendar.dart';
import 'package:flutter_tesisv2/src/trabajador/datos_trabajador.dart';
import 'package:flutter_tesisv2/src/trabajador/horario.dart';
import 'package:flutter_tesisv2/src/trabajador/instalaciones.dart';
import 'package:flutter_tesisv2/src/trabajador/acciones/instalaciones_detalle.dart';
import 'package:flutter_tesisv2/src/trabajador/trabajador.dart';
import 'package:flutter_tesisv2/src/usuarios/acciones/crear_publicacion.dart';
import 'package:flutter_tesisv2/src/usuarios/acciones/editar_usuario.dart';
import 'package:flutter_tesisv2/src/usuarios/acciones/listar_publicaciones.dart';
import 'package:flutter_tesisv2/src/usuarios/alertas.dart';
import 'package:flutter_tesisv2/src/usuarios/usuarios.dart';

import 'src/cultivos/acciones/conectar_placa.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        bottomAppBarColor: Colors.white,
        brightness: Brightness.light,
        primaryColor: Color.fromRGBO(0, 165, 207, 1),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData.dark(),
      title: "Login",
      initialRoute: Login.ROUTE,
      routes: {
        "login": (BuildContext context) => Login(),
        Login.ROUTE: (_) => Login(),
        "home": (BuildContext context) => Home(),
        Home.ROUTE: (_) => Home(),
        "cuenta": (BuildContext context) => Cuenta(),
        Cuenta.ROUTE: (_) => Cuenta(),
        "horario": (BuildContext context) => Horario(),
        Horario.ROUTE: (_) => Horario(),
        "cultivos": (BuildContext context) => Cultivo(),
        Cultivo.ROUTE: (_) => Cultivo(),
        "trabajador": (BuildContext context) => Trabajador(),
        Trabajador.ROUTE: (_) => Trabajador(),
        "productos": (BuildContext context) => Productos(),
        Productos.ROUTE: (_) => Productos(),
        "detallesproducto": (BuildContext context) => DetallesProducto(),
        DetallesProducto.ROUTE: (_) => DetallesProducto(),
        "datostrabajador": (BuildContext context) => DatosTrabajador(),
        DatosTrabajador.ROUTE: (_) => DatosTrabajador(),
        "datosempresa": (BuildContext context) => DatosEmpresa(),
        DatosEmpresa.ROUTE: (_) => DatosEmpresa(),
        "contacto": (BuildContext context) => Contacto(),
        Contacto.ROUTE: (_) => Contacto(),
        "instalacionesdetalle": (BuildContext context) =>
            InstalacionesDetalle(),
        InstalacionesDetalle.ROUTE: (_) => InstalacionesDetalle(),
        "instalaciones": (BuildContext context) => Instalaciones(),
        ReagendarInstalacion.ROUTE: (_) => ReagendarInstalacion(),
        "reagendarinstalacion": (BuildContext context) =>
            ReagendarInstalacion(),
        Instalaciones.ROUTE: (_) => Instalaciones(),
        "ordenarproducto": (BuildContext context) => OrdenarProducto(),
        OrdenarProducto.ROUTE: (_) => OrdenarProducto(),
        "editarusuario": (BuildContext context) => EditarUsuario(),
        EditarUsuario.ROUTE: (_) => EditarUsuario(),
        "editarcultivo": (BuildContext context) => EditarCultivo(),
        EditarCultivo.ROUTE: (_) => EditarCultivo(),
        "publicacion": (BuildContext context) => Publicacion(),
        Publicacion.ROUTE: (_) => Publicacion(),
        "recuperarcontrasena": (BuildContext context) => RecuperarContrasena(),
        RecuperarContrasena.ROUTE: (_) => RecuperarContrasena(),
        "Sensores": (BuildContext context) => Sensores(),
        Sensores.ROUTE: (_) => Sensores(),
        "alertas": (BuildContext context) => Alertas(),
        Alertas.ROUTE: (_) => Alertas(),
        "listapub": (BuildContext context) => ListaPublicaciones(),
        ListaPublicaciones.ROUTE: (_) => ListaPublicaciones(),
        "listadoOrdenes": (BuildContext context) => ListadoOrdenes(),
        ListadoOrdenes.ROUTE: (_) => ListadoOrdenes(),
        "ordenDetalle": (BuildContext context) => OrdenDetalle(),
        OrdenDetalle.ROUTE: (_) => OrdenDetalle(),
        "conectarplaca": (BuildContext context) => Placa(),
        Placa.ROUTE: (_) => Placa(),
      },
    );
  }
}
