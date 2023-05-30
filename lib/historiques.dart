// To parse this JSON data, do
//
//     final historiques = historiquesFromJson(jsonString);

import 'dart:convert';

List<Historiques> historiquesFromJson(String str) => List<Historiques>.from(
    json.decode(str).map((x) => Historiques.fromJson(x)));

String historiquesToJson(List<Historiques> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Historiques {
  Historiques({
    this.id,
    this.poids,
    this.taille,
    this.nom,
    this.valeur,
    this.maladie,
    this.dateNaissance,
  });

  int id;
  int poids;
  int taille;
  String nom;
  double valeur;
  dynamic maladie;
  dynamic dateNaissance;

  factory Historiques.fromJson(Map<String, dynamic> json) => Historiques(
        id: json["id"],
        poids: json["poids"],
        taille: json["taille"],
        nom: json["nom"],
        valeur: json["valeur"].toDouble(),
        maladie: json["maladie"],
        dateNaissance: json["date_naissance"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "poids": poids,
        "taille": taille,
        "nom": nom,
        "valeur": valeur,
        "maladie": maladie,
        "date_naissance": dateNaissance,
      };
}
