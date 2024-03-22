import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:concert_tickets/model/concert.dart';
class ConcertRepo {
  static Future<void> addConcert(Concert concert) async {
    final db = FirebaseFirestore.instance;
    await db.collection('concerts').add(concert.toJson());
  }

  static getConcerts() {
    final db = FirebaseFirestore.instance;
    return db
        .collection('concerts')
        .orderBy('date', descending: false)
        .snapshots();
  }
}
