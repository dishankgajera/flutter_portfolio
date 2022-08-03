// To parse this JSON data, do
//
//     final mok = mokFromJson(jsonString);

import 'dart:convert';

Mok mokFromJson(String str) => Mok.fromJson(json.decode(str));

String mokToJson(Mok data) => json.encode(data.toJson());

class Mok {
  Mok({
    this.name,
    this.height,
    this.mass,
    this.hairColor,
    this.skinColor,
    this.eyeColor,
    this.birthYear,
    this.gender,
    this.homeworld,
    this.films,
    this.species,
    this.vehicles,
    this.starships,
    this.created,
    this.edited,
    this.url,
  });

  String ?name;
  String ?height;
  String ?mass;
  String? hairColor;
  String ?skinColor;
  String ?eyeColor;
  String ?birthYear;
  String ?gender;
  String ?homeworld;
  List<String>? films;
  List<dynamic>? species;
  List<String>? vehicles;
  List<String> ?starships;
  DateTime ?created;
  DateTime? edited;
  String? url;

  factory Mok.fromJson(Map<String, dynamic> json) => Mok(
    name: json["name"] == null ? null : json["name"],
    height: json["height"] == null ? null : json["height"],
    mass: json["mass"] == null ? null : json["mass"],
    hairColor: json["hair_color"] == null ? null : json["hair_color"],
    skinColor: json["skin_color"] == null ? null : json["skin_color"],
    eyeColor: json["eye_color"] == null ? null : json["eye_color"],
    birthYear: json["birth_year"] == null ? null : json["birth_year"],
    gender: json["gender"] == null ? null : json["gender"],
    homeworld: json["homeworld"] == null ? null : json["homeworld"],
    films: json["films"] == null ? null : List<String>.from(json["films"].map((x) => x)),
    species: json["species"] == null ? null : List<dynamic>.from(json["species"].map((x) => x)),
    vehicles: json["vehicles"] == null ? null : List<String>.from(json["vehicles"].map((x) => x)),
    starships: json["starships"] == null ? null : List<String>.from(json["starships"].map((x) => x)),
    created: json["created"] == null ? null : DateTime.parse(json["created"]),
    edited: json["edited"] == null ? null : DateTime.parse(json["edited"]),
    url: json["url"] == null ? null : json["url"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "height": height == null ? null : height,
    "mass": mass == null ? null : mass,
    "hair_color": hairColor == null ? null : hairColor,
    "skin_color": skinColor == null ? null : skinColor,
    "eye_color": eyeColor == null ? null : eyeColor,
    "birth_year": birthYear == null ? null : birthYear,
    "gender": gender == null ? null : gender,
    "homeworld": homeworld == null ? null : homeworld,
    "films": films == null ? null : List<dynamic>.from(films!.map((x) => x)),
    "species": species == null ? null : List<dynamic>.from(species!.map((x) => x)),
    "vehicles": vehicles == null ? null : List<dynamic>.from(vehicles!.map((x) => x)),
    "starships": starships == null ? null : List<dynamic>.from(starships!.map((x) => x)),
    "created": created == null ? null : created!.toIso8601String(),
    "edited": edited == null ? null : edited!.toIso8601String(),
    "url": url == null ? null : url,
  };
}
