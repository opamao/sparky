import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:spark/main.dart';

class Informations extends StatefulWidget {
  const Informations({Key key}) : super(key: key);

  @override
  _InformationsPage createState() => _InformationsPage();
}

class _InformationsPage extends State<Informations> {
  String id, noms, telephones, villes, emails, ages, genres, maladies = "";
  var nom, contact, age, ville, email, maladie;

  @override
  void initState() {
    super.initState();
    getCred();
  }

  void getCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString("id");
      noms = pref.getString("nom");
      telephones = pref.getString("telephone");
      villes = pref.getString("ville");
      emails = pref.getString("email");
      ages = pref.getString("age");
      genres = pref.getString("genre");
      maladies = pref.getString("maladie");

      //permet de mettre les information dans editext
      nom = TextEditingController(text: noms);
      contact = TextEditingController(text: telephones);
      age = TextEditingController(text: ages);
      ville = TextEditingController(text: villes);
      email = TextEditingController(text: emails);
      maladie = TextEditingController(text: maladies);
    });
  }

  var passe = TextEditingController();

  String _selectedSexe = 'garcon';

  int idd = 1;

  // int _selection = 0;
  //
  // selectTime(int timeSelected) {
  //   setState(() {
  //     _selection = timeSelected;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(1, 22, 59, 1),
        title: Text("MES INFORMATIONS"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // InkWell(
                //   onTap: () {
                //     setState(() {
                //       _selection = 1;
                //     });
                //   },
                //   child: Stack(
                //     children: <Widget>[
                //       Container(
                //         height: 40,
                //         width: 150,
                //         color: _selection == 1 ? Colors.green : Colors.white,
                //       ),
                //       Row(
                //         children: <Widget>[
                //           Radio(
                //             focusColor: Colors.white,
                //             groupValue: _selection,
                //             onChanged: selectTime,
                //             value: 1,
                //           ),
                //           Text(
                //             "11:00 - 12:00",
                //             style: TextStyle(fontWeight: FontWeight.bold),
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                // InkWell(
                //   onTap: () {
                //     setState(() {
                //       _selection = 2;
                //     });
                //   },
                //   child: Stack(
                //     children: <Widget>[
                //       Container(
                //         height: 40,
                //         width: 150,
                //         color: _selection == 2 ? Colors.green : Colors.white,
                //       ),
                //       Row(
                //         children: <Widget>[
                //           Radio(
                //             focusColor: Colors.white,
                //             groupValue: _selection,
                //             onChanged: selectTime,
                //             value: 2,
                //           ),
                //           Text(
                //             "11:00 - 12:00",
                //             style: TextStyle(fontWeight: FontWeight.bold),
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
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
            const SizedBox(height: 25),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: nom,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nom complet',
                    hintText: 'Entrez votre nom & prénom'),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: contact,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Contact',
                    hintText: 'Entrez votre numérot de téléphone'),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: ville,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Ville',
                    hintText: 'Entrez votre ville'),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: email,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'E-mail',
                    hintText: 'Entrez votre adresse mail'),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: age,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Age',
                    hintText: 'Entrez votre âge'),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: maladie,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Maladie chronique',
                    hintText: 'Entrez votre maladie chronique'),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: passe,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nouveau mot de passe',
                    hintText: 'Saisissez votre nouveau mot de passe'),
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
                  print('password ' + passe.text.toString());
                  Map<String, String> parameters = Map<String, String>();
                  parameters['nom'] = nom.text;
                  parameters['contact'] = contact.text;
                  parameters['ville'] = ville.text;
                  parameters['iduser'] = id;
                  parameters['email'] = email.text;
                  parameters['age'] = age.text;
                  parameters['passe'] = passe.text;
                  parameters['sexe'] = _selectedSexe;
                  parameters['maladie'] = maladie.text;
                  var encodedBody = json.encode(parameters);
                  http.Response response = await http.post(
                      "http://pnn.reliance-service.com/api/infoupdate",
                      body: encodedBody,
                      headers: {
                        'Content-type': 'application/json',
                        'Accept': 'application/json'
                      });
                  var resp = json.decode(response.body);
                  print(resp);
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("${resp['succes']}")));
                  // showDialog(
                  //   context: context,
                  //   builder: (context) {
                  //     return AlertDialog(
                  //       content: Text(resp['succes']),
                  //     );
                  //   },
                  // );
                },
                child: Text(
                  'Mettre à jour',
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
