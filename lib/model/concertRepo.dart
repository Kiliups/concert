import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:concert_tickets/model/concert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final auth = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;
final storage = FirebaseStorage.instance;

class ConcertRepo {
  static Future<void> addConcert(String name, DateTime date, String location,
      File ticket, String? imageUrl) async {
    Concert concert = Concert(
        name, date, location, ticket.path, imageUrl, auth.currentUser?.uid);
    await firestore.collection('concerts').add(concert.toJson());
  }

  static getConcerts() {
    return firestore
        .collection('concerts')
        .where('userId', isEqualTo: auth.currentUser?.uid)
        .orderBy('date', descending: false)
        .snapshots();
  }

  static deleteConcert(String id) async {
    await firestore.collection('concerts').doc(id).delete();
  }

  static Future<void> addTicket(File file, String ticketRef) async {
    final ref = storage.ref().child(ticketRef);
    await ref.putFile(file);
  }
}
