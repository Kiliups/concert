import 'package:cloud_firestore/cloud_firestore.dart';

class Concert {
  String? id;
  String name;
  DateTime date;
  String location;
  String ticketRef;
  String imageUrl;
  String? userId;

  Concert(this.name, this.date, this.location,this.ticketRef, this.imageUrl, this.userId);

  factory Concert.fromJson(Map<String, dynamic> json) {
    return Concert(json['name'], (json['date']).toDate(), json['location'],json['ticketRef'],
        json['imageUrl'], json['userId']);
  }

  toJson() {
    return {
      'name': name,
      'date': Timestamp.fromDate(date!),
      'location': location,
      'ticketRef': ticketRef,
      'imageUrl': imageUrl,
      'userId': userId,
    };
  }
}
