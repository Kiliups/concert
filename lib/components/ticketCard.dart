import 'package:concert_tickets/pages/details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TicketCard extends StatefulWidget {
  const TicketCard(
      {super.key,
      required this.title,
      required this.date,
      required this.location,
      required this.imageUrl});

  final String title;
  final String date;
  final String location;
  final String imageUrl;

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
          MaterialPageRoute(builder: (context) => Details(title: widget.title)),
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
                    widget.imageUrl,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.date, //'18.03.2024, 20:00 Uhr',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      widget.location, //'Lindwurmstraße 88, 80337 München',
                      overflow: TextOverflow.clip,
                      maxLines: 3,
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
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
