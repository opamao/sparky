import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:spark/evalutauion/adulte.dart';
import 'package:spark/evalutauion/ans.dart';
import 'package:spark/evalutauion/femme.dart';

class Moi extends StatefulWidget {
  Moi({Key key}) : super(key: key);

  @override
  _MoiPage createState() => _MoiPage();
}

class _MoiPage extends State<Moi> {
  String id, genre, age = "";

  @override
  void initState() {
    super.initState();
    getCred();
  }

  void getCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString("id");
      age = pref.getString("age");
      genre = pref.getString("genre");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4F8),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.asset(
                    'assets/images/types.png',
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
            Padding(
              padding:
                  EdgeInsets.only(left: 0, right: 15.0, top: 0, bottom: 20.0),
              child: Text("Choisissez un type d’évaluation",
                  textAlign: TextAlign.left,
                  style:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.normal)),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
                padding:
                    EdgeInsets.only(left: 0, right: 15.0, top: 0, bottom: 10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor:
                        Color.fromRGBO(239, 239, 239, 0.1), // foreground
                  ),
                  onPressed: () async {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    await pref.setString("id", id);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Adulte()));
                  },
                  child: Text('Adulte 19 ans +'),
                )),
            if (genre == 'Femme')
              Padding(
                  padding: EdgeInsets.only(
                      left: 0, right: 15.0, top: 0, bottom: 10.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor:
                          Color.fromRGBO(239, 239, 239, 0.1), // foreground
                    ),
                    onPressed: () async {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      await pref.setString("id", id);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Femme()));
                    },
                    child: Text('Enceinte ou allaitante'),
                  )),
            if (age == 18)
              Padding(
                  padding: EdgeInsets.only(
                      left: 0, right: 15.0, top: 0, bottom: 10.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor:
                          Color.fromRGBO(239, 239, 239, 0.1), // foreground
                    ),
                    onPressed: () async {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      await pref.setString("id", id);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Ans()));
                    },
                    child: Text('5 - 18 ans'),
                  )),
          ],
        ),
      ),
    );
  }
}
