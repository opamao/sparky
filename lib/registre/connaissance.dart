import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:spark/registre/email.dart';

class Connaissance extends StatefulWidget {
  Connaissance({Key key}) : super(key: key);

  @override
  _ConnaissancePage createState() => _ConnaissancePage();
}

class _ConnaissancePage extends State<Connaissance> {
  var pseudo = TextEditingController();
  var nom = TextEditingController();

  String telephone = "";

  @override
  void initState() {
    super.initState();
    getCred();
  }

  void getCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      telephone = pref.getString("contact");
    });
  }

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
              padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.asset(
                    'assets/images/connaissance.png',
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
              child: Text("Faisons connaissance",
                  textAlign: TextAlign.left,
                  style:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.normal)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: pseudo,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Pseudo',
                    hintText: 'frank02'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: nom,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nom & prénom(s)',
                    hintText: 'Frank'),
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
                  'Continuer',
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
    if (pseudo.text.isNotEmpty &&
        nom.text.isNotEmpty) {

      print(telephone);

      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString("contact", telephone);
      await pref.setString("pseudo", pseudo.text);
      await pref.setString("nom", nom.text);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Emails()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Veuillez renseigner tous les champs")));
    }
  }

}
