import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spark/categories.dart';
import 'package:spark/register.dart';
import 'package:splashscreen/splashscreen.dart';
import 'accueil.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_walkthrough_screen/flutter_walkthrough_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TestScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TestScreen extends StatelessWidget {
  final List<OnbordingData> list = [
    OnbordingData(
      image: AssetImage(
        "assets/images/bording1.png",
      ),
      titleText: Text(
        "Êtes-vous inquiet de votre état de santé ?  ",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 25, color: Colors.black),
      ),
      descText: Text(""),
    ),
    OnbordingData(
      image: AssetImage("assets/images/bording2.png"),
      titleText: Text(
        "Les changements de votre corps vous inquiète ?",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 25, color: Colors.black),
      ),
      descText: Text(""),
    ),
    OnbordingData(
      image: AssetImage("assets/images/bording3.png"),
      titleText: Text(
        "Prenez davantage soin de vous par des contrôles réguliers",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 25, color: Colors.black),
      ),
      descText: Text(""),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return IntroScreen(
      onbordingDataList: list,
      colors: [
        //list of colors for per pages
        Colors.white,
        Colors.red,
      ],
      pageRoute: MaterialPageRoute(
        builder: (context) => Splash(),
      ),
      nextButton: Text(
        "Suivant",
        style: TextStyle(
          color: Colors.blue,
        ),
      ),
      lastButton: Text(
        "Allez-y",
        style: TextStyle(
          color: Colors.blue,
        ),
      ),
      skipButton: Text(
        "Passer",
        style: TextStyle(
          color: Colors.blue,
        ),
      ),
      selectedDotColor: Colors.orange,
      unSelectdDotColor: Colors.grey,
    );
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds: new Login(),
      backgroundColor: Colors.green,
      title: const Text(
        'PNN SPARKY',
        textScaleFactor: 2,
        style: TextStyle(color: Colors.white, fontSize: 30),
      ),
      image: new Image.asset('assets/images/image.png'),
      loadingText: Text("Patientez"),
      photoSize: 100.0,
      loaderColor: Colors.orange.shade700,
    );
  }
}

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<Login> {
  var telephone = TextEditingController();
  var password = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String val = pref.getString("telephone");
    if (val != null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePage()),
          (route) => false);
    }
  }

  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("SPARKY - PAGE DE CONNEXION")),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0, bottom: 20.0),
              child: Center(
                child: Container(
                  width: 200,
                  height: 5,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(0),
              child: Text("Connectez-vous pour continuer",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 0, right: 15.0, top: 0, bottom: 50.0),
              child: Text("Remplissez les champs ci-dessous",
                  style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: telephone,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Numéro de téléphone',
                    hintText: 'Entrez votre numéro Ex: 0707070707'),
              ),
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
                        setState(() => this._showPassword = !this._showPassword);
                      },
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'Mot de passe',
                    hintText: 'Entrez votre mot de passe'),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Oublie()));
              },
              child: const Text(
                'Mot de passe oublié ?',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              height: 60,
              width: 450,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                onPressed: () async {
                  sign();
                },
                child: const Text(
                  'Je me connecte',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Creation()));
              },
              child: const Text(
                'Pas de compte ? Inscrivez-vous',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 200,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                onPressed: () {
                  // Navigator.push(
                  //     context, MaterialPageRoute(builder: (context) => Oublie()));
                },
                child: const Text(
                  'En continuant, vous acceptez nos termes et conditions, notre politique de confidentialité',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void sign() async {
    if (telephone.text.isNotEmpty && password.text.isNotEmpty) {
      var reponse = await http.post(
          Uri.parse("http://pnn.reliance-service.com/api/login"),
          body: ({'contact': telephone.text, 'password': password.text}));

      if (reponse.statusCode == 200) {
        var resp = json.decode(reponse.body);

        var id = resp["id"].toString();
        var nom = resp["nom"];
        var contact = resp["contact"];
        var ville = resp["ville"];
        var email = resp["email"];
        var age = resp["age"];
        var genre = resp["genre"];
        var maladie = resp["maladie_chronique"];

        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => Accueil()));
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Bienvenu ${nom}")));

        if (ville == null) ville = "ville";
        if (email == null) email = "p@p.com";
        if (age == null) age = "0";
        if (genre == null) genre = "adulte";
        if (maladie == null) maladie = "pas de maladie";

        pageRoute(id, nom, contact, ville, email, age, genre, maladie);
      } else {
        var resp = json.decode(reponse.body);

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("${resp["error"]}")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Tous les champs sont obligatoires")));
    }
  }

  void pageRoute(String id, String nom, String contact, String ville,
      String email, String age, String genre, String maladie) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("id", id);
    await pref.setString("nom", nom);
    await pref.setString("telephone", contact);
    await pref.setString("ville", ville);
    await pref.setString("email", email);
    await pref.setString("age", age);
    await pref.setString("genre", genre);
    await pref.setString("maladie", maladie);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Categories()), (route) => false);

    // Navigator.of(context).pushAndRemoveUntil(
    //     MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
  }
}

class Oublie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("SPARKY - PAGE DE CONNEXION")),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0, bottom: 10.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    child: Image.asset('assets/images/image.png')),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15), //apply padding to all four sides
              child: Text("MOT DE PASSE OUBLIE",
                  style: TextStyle(
                      fontSize: 25,
                      color: Color.fromRGBO(1247, 127, 0, 1),
                      fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 15),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Numéro de téléphone',
                    hintText: 'Entrez votre numéro Ex: 0707070707'),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(247, 127, 0, 1),
                  borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(247, 127, 0, 1),
                ),
                onPressed: () {},
                child: Text(
                  "Retrouver",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            TextButton(
              style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 15),
                  primary: Color.fromRGBO(255, 0, 0, 1)),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Se connecter",
                  style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic)),
            ),
          ],
        ),
      ),
    );
  }
}
