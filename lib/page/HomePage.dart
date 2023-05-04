import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _inforText = "Informe sua altura e peso";

  void _resetCampo() {
    pesoController.text = "";
    alturaController.text = "";
    setState(() {
      _inforText = "Informe seus dados";
    });
  }

  void calcular() {
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;
      double imc = peso / (altura * altura);
      print('IMC: $imc');
      if (imc < 18.6) {
        _inforText = "Abaixo do Peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _inforText = 'Peso Ideal';
      } else if (imc >= 24.9 && imc < 29.9) {
        _inforText = 'Levemente Acima do Peso';
      } else if (imc >= 29.9 && imc < 34.9) {
        _inforText = 'Obesidade Grau I';
      } else if (imc >= 34.9 && imc < 39.9) {
        _inforText = 'Obesidade Grau III';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Calculadora IMC'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _resetCampo,
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.person,
                  size: 150,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Peso (kg)',
                    labelStyle: TextStyle(color: Colors.black, fontSize: 30),
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 50),
                  controller: pesoController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo Peso vazio, informe o seu peso';
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('Altura (cm)'),
                    labelStyle: TextStyle(color: Colors.black, fontSize: 30),
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 50),
                  controller: alturaController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Campo Altura vazio, informe a sua altura";
                    }
                  },
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Container(
                    height: 70,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          calcular();
                        }
                      },
                      child: const Text(
                        "Calcular",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                ),
                Text(
                  _inforText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black, fontSize: 25),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
