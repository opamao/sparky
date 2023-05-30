import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:spark/detailcategorie.dart';
import 'package:spark/evalutauion/moi.dart';
import 'package:spark/evalutauion/tierce.dart';
import 'package:spark/listecategorie.dart';
import 'package:spark/main.dart';
import 'informations.dart';
import 'services.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  AppBarAccueil createState() => AppBarAccueil();
}

class AppBarAccueil extends State<HomePage> {
  String id, nom, telephone = "";

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
    });
  }

  int selectedIndex = 0;
  final Widget _accueil = Accueil();
  // Widget _quiz = Quiz();
  final Widget _icm = Icm();
  final Widget _historique = Historique();
  final Widget _profil = Profile();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: this.getBody(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: this.selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            label: "Conseils",
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.quiz),
          //   label: "Sondages",
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note_add),
            label: "Evaluation",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "Historiques",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Profil",
          )
        ],
        onTap: (int index) {
          this.onTapHandler(index);
        },
      ),
    );
  }

  Widget getBody() {
    if (this.selectedIndex == 0) {
      return this._accueil;
    }
    // else if (this.selectedIndex == 1) {
    //   return this._quiz;
    // }
    else if (this.selectedIndex == 1) {
      return this._icm;
    } else if (this.selectedIndex == 2) {
      return this._historique;
    } else {
      return this._profil;
    }
  }

  void onTapHandler(int index) {
    this.setState(() {
      this.selectedIndex = index;
    });
  }
}

class Accueil extends StatefulWidget {
  const Accueil({Key key}) : super(key: key);

  @override
  _AccueilPage createState() => _AccueilPage();
}

class _AccueilPage extends State<Accueil> {

  final List<int> numbers = [
    1,
    2, 3, 4];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.92,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 6,
                        color: Color(0x4B1A1F24),
                        offset: Offset(0, 2),
                      )
                    ],
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(255, 255, 255, 1.0),
                        Color.fromRGBO(255, 255, 255, 1.0)
                      ],
                      stops: [0, 1],
                      begin: AlignmentDirectional(0.94, -1),
                      end: AlignmentDirectional(-0.94, 1),
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 16),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              'assets/images/image.png',
                              width: 100,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              width: 80,
                              height: 80,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                'assets/images/theoo.jpg',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: Color(0x39000000),
                        offset: Offset(0, -1),
                      )
                    ],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Catégories',
                              style: TextStyle(
                                  color: Color(0xFF090F13),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: numbers.length, itemBuilder: (context, index) {
                          return Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: GestureDetector(
                              onTap: ()  async {
                                SharedPreferences pref =
                                await SharedPreferences.getInstance();
                                await pref.setString("id", "1");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ListeCategorie()));
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(80),
                                ),
                                color: Color.fromRGBO(245, 245, 245, 0.1),
                                child: Container(
                                  child: Center(
                                      child: Text("Alimentation de la Mère",
                                        style: TextStyle(color: Colors.black, fontSize: 12.0),
                                      )
                                  ),
                                ),
                              ),
                            )
                          );
                        }),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 25.0),
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: numbers.length, itemBuilder: (context, index) {
                          return Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                              child: GestureDetector(
                                onTap: ()  async {
                                  SharedPreferences pref =
                                  await SharedPreferences.getInstance();
                                  await pref.setString("id", "1");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Detailss()));
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  color: Colors.blueGrey.shade100,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage("assets/images/fond.png"),
                                        fit: BoxFit.fitWidth,
                                        alignment: Alignment.topCenter,
                                      ),
                                    ),
                                    child: Center(
                                        child: Text("Mise au sein précoce",
                                          style: TextStyle(color: Colors.white, fontSize: 18),
                                        )
                                    ),
                                  ),
                                ),
                              )
                          );
                        }),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 12),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Activité autour de vous',
                              style: TextStyle(
                                  color: Color(0xFF090F13),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 40.0),
                        height: 200,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: numbers.length, itemBuilder: (context, index) {
                          return Container(
                            width: 300,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              color: Colors.grey.shade400,
                              child: Container(
                                child: Center(
                                    child: Text("Volontariat PNN",
                                      style: TextStyle(color: Colors.black, fontSize: 12.0),
                                    )
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Icm extends StatefulWidget {
  const Icm({Key key}) : super(key: key);

  @override
  _IcmPage createState() => _IcmPage();
}

class _IcmPage extends State<Icm> {
  bool isVisible = true;

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

  String choice, choice_ = '';

  int _value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4F8),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 100,
            ),
            const Padding(
              padding:
                  EdgeInsets.only(left: 0, right: 15.0, top: 0, bottom: 20.0),
              child: Text("Qui souhaitez-vous évaluer ?",
                  textAlign: TextAlign.left,
                  style:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.normal)),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 0, right: 15.0, top: 0, bottom: 20.0),
              child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => setState(() => _value = 0),
                    child: Container(
                      height: 100,
                      width: 150,
                      color: _value == 0 ? Colors.green : Colors.grey,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Moi-même',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            )
                          ]),
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => setState(() => _value = 1),
                    child: Container(
                      height: 100,
                      width: 150,
                      color: _value == 1 ? Colors.green : Colors.grey,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Text(
                              'Tierce personne',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            )
                          ]),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 15, right: 15.0, top: 0, bottom: 20.0),
              child: Container(
                height: 60,
                width: 450,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_value == 0) {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      await pref.setString("id", id);
                      await pref.setString("genre", genre);
                      await pref.setString("age", age);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Moi()));
                    } else {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      await pref.setString("id", id);
                      await pref.setString("genre", genre);
                      await pref.setString("age", age);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Tierce()));
                    }
                  },
                  child: const Text(
                    'Commencer le test',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Historique extends StatefulWidget {
  const Historique({Key key}) : super(key: key);

  @override
  _HistoriquePage createState() => _HistoriquePage();
}

class _HistoriquePage extends State<Historique> with SingleTickerProviderStateMixin {
  String id = "";
  TabController _tabController;

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
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    getCred();
    getSWData();
  }

  Future<List> _loadData() async {
    List posts = [];
    try {
      // This is an open REST API endpoint for testing purposes
      const API = 'http://pnn.reliance-service.com/api/historiques/';

      final http.Response response = await http.get(Uri.parse(API + id));
      posts = json.decode(response.body);
    } catch (err) {
      print(err);
    }

    return posts;
  }

  Future<List> _loadDataTierce() async {
    List posts = [];
    try {
      // This is an open REST API endpoint for testing purposes
      const API = 'http://pnn.reliance-service.com/api/historiquestierce/';

      final http.Response response = await http.get(Uri.parse(API + id));
      posts = json.decode(response.body);
    } catch (err) {
      print(err);
    }

    return posts;
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

  final TextEditingController _dateDebut = TextEditingController();
  final TextEditingController _dateFin = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  String selectedValue;

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
              'Historique',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // give the tab bar a height [can change hheight to preferred height]
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(
                      6.0,
                    ),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    // give the indicator a decoration (color and border radius)
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                      color: Color.fromRGBO(68, 133, 198, 1),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    tabs: [
                      // first tab [you can add an icon using the icon property]
                      Tab(
                        text: 'Personnel',
                      ),

                      // second tab [you can add an icon using the icon property]
                      Tab(
                        text: 'Tierce personne',
                      ),
                    ],
                  ),
                ),
                // tab bar view here
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Column(children: <Widget>[
                        Expanded(
                          // flex: 2,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    child: SizedBox(
                                        width: 180,
                                        child: TextField(
                                          controller: _dateDebut,
                                          decoration: const InputDecoration(
                                              icon: Icon(
                                                  Icons.calendar_today_rounded),
                                              labelText: "Début"),
                                          onTap: () async {
                                            DateTime pickeddate =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(2000),
                                                    lastDate: DateTime(2101));

                                            if (pickeddate != null) {
                                              setState(() {
                                                _dateDebut.text =
                                                    DateFormat('yyyy-MM-dd')
                                                        .format(pickeddate);
                                              });
                                            }
                                          },
                                        ))),
                                Container(
                                    child: SizedBox(
                                        width: 180,
                                        child: TextField(
                                          controller: _dateFin,
                                          decoration: const InputDecoration(
                                              icon: Icon(
                                                  Icons.calendar_today_rounded),
                                              labelText: "Fin"),
                                          onTap: () async {
                                            DateTime pickeddatef =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(2000),
                                                    lastDate: DateTime(2101));

                                            if (pickeddatef != null) {
                                              setState(() {
                                                _dateFin.text =
                                                    DateFormat('yyyy-MM-dd')
                                                        .format(pickeddatef);
                                              });
                                            }
                                          },
                                        ))),
                                Container(
                                  color: Colors.blueAccent,
                                  child: IconButton(
                                    color: Colors.white,
                                    icon: const Icon(Icons.search_off_outlined),
                                    onPressed: () {
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ]),
                        ),
                        Expanded(
                            flex: 8,
                            child: Container(
                              child: FutureBuilder(
                                  future: _loadData(),
                                  builder: (BuildContext ctx,
                                          AsyncSnapshot<List> snapshot) =>
                                      snapshot.hasData
                                          ? ListView.builder(
                                              itemCount: snapshot.data.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                          index) =>
                                                      Card(
                                                color: Color.fromRGBO(
                                                    247, 247, 247, 1.0),
                                                margin:
                                                    const EdgeInsets.all(10),
                                                child: ListTile(
                                                  contentPadding:
                                                      const EdgeInsets.all(20),
                                                  title: Text("Evaluation du " +
                                                      snapshot.data[index]
                                                          ['date_evaluation']),
                                                  subtitle: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(''),
                                                      Text('Poids : ' +
                                                          snapshot.data[index]
                                                                  ['poids']
                                                              .toString() +
                                                          ' kg' +
                                                          '    Taille : ' +
                                                          snapshot.data[index]
                                                                  ['taille']
                                                              .toString() +
                                                          ' cm' +
                                                          '   ICM : ' +
                                                          snapshot.data[index]
                                                                  ['valeur']
                                                              .toString()),
                                                      Text(''),
                                                      Text('Conclusion'),
                                                      Text(snapshot.data[index]
                                                              ['conseil']
                                                          .toString()),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )),
                            ))
                      ]),
                      Column(children: <Widget>[
                        const SizedBox(height: 15),
                        Expanded(
                          child: Container(
                              child: SizedBox(
                            width: 410,
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
                              buttonPadding:
                                  const EdgeInsets.only(left: 20, right: 10),
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
                          )),
                        ),
                        Expanded(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    child: SizedBox(
                                        width: 180,
                                        child: TextField(
                                          controller: _dateDebut,
                                          decoration: const InputDecoration(
                                              icon: Icon(
                                                  Icons.calendar_today_rounded),
                                              labelText: "Début"),
                                          onTap: () async {
                                            DateTime pickeddate =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(2000),
                                                    lastDate: DateTime(2101));

                                            if (pickeddate != null) {
                                              setState(() {
                                                _dateDebut.text =
                                                    DateFormat('yyyy-MM-dd')
                                                        .format(pickeddate);
                                              });
                                            }
                                          },
                                        ))),
                                Container(
                                    child: SizedBox(
                                        width: 180,
                                        child: TextField(
                                          controller: _dateFin,
                                          decoration: const InputDecoration(
                                              icon: Icon(
                                                  Icons.calendar_today_rounded),
                                              labelText: "Fin"),
                                          onTap: () async {
                                            DateTime pickeddatef =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(2000),
                                                    lastDate: DateTime(2101));

                                            if (pickeddatef != null) {
                                              setState(() {
                                                _dateFin.text =
                                                    DateFormat('yyyy-MM-dd')
                                                        .format(pickeddatef);
                                              });
                                            }
                                          },
                                        ))),
                                Container(
                                  color: Colors.blueAccent,
                                  child: IconButton(
                                    color: Colors.white,
                                    icon: const Icon(Icons.search_off_outlined),
                                    onPressed: () {
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ]),
                        ),
                        Expanded(
                            flex: 8,
                            child: Container(
                              child: FutureBuilder(
                                  future: _loadDataTierce(),
                                  builder: (BuildContext ctx,
                                          AsyncSnapshot<List> snapshot) =>
                                      snapshot.hasData
                                          ? ListView.builder(
                                              itemCount: snapshot.data.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                          index) =>
                                                      Card(
                                                color: Color.fromRGBO(
                                                    247, 247, 247, 1.0),
                                                margin:
                                                    const EdgeInsets.all(10),
                                                child: ListTile(
                                                  contentPadding:
                                                      const EdgeInsets.all(20),
                                                  title: Text(snapshot
                                                      .data[index]['nom']),
                                                  subtitle: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(''),
                                                      Text(
                                                          "Evaluation du " +
                                                              snapshot.data[
                                                                      index][
                                                                  'date_evaluation'],
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: Colors
                                                                  .black)),
                                                      Text(''),
                                                      Text('Poids : ' +
                                                          snapshot.data[index]
                                                                  ['poids']
                                                              .toString() +
                                                          ' kg' +
                                                          '    Taille : ' +
                                                          snapshot.data[index]
                                                                  ['taille']
                                                              .toString() +
                                                          ' cm' +
                                                          '   Age : ' +
                                                          snapshot.data[index]
                                                                  ['age']
                                                              .toString()),
                                                      Text(
                                                          'ICM : ' +
                                                              snapshot
                                                                  .data[index]
                                                                      ['valeur']
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: Colors
                                                                  .black)),
                                                      Text(''),
                                                      Text('Conclusion'),
                                                      Text(snapshot.data[index]
                                                              ['conseil']
                                                          .toString()),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )),
                            ))
                      ]),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  _ProfilePage createState() => _ProfilePage();
}

class _ProfilePage extends State<Profile> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F4F8),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 270,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                // Align(
                                //   alignment: AlignmentDirectional(0, 0),
                                //   child: Image.asset(
                                //     'assets/images/image.png',
                                //     width: MediaQuery.of(context).size.width,
                                //     height: 150,
                                //     fit: BoxFit.cover,
                                //   ),
                                // ),
                                Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 70, 0, 0),
                                    child: Container(
                                      width: 80,
                                      height: 80,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.asset(
                                        'assets/images/image.png',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                            child: Text(
                              '${nom}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: ElevatedButton.icon(
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
                                        builder: (context) => Informations()));
                              },
                              label: Text(
                                "Modifier",
                                style: TextStyle(color: Colors.black),
                              ),
                              icon: Icon(
                                Icons.edit,
                                color: Colors.black,
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
              clipBehavior: Clip.antiAlias,
              color: Colors.white,
              elevation: 5.0,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 22.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "${telephone}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          // SizedBox(
                          //   height: 5.0,
                          // ),
                          // Text(
                          //   "5200",
                          //   style: TextStyle(
                          //     fontSize: 20.0,
                          //     color: Colors.pinkAccent,
                          //   ),
                          // )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "${genre}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "${age} ans",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 12, 0, 12),
                  child: Text(
                    'PARAMETRE COMPTE',
                    style: TextStyle(
                        color: Color(0xFF090F13),
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: Color(0xFFEFEFEF),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                            // child: widget.leftIcon,
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                            child: Text(
                              'Mes notifications',
                              style: TextStyle(
                                  color: Color(0xFF090F13),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: AlignmentDirectional(0.9, 0),
                              // child: widget.listIcon,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: Color(0xFFEFEFEF),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                            // child: widget.leftIcon,
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                            child: Text(
                              'Vidéos',
                              style: TextStyle(
                                  color: Color(0xFF090F13),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: AlignmentDirectional(0.9, 0),
                              // child: widget.listIcon,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: Color(0xFFEFEFEF),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                            // child: widget.leftIcon,
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                            child: GestureDetector(
                              onTap: () async {
                                setState(() async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Services()));
                                });
                              },
                              child: const Text(
                                'Termes & Conditions',
                                style: TextStyle(
                                    color: Color(0xFF090F13),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                          const Expanded(
                            child: Align(
                              alignment: AlignmentDirectional(0.9, 0),
                              // child: widget.listIcon,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 20),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      await pref.clear();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => Login()),
                          (route) => false);
                    },
                    icon: const Icon(Icons.lock, color: Colors.black),
                    label: const Text('Déconnexion',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.normal)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(252, 222, 222, 1),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
