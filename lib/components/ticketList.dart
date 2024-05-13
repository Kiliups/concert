import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:concert_tickets/model/concertRepo.dart';
import 'package:flutter/material.dart';
import 'package:concert_tickets/components/ticketCard.dart';
import '../model/concert.dart';

class ConcertComponent extends StatelessWidget {
  const ConcertComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TicketList(concertStream: ConcertRepo.getFutureConcerts()),
          const PastConcertList(),
        ],
      ),
    );
  }
}

class TicketList extends StatelessWidget {
  final Stream<QuerySnapshot> concertStream;

  const TicketList({super.key, required this.concertStream});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: concertStream,
        builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data == null) {
            return const Center(child: Text("No data found"));
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(
                child: Text("You haven't added any Tickts yet!"));
          }

          if (snapshot.hasData) {
            List<Concert> concerts = [];

            for (var doc in snapshot.data!.docs) {
              final concert =
                  Concert.fromJson(doc.data() as Map<String, dynamic>);
              concert.id = doc.id;

              concerts.add(concert);
            }

            return Column(
              children: [
                for (var concert in concerts)
                  TicketCard(
                    concert: concert,
                  )
              ],
            );
          }

          return const SizedBox();
        }));
  }
}

class PastConcertList extends StatefulWidget {
  const PastConcertList({super.key});

  @override
  State<PastConcertList> createState() => _PastConcertListState();
}

class _PastConcertListState extends State<PastConcertList> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: const Text(
          'Past Concerts',
          style: TextStyle(fontSize: 18),
        ),
        onExpansionChanged: (expanded) {
          setState(() {
            _isExpanded = expanded;
          });
        },
        children: <Widget>[
          if (_isExpanded)
            TicketList(concertStream: ConcertRepo.getPastConcerts()),
        ],
      ),
    );
  }
}
