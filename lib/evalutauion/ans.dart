import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:spark/main.dart';

class Ans extends StatefulWidget {
  const Ans({Key key}) : super(key: key);

  @override
  _AnsPage createState() => _AnsPage();
}

class _AnsPage extends State<Ans> {
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

  var poidss = TextEditingController();
  var tailles = TextEditingController();
  var ages = TextEditingController();

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
                    'assets/images/taille.png',
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
                controller: poidss,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Poids (Kg)',
                    hintText: 'Entrez votre poids Ex: 25'),
              ),
            ),
            Padding(
              padding:
              EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: tailles,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Taille (m)',
                    hintText: 'Entrez votre taille Ex: 190'),
              ),
            ),
            Padding(
              padding:
              EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: ages,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Age',
                    hintText: 'Entrez votre age Ex: 15'),
              ),
            ),
            const SizedBox(height: 25),
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 15),
              child: Text(
                "Sexe",
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 20,
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
                  parameters['poids'] = poidss.text;
                  parameters['taille'] = tailles.text;
                  parameters['age'] = ages.text;
                  parameters['iduser'] = id;
                  parameters['enceinte'] = '';
                  parameters['allaite'] = '';
                  parameters['mois'] = '';
                  parameters['ans'] = '1';
                  parameters['sexe'] = _selectedSexe;
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
                  print(resp);
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