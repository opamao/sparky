import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:spark/evalutauion/_moi.dart';
import 'package:spark/evalutauion/faison.dart';

class Tierce extends StatefulWidget {
  Tierce({Key key}) : super(key: key);

  @override
  _TiercePage createState() => _TiercePage();
}

class _TiercePage extends State<Tierce> {
  String id = "";

  void getCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString("id");
    });
  }

  String _mySelection = "0";
  List data = []; //edited line
  List<DropdownMenuItem> items = [];

  @override
  void initState() {
    super.initState();
    getCred();
    getSWData();
  }

  Future<String> getSWData() async {
    try {
      const urll = "http://pnn.reliance-service.com/api/personne/1";

      print('ID' + id);

      var res = await http
          .get(Uri.encodeFull(urll), headers: {"Accept": "application/json"});
      var resBody = json.decode(res.body);
      print(resBody);

      data = resBody;
    } catch (err) {
      print(err);
    }
    return "Sucess";
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
              child: Text("Choisissez un(e) proche",
                  textAlign: TextAlign.left,
                  style:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.normal)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: DropdownButtonFormField2(
                decoration: InputDecoration(
                  //Add isDense true and zero Padding.
                  //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  //Add more decoration as you want here
                  //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                ),
                isExpanded: true,
                hint: const Text(
                  'Sélectionnez la personne',
                  style: TextStyle(fontSize: 14),
                ),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black45,
                ),
                iconSize: 30,
                buttonHeight: 60,
                buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                items: data
                    .map((item) => DropdownMenuItem<String>(
                          value: item['nom'],
                          child: Text(
                            item['nom'],
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Sélectionnez la personne.';
                  }
                },
                onChanged: (value) {
                  _mySelection = value;
                  print(value);
                },
                onSaved: (value) {
                  // selectedValue = value.toString();
                },
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
                  SharedPreferences pref =
                  await SharedPreferences.getInstance();
                  await pref.setString("id", id);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Annees()));
                },
                child: const Text(
                  'Commencer le test',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
            ),
            SizedBox(
              height: 200,
            ),
            Container(
              height: 60,
              width: 450,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.black),
                onPressed: () async {
                  SharedPreferences pref =
                  await SharedPreferences.getInstance();
                  await pref.setString("id", id);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Faisons()));
                },
                child: const Text(
                  'Evaluer une nouvelle personne',
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
