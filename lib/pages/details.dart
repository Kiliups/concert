import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  const Details({super.key, required this.title});

  final String title;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Text(widget.title),
        ));
  }
}
