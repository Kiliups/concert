import 'package:concert_tickets/components/imageAppBar.dart';
import 'package:concert_tickets/model/concert.dart';
import 'package:concert_tickets/model/functions.dart';
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
      body: CustomScrollView(
        slivers: [
          ImageAppBar(
              title: Text(
                widget.concert.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              imageUrl: widget.concert.imageUrl),
          SliverFillRemaining(
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 16),
                      Card(
                          child: SizedBox(
                        height: 100,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Date: ',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                convertDateToString(widget.concert.date),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                      Card(
                          child: SizedBox(
                        height: 100,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Location: ',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                widget.concert.location,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      OpenFile.open(widget.concert.ticketRef);
                    },
                    child: const Text('Open Ticket'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
