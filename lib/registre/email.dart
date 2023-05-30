import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:spark/registre/passe.dart';

class Emails extends StatefulWidget {
  Emails({Key key}) : super(key: key);

  @override
  _EmailsPage createState() => _EmailsPage();
}

class _EmailsPage extends State<Emails> {
  var email = TextEditingController();

  String telephone, pseudo, nom = "";

  @override
  void initState() {
    super.initState();
    getCred();
  }

  void getCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      telephone = pref.getString("contact");
      pseudo = pref.getString("pseudo");
      nom = pref.getString("nom");
    });
  }

  bool showvalue = true;

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
                    'assets/images/email.png',
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
              EdgeInsets.only(left: 0, right: 15.0, top: 0, bottom: 50.0),
              child: Text("Quel est votre email ?",
                  textAlign: TextAlign.left,
                  style:
                  TextStyle(fontSize: 30, fontWeight: FontWeight.normal)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'E-mail',
                    hintText: 'theodoreyapi@gmail.com'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Pourquoi en avez-vous besoin?',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CheckboxListTile(
                title: const Text("J’accepte de recevoir des newsletters"),
                value: this.showvalue,
                onChanged: (bool value) {
                  setState(() {
                    this.showvalue = value;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              )
            ),
            SizedBox(
              height: 20,
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
                  'Valider',
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
    if (email.text.isNotEmpty) {

      print(telephone);

      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString("contact", telephone);
      await pref.setString("email", email.text);
      await pref.setString("pseudo", pseudo);
      await pref.setString("nom", nom);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Passes()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Veuillez renseigner adresse e-mail")));
    }
  }
}
