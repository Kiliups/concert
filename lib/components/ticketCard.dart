import 'package:concert_tickets/model/concert.dart';
import 'package:concert_tickets/model/functions.dart';
import 'package:concert_tickets/pages/details.dart';
import 'package:flutter/material.dart';

class TicketCard extends StatefulWidget {
  const TicketCard({super.key, required this.concert});

  final Concert concert;

  @override
  State<TicketCard> createState() => _TicketCardState();
}

class _TicketCardState extends State<TicketCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Details(title: widget.concert.name)),
        );
      },
      child: Card(
        child: SizedBox(
          height: 120,
          child: Center(
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Image.network(
                    widget.concert.imageUrl,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.concert.name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      convertDateToString(widget.concert.date),
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      widget.concert.location.toString(),
                      overflow: TextOverflow.clip,
                      maxLines: 3,
                      style: const TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 14),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
