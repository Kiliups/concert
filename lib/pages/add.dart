import 'dart:io';

import 'package:concert_tickets/model/concertRepo.dart';
import 'package:concert_tickets/model/functions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  String _name = '';
  DateTime? _date;
  String _location = '';
  File? _ticket;
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
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
                                lastDate: DateTime.now()
                                    .add(const Duration(days: 365)));
                            if (date != null) {
                              final TimeOfDay? time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now());
                              if (time != null) {
                                final DateTime dateTime = DateTime(
                                    date.year,
                                    date.month,
                                    date.day,
                                    time.hour,
                                    time.minute);
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
                    GestureDetector(
                      onTap: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles();
                        if (result != null) {
                          setState(() {
                            _ticket = File(result.files.single.path!);
                          });
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 8),
                        height: 140,
                        width: MediaQuery.of(context).size.width,
                        child: DecoratedBox(
                            decoration: const BoxDecoration(
                                color: Colors.grey,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            child: Center(
                              child: _ticket == null
                                  ? const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.upload),
                                        Text('Add Ticket'),
                                      ],
                                    )
                                  : Text(_ticket!.path.split('/').last,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: const TextStyle(fontSize: 16)),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
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
                        _date != null &&
                        _ticket != null) {
                      ConcertRepo.addConcert(_name, _date!, _location, _ticket!,
                              "https://i.scdn.co/image/ab67616d00001e0254f676973b350db47b339925")
                          .then((value) => {
                                //added concert
                                Navigator.pop(context)
                              })
                          .catchError((error) => {
                                //error
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("An error occurred"),
                                    behavior: SnackBarBehavior.floating,
                                    duration: Duration(seconds: 1),
                                  ),
                                )
                              });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fill all fields'),
                          behavior: SnackBarBehavior.floating,
                          duration: Duration(seconds: 1),
                        ),
                      );
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
