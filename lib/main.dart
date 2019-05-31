import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Home(),
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  GlobalKey<FormState> _formState = GlobalKey<FormState>();

  String _infoText = "";

  void limparCampos() {
    pesoController.text = "";
    alturaController.text = "";

    setState(() {
      _infoText = "";
      _formState = GlobalKey<FormState>();
    });
  }

  void calcularIMC() {
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;

      double imc = peso / (altura * altura);
      debugPrint(imc.toString());

      if (imc < 18.6) {
        _infoText = "Abaixo do peso. IMC: " + imc.toStringAsPrecision(4);
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso normal. IMC: " + imc.toStringAsPrecision(4);
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Acima do peso. IMC: " + imc.toStringAsPrecision(4);
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade I. IMC: " + imc.toStringAsPrecision(4);
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade II (severa). IMC: " + imc.toStringAsPrecision(4);
      } else if (imc >= 40) {
        _infoText =
            "Obesidade III (mórbida). IMC: " + imc.toStringAsPrecision(4);
      }
      debugPrint(_infoText.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.blue,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: limparCampos,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Form(
            key: _formState,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.person,
                  size: 130,
                  color: Colors.blue,
                ),
                TextFormField(
                  validator: (valor) {
                    if (valor.isEmpty) {
                      return "Insira o peso!";
                    }
                  },
                  controller: pesoController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  validator: (valor) {
                    if (valor.isEmpty) {
                      return "Insira a altura!";
                    }
                  },
                  controller: alturaController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Container(
                    height: 50,
                    child: RaisedButton(
                      onPressed: (){
                        if(_formState.currentState.validate()){
                          calcularIMC();
                        }
                      },
                      child: Text(
                        "Calcular",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      color: Colors.blue,
                    ),
                  ),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blue, fontSize: 25),
                )
              ],
            ),
          ),
        ));
  }
}
