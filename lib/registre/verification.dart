import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:spark/registre/connaissance.dart';

class Verification extends StatefulWidget {
  Verification({Key key}) : super(key: key);

  @override
  _VerificationPage createState() => _VerificationPage();
}

class _VerificationPage extends State<Verification> {
  var code1 = TextEditingController();
  var code2 = TextEditingController();
  var code3 = TextEditingController();
  var code4 = TextEditingController();
  var code5 = TextEditingController();
  var code6 = TextEditingController();

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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Padding(
              padding: EdgeInsets.all(2),
              child: Text("Vérification du numéro de téléphone",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 0, right: 15.0, top: 0, bottom: 50.0),
              child: Text(
                  "Entrer le code à 6 chiffres que vous recevrez par sms sur votre numéro",
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 68,
                  width: 64,
                  child: TextField(
                    controller: code1,
                    onChanged: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                    decoration: const InputDecoration(hintText: "0"),
                    style: Theme.of(context).textTheme.headline6,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
                SizedBox(
                  height: 68,
                  width: 64,
                  child: TextField(
                    controller: code2,
                    onChanged: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                    decoration: const InputDecoration(hintText: "0"),
                    style: Theme.of(context).textTheme.headline6,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
                SizedBox(
                  height: 68,
                  width: 64,
                  child: TextField(
                    controller: code3,
                    onChanged: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                    decoration: const InputDecoration(hintText: "0"),
                    style: Theme.of(context).textTheme.headline6,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
                SizedBox(
                  height: 68,
                  width: 64,
                  child: TextField(
                    controller: code4,
                    onChanged: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                    decoration: const InputDecoration(hintText: "0"),
                    style: Theme.of(context).textTheme.headline6,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
                SizedBox(
                  height: 68,
                  width: 64,
                  child: TextField(
                    controller: code5,
                    onChanged: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                    decoration: const InputDecoration(hintText: "0"),
                    style: Theme.of(context).textTheme.headline6,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
                SizedBox(
                  height: 68,
                  width: 64,
                  child: TextField(
                    controller: code6,
                    onChanged: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                    decoration: const InputDecoration(hintText: "0"),
                    style: Theme.of(context).textTheme.headline6,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Vous n’avez pas reçu de code ? Renvoyez',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.left,
              ),
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
                  'Vérification',
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
    if (code1.text.isNotEmpty &&
        code2.text.isNotEmpty &&
        code3.text.isNotEmpty &&
        code4.text.isNotEmpty &&
        code5.text.isNotEmpty &&
        code6.text.isNotEmpty) {

      print(telephone);

      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString("contact", telephone);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Connaissance()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Veuillez saisir 6 chiffres aléatoires")));
    }
  }
}
