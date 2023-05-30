import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:spark/registre/mieux.dart';

class Passes extends StatefulWidget {
  Passes({Key key}) : super(key: key);

  @override
  _PassesPage createState() => _PassesPage();
}

class _PassesPage extends State<Passes> {
  var password = TextEditingController();

  bool showvalue = false;
  bool _showPassword = false;

  String telephone, email, pseudo, nom = "";

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
              padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.asset(
                    'assets/images/code.png',
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
              child: Text("Et votre mot de passe ?",
                  textAlign: TextAlign.left,
                  style:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.normal)),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: password,
                obscureText: !this._showPassword,
                decoration: InputDecoration(
                    // prefixIcon: Icon(Icons.security),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: this._showPassword ? Colors.green : Colors.grey,
                      ),
                      onPressed: () {
                        setState(
                            () => this._showPassword = !this._showPassword);
                      },
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'Mot de passe',
                    hintText: 'Entrez votre mot de passe'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                '8 caract. min.  Un chiffre   Une majuscule   Une minuscule',
                style: TextStyle(
                    fontSize: 15,
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
    if (password.text.isNotEmpty) {

      print(telephone);

      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString("contact", telephone);
      await pref.setString("email", email);
      await pref.setString("pseudo", pseudo);
      await pref.setString("nom", nom);
      await pref.setString("password", password.text);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Mieux()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Veuillez renseigner mot de passe")));
    }
  }
}
