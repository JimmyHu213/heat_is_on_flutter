import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Card {
  final String id;
  final String type;
  final int cost;
  final int years;
  final int nature;
  final int economy;
  final int society;
  final int health;
  final String? imageUrl;

  Card({
    this.imageUrl,
    required this.id,
    required this.type,
    required this.cost,
    required this.years,
    required this.nature,
    required this.economy,
    required this.society,
    required this.health,
  });

  //add fromJson and toJson methods
  factory Card.fromJson(Map<String, dynamic> json) {
    return Card(
      id: json['id'],
      type: json['type'],
      cost: json['cost'],
      years: json['years'],
      nature: json['nature'],
      economy: json['economy'],
      society: json['society'],
      health: json['health'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'cost': cost,
      'years': years,
      'nature': nature,
      'economy': economy,
      'society': society,
      'health': health,
    };
  }
}

//add a cardModel extended with changeNotifier to connect with the firebase
//use fromJAsaon and toJson methods to convert the data and use Future

class CardModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _cardCollection =
      FirebaseFirestore.instance.collection('cards');
  List<Card> _cards = [];

  List<Card> get cards => _cards;

  CardModel() {
    fetchCards();
  }

  Future<void> fetchCards() async {
    final QuerySnapshot snapshot = await _cardCollection.get();
    _cards = snapshot.docs.map((DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Card.fromJson(data);
    }).toList();
    notifyListeners();
  }

  Future<void> addCard(Card card) async {
    await _cardCollection.add(card.toJson());
    await fetchCards();
    notifyListeners();
  }

  Future<void> updateCard(Card card) async {
    await _cardCollection.doc(card.id).update(card.toJson());
    await fetchCards();
    notifyListeners();
  }

  Future<void> deleteCard(Card card) async {
    await _cardCollection.doc(card.id).delete();
    await fetchCards();
    notifyListeners();
  }
}
