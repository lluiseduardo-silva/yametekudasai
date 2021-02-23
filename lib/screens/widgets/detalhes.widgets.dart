import 'package:flutter/material.dart';

class ListViewEpisodeTile extends StatefulWidget {
  final String title;
  final Function onTap;

  const ListViewEpisodeTile(
      {Key key, @required this.title, @required this.onTap})
      : super(key: key);
  @override
  _ListViewEpisodeTileState createState() => _ListViewEpisodeTileState();
}

class _ListViewEpisodeTileState extends State<ListViewEpisodeTile> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
        trailing: isLoading
            ? CircularProgressIndicator()
            : Icon(Icons.play_circle_outline, color: Colors.white),
        title: Text(
          widget.title,
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        onTap: () async {
          setState(() {
            isLoading = !isLoading;
          });
          await widget.onTap();
          setState(() {
            isLoading = !isLoading;
          });
        });
  }
}