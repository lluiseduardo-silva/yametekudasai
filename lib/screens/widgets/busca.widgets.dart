import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yamete_kudasai/blocs/entityes/index.dart';

class VideoTile extends StatefulWidget {
  final Dadosbusca dados;
  final Function onTap;

  const VideoTile({Key key, this.dados, this.onTap}) : super(key: key);
  @override
  _VideoTileState createState() => _VideoTileState();
}

class _VideoTileState extends State<VideoTile> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () async {
              setState(() {
                // ignore: unnecessary_statements
                isLoading != isLoading;
              });
              await widget.onTap();
              setState(() {
                // ignore: unnecessary_statements
                isLoading != isLoading;
              });
            },
            child: AspectRatio(
              aspectRatio: 10 / 9,
              child: isLoading != true
                  ? CachedNetworkImage(
                      imageUrl: widget.dados.cover,
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Center(
                        child: Icon(Icons.error),
                      ),
                      fit: BoxFit.fill,
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ),
          Row(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Text(
                      widget.dados.title,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      widget.dados.sub,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              )),
            ],
          )
        ],
      ),
    );
  }
}
