import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:spark/registre/verification.dart';

class Creation extends StatefulWidget {
  Creation({Key key}) : super(key: key);

  @override
  _CreationPage createState() => _CreationPage();
}

class _CreationPage extends State<Creation> {
  var telephone = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4F8),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Padding(
              padding: EdgeInsets.all(2),
              child: Text("Entrer votre numéro de téléphone",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 0, right: 15.0, top: 0, bottom: 50.0),
              child: Text("Garder un oeil sur vos états nutritionnels",
                  style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: telephone,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '00 00 00 00 00',
                    hintText: '0707070707'),
              ),
            ),
            SizedBox(
              height: 50,
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
                  'Suivant',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: const Color.fromRGBO(255, 0, 0, 1), textStyle: const TextStyle(fontSize: 15)),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("J'ai déjà un compte ? Se connecter"),
            ),
          ],
        ),
      ),
    );
  }

  void signup() async {
    if (telephone.text.isNotEmpty) {

      SharedPreferences pref =
      await SharedPreferences.getInstance();
      await pref.setString("contact", telephone.text);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Verification()));

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Veuillez renseigner votre numéro de téléphone")));
    }
  }
}
