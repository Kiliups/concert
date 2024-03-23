import 'package:concert_tickets/model/concert.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

class Details extends StatefulWidget {
  const Details({super.key, required this.concert});

  final Concert concert;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.concert.name),
        ),
        body: Column(
          children: [
            Text(widget.concert.name),
            ElevatedButton(
                onPressed: () {
                  OpenFile.open(widget.concert.ticketRef);
                },
                child: Text('Show Ticket'))
          ],
        ));
  }
}
