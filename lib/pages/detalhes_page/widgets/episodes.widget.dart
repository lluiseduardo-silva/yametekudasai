import 'package:flutter/material.dart';

class EpisodesTile extends StatefulWidget {
  final String title;
  final Function onTap;
  final bool watched;

  const EpisodesTile(
      {Key key,
      @required this.title,
      @required this.onTap,
      @required this.watched})
      : super(key: key);
  @override
  _EpisodesTileState createState() => _EpisodesTileState();
}

class _EpisodesTileState extends State<EpisodesTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        trailing: Icon(
          Icons.play_circle_outline,
          color: widget.watched ? Colors.red.shade500 : Colors.green.shade200,
          size: 40,
        ),
        title: Text(
          widget.title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        onTap: widget.onTap);
  }
}
