import 'dart:developer';

import 'package:concert_tickets/model/concertRepo.dart';
import 'package:concert_tickets/model/functions.dart';
import 'package:flutter/material.dart';

import '../model/concert.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  String _name = '';
  DateTime? _date;
  String _location = '';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.add_card,
                  size: 56,
                ),
                Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: const Text(
                      'Add a Concert Ticket',
                      style: TextStyle(fontSize: 24),
                    )),
                /*Container(
                  margin: const EdgeInsets.only(top: 16),
                  child: const Center(
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4))),
                          child: Center(
                            child: Icon(Icons.add_a_photo),
                          )),
                    ),
                  ),
                ),*/
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: TextField(
                    controller: _nameController,
                    onChanged: (String value) {
                      setState(() {
                        _name = value;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      hintText: 'Concert Name',
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: GestureDetector(
                      onTap: () async {
                        final DateTime? date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate:
                                DateTime.now().add(const Duration(days: 365)));
                        if (date != null) {
                          final TimeOfDay? time = await showTimePicker(
                              context: context, initialTime: TimeOfDay.now());
                          if (time != null) {
                            final DateTime dateTime = DateTime(date.year,
                                date.month, date.day, time.hour, time.minute);
                            setState(() {
                              _date = dateTime;
                            });
                          }
                        }
                      },
                      child: TextField(
                        controller: TextEditingController(
                            text: _date == null
                                ? ''
                                : convertDateToString(_date!)),
                        enabled: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          hintText: 'Date',
                        ),
                      )),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: TextField(
                    controller: _locationController,
                    onChanged: (String value) {
                      setState(() {
                        _location = value;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      hintText: 'Location',
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  height: 140,
                  width: MediaQuery.of(context).size.width,
                  child: const DecoratedBox(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.upload),
                            Text('Upload Ticket'),
                          ],
                        ),
                      )),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_name.isNotEmpty &&
                        _location.isNotEmpty &&
                        _date != null) {
                      Concert concert = Concert(
                          _name,
                          _date!,
                          _location,
                          'test',
                          'https://i.scdn.co/image/ab6761610000e5eba5cf52c20d4ff836de483a28');
                      await ConcertRepo.addConcert(concert);
                      Navigator.pop(context, concert);
                    } else {
                      log('Please fill in all fields');
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
