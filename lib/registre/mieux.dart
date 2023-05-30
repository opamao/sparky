import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:spark/main.dart';

class Mieux extends StatefulWidget {
  Mieux({Key key}) : super(key: key);

  @override
  _MieuxPage createState() => _MieuxPage();
}

class _MieuxPage extends State<Mieux> {
  var genre = TextEditingController();
  var _dateDebut = TextEditingController();

  bool showvalue = false;

  int _value = 0;

  String telephone, email, pseudo, nom, password = "";

  @override
  void initState() {
    super.initState();
    getCred();
  }

  void getCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      telephone = pref.getString("contact");
      email = pref.getString("email");
      pseudo = pref.getString("pseudo");
      nom = pref.getString("nom");
      password = pref.getString("password");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4F8),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.asset(
                    'assets/images/mieux.png',
                    width: 400,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding:
              EdgeInsets.only(left: 0, right: 15.0, top: 0, bottom: 20.0),
              child: Text("Mieux se connaître",
                  textAlign: TextAlign.left,
                  style:
                  TextStyle(fontSize: 30, fontWeight: FontWeight.normal)),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding:
              EdgeInsets.only(left: 0, right: 15.0, top: 0, bottom: 30.0),
              child: Text("Vous êtes un(e) ?",
                  textAlign: TextAlign.left,
                  style:
                  TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
            ),
            Padding(
              padding:
              EdgeInsets.only(left: 0, right: 15.0, top: 0, bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => setState(() => _value = 0),
                    child: Container(
                        height: 56,
                        width: 150,
                        color: _value == 0 ? Colors.blueAccent : Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.male),
                              Text('Homme', style: TextStyle(fontSize: 18, color: Colors.black),)
                        ] ),
                    ),
                  ),
                  SizedBox(width: 4),
                  GestureDetector(
                    onTap: () => setState(() => _value = 1),
                    child: Container(
                      height: 56,
                      width: 150,
                      color: _value == 1 ? Colors.purpleAccent : Colors
                          .transparent,
                      child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.female),
                            Text('Femme', style: TextStyle(fontSize: 18, color: Colors.black),)
                          ] ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            const Padding(
              padding:
              EdgeInsets.only(left: 0.0, right: 0.0, top: 0, bottom: 0.0),
              child: Text("Vous êtes né(e)s le ?",
                  textAlign: TextAlign.left,
                  style:
                  TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
            ),
            Padding(
                padding:
                EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: SizedBox(
                    width: 450,
                    child: TextField(
                      controller: _dateDebut,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.calendar_today_rounded),
                          labelText: "jj/mm/aaaa"),
                      onTap: () async {
                        DateTime pickeddate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2101));

                        if (pickeddate != null) {
                          setState(() {
                            _dateDebut.text =
                                DateFormat('dd/MM/yyyy')
                                    .format(pickeddate);
                          });
                        }
                      },
                    ))
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 60,
              width: 450,
              decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                onPressed: () async {
                  signup();
                },
                child: const Text(
                  'Je confirme mes réponses',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  void signup() async {
    if (_dateDebut.text.isNotEmpty) {
      var reponse = await http.post(
          Uri.parse("http://pnn.reliance-service.com/api/register"),
          body: (
              {
                'nom': nom,
                'contact': telephone,
                'email': email,
                'genre': _value == 0 ? "Homme" : "Femme",
                'naissance': _dateDebut.text,
                'pseudo': pseudo,
                'password': password
              }
              ));
      print(nom);
      print("Tel " + telephone);
      print(email);
      print(_value == 0 ? "Homme" : "Femme");
      print(_dateDebut.text);
      print(password);

      if (reponse.statusCode == 200) {
        var resp = json.decode(reponse.body);

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("${resp["succes"]}")));

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Login()));

      } else {
        var resp = json.decode(reponse.body);

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("${resp["error"]}")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Les champs sont obligatoires")));
    }
  }
}

class Gender {
  String name;
  IconData icon;
  bool isSelected;

  Gender(this.name, this.icon, this.isSelected);
}
