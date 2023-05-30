import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:spark/main.dart';

class Femme_ extends StatefulWidget {
  const Femme_({Key key}) : super(key: key);

  @override
  _FemmePage_ createState() => _FemmePage_();
}

class _FemmePage_ extends State<Femme_> {
  String id = "";

  @override
  void initState() {
    super.initState();
    getCred();
  }

  void getCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString("id");
    });
  }

  var poids = TextEditingController();
  var taille = TextEditingController();
  var age = TextEditingController();
  var poidss = TextEditingController();
  var tailles = TextEditingController();
  var ages = TextEditingController();
  var peri = TextEditingController();
  var ageperi = TextEditingController();
  var agebra = TextEditingController();
  var bra = TextEditingController();
  var poidsmois = TextEditingController();
  var taillemois = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.asset(
                    'assets/images/enceinte.png',
                    width: 400,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 15),
              child: TextField(
                controller: peri,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'PB (mm)',
                    hintText: 'Entrez le périmètre brachial'),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(247, 127, 0, 1),
                  borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(247, 127, 0, 1),
                ),
                onPressed: () async {
                  Map<String, String> parameters = Map<String, String>();
                  parameters['poids'] = '';
                  parameters['taille'] = '';
                  parameters['age'] = ageperi.text;
                  parameters['iduser'] = id;
                  parameters['enceinte'] = '1';
                  parameters['allaite'] = '';
                  parameters['mois'] = '';
                  parameters['ans'] = '';
                  parameters['sexe'] = '';
                  parameters['moins'] = '';
                  parameters['perimetre'] = peri.text;
                  var encodedBody = json.encode(parameters);
                  http.Response response = await http.post(
                      "http://pnn.reliance-service.com/api/imcst",
                      body: encodedBody,
                      headers: {
                        'Content-type': 'application/json',
                        'Accept': 'application/json'
                      });
                  var resp = json.decode(response.body);
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text(resp['succes']),
                      );
                    },
                  );
                  print(encodedBody);
                },
                child: Text(
                  'Evaluer',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}