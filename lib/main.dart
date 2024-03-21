import 'package:concert_tickets/components/ticketCard.dart';
import 'package:concert_tickets/pages/add.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Tickets'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: ListView(
            children: const [
              TicketCard(
                  title: 'Lena&Linus',
                  date: '18.03.2024, 20:00 Uhr',
                  location: 'Lindwurmstraße 88, 80337 München',
                  imageUrl:
                      'https://i.scdn.co/image/ab6761610000e5eba5cf52c20d4ff836de483a28'),
              TicketCard(
                  title: 'Kaffkiez',
                  date: '16.03.2024, 20:00 Uhr',
                  location: 'Ostbahnhof, 80337 München',
                  imageUrl:
                      'https://i.scdn.co/image/ab6761610000e5eb1e134894b5dcefed7b7af230'),
              TicketCard(
                  title: 'Lena&Linus',
                  date: '18.03.2024, 20:00 Uhr',
                  location: 'Lindwurmstraße 88, 80337 München',
                  imageUrl:
                      'https://i.scdn.co/image/ab6761610000e5eba5cf52c20d4ff836de483a28'),
              TicketCard(
                  title: 'Lena&Linus',
                  date: '18.03.2024, 20:00 Uhr',
                  location: 'Lindwurmstraße 88, 80337 München',
                  imageUrl:
                      'https://i.scdn.co/image/ab6761610000e5eba5cf52c20d4ff836de483a28'),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //navigate to add page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Add()),
            );
          },
          child: const Icon(Icons.add),
        ));
  }
}
