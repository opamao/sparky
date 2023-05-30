import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:spark/accueil.dart';
import 'package:spark/main.dart';
import 'package:getwidget/getwidget.dart';

class Categories extends StatefulWidget {
  Categories({Key key}) : super(key: key);

  @override
  _CategoriesPage createState() => _CategoriesPage();
}

class _CategoriesPage extends State<Categories> {

  String id, nom, telephone, ville, email, age, genre, maladie = "";

  @override
  void initState() {
    super.initState();
    getCred();
  }

  void getCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString("id");
      nom = pref.getString("nom");
      telephone = pref.getString("telephone");
      ville = pref.getString("ville");
      email = pref.getString("email");
      age = pref.getString("age");
      genre = pref.getString("genre");
      maladie = pref.getString("maladie");
    });
  }

  bool alimentation = false;
  bool bonne = false;
  bool securite = false;
  bool soins = false;

  String stringSoins, stringSecurite, stringBonne, stringAlimentation = "";

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
            const Padding(
              padding:
              EdgeInsets.only(left: 15.0, right: 15.0, top: 0, bottom: 20.0),
              child: Text("Sélectionner une ou plusieurs catégories",
                  textAlign: TextAlign.left,
                  style:
                  TextStyle(fontSize: 25, fontWeight: FontWeight.normal)),
            ),
            SizedBox(
              height: 30,
            ),
            GFCheckboxListTile(
              titleText: 'ALIMENTATION',
              // subTitleText: 'This is a open source UI library',
              avatar: GFAvatar(
                backgroundImage: AssetImage('assets/images/alimentation.png'),
                  shape: GFAvatarShape.standard
              ),
              size: 26,
              activeBgColor: Colors.green,
              type: GFCheckboxType.circle,
              activeIcon: Icon(
                Icons.check,
                size: 16,
                color: Colors.white,
              ),
              onChanged: (value) async {
                setState(() {
                  alimentation = value;
                  stringAlimentation = "alimentation";
                });
              },
              value: alimentation,
              inactiveIcon: null,
            ),
            GFCheckboxListTile(
              titleText: 'BONNES PRATIQUES',
              // subTitleText: 'This is a open source UI library',
              avatar: GFAvatar(
                backgroundImage: AssetImage('assets/images/bonne.png'),
                  shape: GFAvatarShape.standard
              ),
              size: 26,
              activeBgColor: Colors.green,
              type: GFCheckboxType.circle,
              activeIcon: Icon(
                Icons.check,
                size: 16,
                color: Colors.white,
              ),
              onChanged: (value) async {
                setState(() {
                  bonne = value;
                  stringBonne = "bonne";
                });
              },
              value: bonne,
              inactiveIcon: null,
            ),
            GFCheckboxListTile(
              titleText: 'SECURITE',
              // subTitleText: 'This is a open source UI library',
              avatar: GFAvatar(
                backgroundImage: AssetImage('assets/images/securite.png'),
                  shape: GFAvatarShape.standard
              ),
              size: 26,
              activeBgColor: Colors.green,
              type: GFCheckboxType.circle,
              activeIcon: Icon(
                Icons.check,
                size: 16,
                color: Colors.white,
              ),
              onChanged: (value) async {
                setState(() {
                  securite = value;
                  stringSecurite = "securite";
                });
              },
              value: securite,
              inactiveIcon: null,
            ),
            GFCheckboxListTile(
              titleText: 'SOINS ATTENTIFS',
              // subTitleText: 'This is a open source UI library',
              avatar: GFAvatar(
                backgroundImage: AssetImage('assets/images/soins.png'),
                  shape: GFAvatarShape.standard
              ),
              size: 26,
              activeBgColor: Colors.green,
              type: GFCheckboxType.circle,
              activeIcon: Icon(
                Icons.check,
                size: 16,
                color: Colors.white,
              ),
              onChanged: (value) async {
                setState(() {
                  soins = value;
                  stringSoins = "soins";
                });
              },
              value: soins,
              inactiveIcon: null,
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
                  SharedPreferences pref =
                  await SharedPreferences.getInstance();
                  await pref.setString("id", id);
                  await pref.setString("nom", nom);
                  await pref.setString("telephone", telephone);
                  await pref.setString("ville", ville);
                  await pref.setString("email", email);
                  await pref.setString("age", age);
                  await pref.setString("genre", genre);
                  await pref.setString("maladie", maladie);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage()));
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
}
