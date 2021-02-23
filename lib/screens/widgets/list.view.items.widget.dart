import 'package:flutter/material.dart';
import 'package:yamete_kudasai/blocs/entityes/index.dart';

class ListViewAllAnimesItem extends StatefulWidget {
  final Dadoslista dados;
  final Function onTap;

  const ListViewAllAnimesItem(
      {Key key, @required this.dados, @required this.onTap})
      : super(key: key);
  @override
  _ListViewAllAnimesItemState createState() => _ListViewAllAnimesItemState();
}

class _ListViewAllAnimesItemState extends State<ListViewAllAnimesItem> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.dados.title,
        style: TextStyle(
          fontSize: 14,
          letterSpacing: 1.2,
        ),
      ),
      trailing: isLoading
          ? CircularProgressIndicator()
          : Icon(Icons.arrow_forward_sharp),
      onTap: () async {
        setState(() {
          isLoading = !isLoading;
        });
        await widget.onTap();
        setState(() {
          isLoading = !isLoading;
        });
      },
    );
  }
}
