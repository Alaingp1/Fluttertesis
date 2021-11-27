import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:intl/intl.dart';

class OrdenarProducto extends StatefulWidget {
  // ignore: constant_identifier_names
  static const String ROUTE = "/ordenarproducto";
  final String id;

  const OrdenarProducto({Key key, this.id}) : super(key: key);

  @override
  _OrdenarProductoState createState() => _OrdenarProductoState();
}

class _OrdenarProductoState extends State<OrdenarProducto> {
  var _currenteSelectedDate;
  Map datauser;
  int datastock = -1;
  int cantidad = 0;

  TextEditingController controlFecha = new TextEditingController();
  TextEditingController controlCantidad = new TextEditingController();
  TextEditingController controlDireccion = new TextEditingController();
  TextEditingController controlTelefono = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var producto;
  int precio = 0;
  @override
  void initState() {
    obtenerUsuarios().then((value) {
      datauser = value;

      setState(() {});
    });
    obtenerCantidad().then((value) {
      datastock = int.parse(value['Producto_stock']);
      print(value['Producto_stock']);
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    producto = ModalRoute.of(context).settings.arguments as Map;
    precio = precio == 0 ? int.parse(producto['Producto_precio']) : precio;
    String preciot =
        NumberFormat("#,###").format(precio).toString().replaceAll(",", ".");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 131, 163, 1),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(10.0),
              children: [
                Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 35.0,
                      ),
                      Text(
                        "Verifique sus datos",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Direccion ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 15),
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: controlDireccion,
                        decoration: new InputDecoration(
                            labelText: datauser != null
                                ? datauser['Usuario_direccion']
                                : ""),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Telefono ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 15),
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: controlTelefono,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: datauser != null
                                ? datauser['Usuario_telefono']
                                : ""),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Seleccione la Cantidad de Productos ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      datastock > 0
                          ? CustomNumberPicker(
                              initialValue: 1,
                              maxValue: datastock ?? 1,
                              minValue: 1,
                              step: 1,
                              onValue: (value) {
                                cantidad = value;
                                precio =
                                    int.parse(producto['Producto_precio']) *
                                        cantidad;

                                setState(() {});
                              },
                            )
                          : Container(
                              child: Text("no existe stock disponible"),
                            ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        "Precio: \$" + preciot,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Seleccione la fecha para la instalacion",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      TextFormField(
                          enableInteractiveSelection: false,
                          controller: controlFecha,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Debe Seleccionar Una Fecha";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Fecha',
                          ),
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            callDatePicker();
                          }),
                      SizedBox(
                        height: 25.0,
                      ),
                      datastock > 0
                          ? FlatButton(
                              color: Color.fromRGBO(0, 131, 163, 1),
                              child: Text(
                                "Ordenar producto",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 15),
                                textAlign: TextAlign.center,
                              ),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  validarDatos();

                                  //  obtenerUsuarios();
                                  generarOrden();

                                  showToast();
                                  Navigator.of(context)
                                      .pushReplacementNamed("productos");
                                }
                              },
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void generarOrden() async {
    var id = await FlutterSession().get('id');
    var producto = ModalRoute.of(context).settings.arguments as Map;
    print(producto);
    var url = "http://152.173.207.169/pruebastesis/generarOrden2.php";
    // final response = await http.get(Uri.parse(url));
    http.post(
      Uri.parse(url),
      body: {
        "Usuario_id": id.toString(),
        "Orden_Fecha": controlFecha.text.toString(),
        "Orden_cantidad_producto": cantidad.toString(),
        "Producto_id": producto['Producto_id'].toString(),
      },
    );
  }

  void callDatePicker() async {
    var selectedDate = await getDatePikerWidget();
    if (selectedDate != null) {
      final myFormat = DateFormat('yyyy-MM-d');
      controlFecha.text = myFormat.format(selectedDate);

      setState(() {});
    }
  }

  Future<DateTime> getDatePikerWidget() async {
    return showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),
        builder: (context, child) {
          return Theme(data: ThemeData.dark(), child: child);
        });
  }

  void validarDatos() async {
    var id = await FlutterSession().get('id');
    var url =
        "http://152.173.207.169/pruebastesis/validarDatos.php?Usuario_id=$id";
    http.post(Uri.parse(url), body: {
      'Usuario_direccion': controlDireccion.text,
      'Usuario_telefono': controlTelefono.text,
    });
  }

  Future<Map<String, dynamic>> obtenerUsuarios() async {
    var id = await FlutterSession().get('id');
    var url =
        "http://152.173.207.169/pruebastesis/obtenerDatos.php?Usuarioid=$id";
    final response = await http.get(Uri.parse(url));
    return json.decode(response.body)[0];
  }

  Future obtenerCantidad() async {
    var id = await FlutterSession().get('id');
    var producto = ModalRoute.of(context).settings.arguments as Map;
    var idProd = producto['Producto_id'];
    var url =
        "http://152.173.207.169/pruebastesis/obtenerCantidad.php?Producto_id=$idProd";
    final response = await http.get(Uri.parse(url));

    return json.decode(response.body);
  }

  void showToast() {
    Fluttertoast.showToast(
        msg: 'Producto Ordenado',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.purple,
        textColor: Colors.white);
  }
}
