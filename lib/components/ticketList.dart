import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:concert_tickets/components/ticketCard.dart';
import 'package:flutter/material.dart';

import '../model/concert.dart';
import '../model/concertRepo.dart';

class TicketList extends StatelessWidget {
  const TicketList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: StreamBuilder(
          stream: ConcertRepo.getConcerts(),
          builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.data == null) {
              return const SizedBox();
            }

            if (snapshot.data!.docs.isEmpty) {
              return const SizedBox(
                child:
                    Center(child: Text("You haven't booked any appointment!")),
              );
            }

            if (snapshot.hasData) {
              List<Concert> concerts = [];

              for (var doc in snapshot.data!.docs) {
                final concert =
                    Concert.fromJson(doc.data() as Map<String, dynamic>);

                concerts.add(concert);
              }

              return ListView.builder(
                itemCount: concerts.length,
                itemBuilder: (context, index) {
                  return TicketCard(concert: concerts[index]);
                },
              );
            }

            return const SizedBox();
          })),
    );
  }
}
