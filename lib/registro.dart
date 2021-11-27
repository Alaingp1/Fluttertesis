import 'package:flutter/material.dart';
import 'package:flutter_tesisv2/login.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class Registro extends StatefulWidget {
  static const String ROUTE = "/registrar";

  @override
  _RegistroState createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController nombreuController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordcController = TextEditingController();
  TextEditingController direccionController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 8,
                      child: Center(
                        child: Text(
                          'Registro',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                    ),
                    TextFormField(
                        controller: nombreuController,
                        maxLength: 50,
                        decoration: InputDecoration(labelText: 'Nombre'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Debe Colocar Dato";
                          }

                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => node.nextFocus()),
                    TextFormField(
                        controller: emailController,
                        maxLength: 25,
                        keyboardType: TextInputType.emailAddress,
                        decoration:
                            InputDecoration(labelText: 'Correo electronico'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Debe Colocar Dato";
                          } else {
                            Pattern emailvalido =
                                r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$";
                            RegExp regExp = RegExp(emailvalido);
                            if (regExp.hasMatch(value)) {
                              return null;
                            }
                            return "ingrese un email valido";
                          }
                        },
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => node.nextFocus()),
                    TextFormField(
                        maxLength: 8,
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(labelText: 'Contraseña'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Debe Colocar Dato";
                          } else if (value != passwordcController.text) {
                            return "Deben ser iguales";
                          } else {
                            Pattern passvalida =
                                r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{5,8}$";
                            RegExp regExp = RegExp(passvalida);
                            if (regExp.hasMatch(value)) {
                              return null;
                            } else {
                              Fluttertoast.showToast(
                                  msg:
                                      "verifique su contraseña debe tener minimo 5 caracteres y un maximo de 8 donde al menos uno debe ser un numero ");
                            }
                            return null;
                          }
                        },
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => node.nextFocus()),
                    TextFormField(
                        maxLength: 8,
                        controller: passwordcController,
                        keyboardType: TextInputType.visiblePassword,
                        decoration:
                            InputDecoration(labelText: 'Confirmar contraseña'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Debe Colocar Dato";
                          } else if (value != passwordController.text) {
                            return "Deben ser iguales";
                          } else {
                            Pattern passvalida =
                                r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{5,8}$";
                            RegExp regExp = RegExp(passvalida);
                            if (regExp.hasMatch(value)) {
                              return null;
                            } else {
                              Fluttertoast.showToast(
                                  msg:
                                      "verifique su contraseña debe tener minimo 5 caracteres y un maximo de 8 donde al menos uno debe ser un numero ");
                            }
                            return null;
                          }
                        },
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => node.unfocus()),
                    TextFormField(
                        maxLength: 100,
                        controller: direccionController,
                        decoration: InputDecoration(labelText: 'Direccion'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Debe Colocar Dato";
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => node.nextFocus()),
                    TextFormField(
                        controller: telefonoController,
                        maxLength: 9,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(labelText: 'Telefono'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Debe Colocar Dato";
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => node.nextFocus()),
                    SizedBox(
                      height: 30.0,
                    ),
                    ElevatedButton(
                      // padding: EdgeInsets.only(top: 50),
                      child: TextButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            if (passwordController.text ==
                                    passwordcController.text &&
                                passwordController.text.isNotEmpty) {
                              registrarusuario();
                              Fluttertoast.showToast(
                                  msg: "usuario registrado exitosamente");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()));
                            }
                          }
                        },
                        child: Text(
                          'Registrarse',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ),
                        );
                      },
                      child: Text(
                        'Ya tienes cuenta? Inicia Sesión',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void registrarusuario() {
    var url = 'http://152.173.207.169/pruebastesis/crearUsuario.php';
    http.post(Uri.parse(url), body: {
      'Usuario_nombre': nombreuController.text,
      'Usuario_correo': emailController.text,
      'Usuario_contrasena': passwordController.text,
      'Usuario_direccion': direccionController.text,
      'Usuario_telefono': telefonoController.text,
    });
  }
}
