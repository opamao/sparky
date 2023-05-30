import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:spark/main.dart';


class Mois_ extends StatefulWidget {
  const Mois_({Key key}) : super(key: key);

  @override
  _MoisPage_ createState() => _MoisPage_();
}

class _MoisPage_ extends State<Mois_> {
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

  String _selectedSexe = 'garcon';

  int idd = 1;

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
                    'assets/images/mois.png',
                    width: 400,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 15),
              child: Text(
                "Poids pour Taille (P/T)",
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 15),
              child: TextField(
                controller: poidsmois,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Poids (kg)',
                    hintText: 'Entrez le poids'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 15),
              child: TextField(
                controller: taillemois,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Taille (cm)',
                    hintText: 'Entrez la taille'),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 15),
              child: Text(
                "Périmètre Brachial (PB) ou MUAC en cm",
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 15),
              child: TextField(
                controller: bra,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'PB (mm)',
                    hintText: 'Entrez le périmètre brchial'),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 15),
              child: Text(
                "Sexe",
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Radio(
                        value: 1,
                        groupValue: idd,
                        onChanged: (value) {
                          setState(() {
                            _selectedSexe = 'garcon';
                            idd = 1;
                          });
                        },
                      ),
                      const Expanded(
                        child: Text('Garçon'),
                      )
                    ],
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Row(
                    children: [
                      Radio(
                        value: 2,
                        groupValue: idd,
                        onChanged: (value) {
                          setState(() {
                            _selectedSexe = 'fille';
                            idd = 2;
                          });
                        },
                      ),
                      const Expanded(child: Text('Fille'))
                    ],
                  ),
                  flex: 1,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 15),
              child: TextField(
                controller: agebra,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Age',
                    hintText: 'Entrez l\'age de l\'enfant'),
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
                  parameters['poids'] = poidsmois.text;
                  parameters['taille'] = taillemois.text;
                  parameters['age'] = agebra.text;
                  parameters['iduser'] = id;
                  parameters['enceinte'] = '';
                  parameters['allaite'] = '';
                  parameters['mois'] = '1';
                  parameters['ans'] = '';
                  parameters['sexe'] = _selectedSexe;
                  parameters['moins'] = '';
                  parameters['perimetre'] = bra.text;
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