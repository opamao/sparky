import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:spark/evalutauion/naissance.dart';

class Faisons extends StatefulWidget {
  Faisons({Key key}) : super(key: key);

  @override
  _FaisonsPage createState() => _FaisonsPage();
}

class _FaisonsPage extends State<Faisons> {
  var telephone = TextEditingController();

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
                controller: telephone,
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
                controller: telephone,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Pénom',
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Naissance()));
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
}
