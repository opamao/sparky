import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:spark/evalutauion/moi.dart';
import 'package:spark/evalutauion/tierce.dart';
import 'package:spark/main.dart';
import 'informations.dart';
import 'services.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class ListeCategorie extends StatefulWidget {
  const ListeCategorie({Key key}) : super(key: key);

  @override
  _ListeCategoriePage createState() => _ListeCategoriePage();
}

class _ListeCategoriePage extends State<ListeCategorie> {
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
              'ALIMENTATION DE LA MERE, DU NOURRISSON ET DU JEUNE ENFANT',
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
                                    Text("Mise au sein précoce   ",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.black)),
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
                                    Text("Allaitement exclusif",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.black)),
                                    Text(''),
                                    Text(
                                        "1.	Maman, pour ta santé et celle de ton bébé, donne-lui ton lait rien que ton lait jusqu’à 6 mois. Il contient tout ce qu’il faut y compris l’eau pour bien grandir."),
                                    Text(''),
                                    Text(
                                        "2.	Ton lait contient toute la nourriture et l’eau dont bébé a besoin pendant les six premiers mois de sa vie pour bien grandir."),
                                    Text(''),
                                    Text(
                                        "3.	Quelques soient tes occupations et l’endroit où tu te trouves, ton bébé peut continuer de bénéficier de ton lait."),
                                    Text(''),
                                    Text(
                                        "4.	Maman et papa, regardez, parlez, chantez et caressez votre enfant au cours de la tété pour qu’il se développe mieux."),
                                    Text(''),
                                    Text(
                                        "5.	Maman, mets ton enfant dans la bonne position pendant l’allaitement et assure-toi de la bonne prise du sein."),
                                  ],
                                ),
                              ),
                            ),
                          ),
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
                                    Text("Alimentation de complément",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.black)),
                                    Text(''),
                                    Text(
                                        "1.	Maman, à partir de 6 mois, en plus du lait maternel, donne à ton enfant des aliments locaux des trois groupes adaptés à son âge :	6 mois, bouille épaisse	7 mois, purée	9 mois, aliments en petits morceaux"),
                                    Text(''),
                                    Text(
                                        "2.	Maman, donne à ton enfant au moins trois repas par jour en plus des tétées, il grandira bien, il sera fort, sain et intelligent."),
                                    Text(''),
                                    Text(
                                        "4.	Maman, à partir de 6 mois, tout en poursuivant l’allaitement jusqu’à 24 mois au moins, complète-le avec d’autres aliments adaptés à l’âge de ton enfant. Ainsi, il bénéficiera toujours des avantages de l’allaitement."),
                                  ],
                                ),
                              ),
                            ),
                          ),
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
                                    Text("Alimentation de la mère ",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.black)),
                                    Text(''),
                                    Text(
                                        "1.	Maman, ton enfant tire sa nourriture de ce que tu manges, pour assurer ta santé et celle de ton bébé, mange suffisamment et variés."),
                                    Text(''),
                                    Text(
                                        "2.	Maman, autant que possible, consomme des aliments riches en fer et prends tes comprimés de fer prescrits par l’agent de santé pour le développement de ton bébé et ta propre santé"),
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
