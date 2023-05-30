import 'dart:convert';
import 'package:flutter/material.dart';

class Detailss extends StatefulWidget {
  const Detailss({Key key}) : super(key: key);

  @override
  _DetailsPage createState() => _DetailsPage();
}

class _DetailsPage extends State<Detailss> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'MISE AU SEINS PRECOCE',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
          body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child : Column(
                  children: [
                    Container(
                      child: Card(
                        color: Color.fromRGBO(247, 247, 247, 1.0),
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(20),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(''),
                              Text(
                                  "1.	Maman, pour accélérer la montée laiteuse, faciliter l’expulsion du placenta et arrêter les saignements, donne le sein à ton enfant dans l’heure qui suit l’accouchement."),
                              Text(''),
                              Text(
                                  "2.	Maman, donne ton colostrum à ton bébé. Ce premier lait jaunâtre est riche en vitamines ; il protège ton bébé contre las maladies et nettoie son ventre ; ne le jette pas."),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
          ),
        ),
      ),
    );
  }
}
