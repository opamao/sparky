import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:spark/main.dart';

class Adulte extends StatefulWidget {
  const Adulte({Key key}) : super(key: key);

  @override
  _AdultePage createState() => _AdultePage();
}

class _AdultePage extends State<Adulte> {
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
                    'assets/images/poids.png',
                    width: 400,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: poids,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Poids (Kg)',
                    hintText: 'Entrez votre poids Ex: 25'),
              ),
            ),
            Padding(
              padding:
              EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: taille,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Taille (m)',
                    hintText: 'Entrez votre taille Ex: 190'),
              ),
            ),
            const SizedBox(height: 25),
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
                  parameters['poids'] = poids.text;
                  parameters['taille'] = taille.text;
                  parameters['age'] = age.text;
                  parameters['iduser'] = id;
                  parameters['enceinte'] = '';
                  parameters['allaite'] = '';
                  parameters['mois'] = '';
                  parameters['ans'] = '';
                  parameters['sexe'] = '';
                  parameters['moins'] = '';
                  parameters['perimetre'] = '';
                  var encodedBody = json.encode(parameters);
                  http.Response response = await http.post(
                      "http://pnn.reliance-service.com/api/imcs",
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