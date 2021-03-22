import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class VerticalGridTile extends StatefulWidget {
  final Function onTap;
  final Function onLongPress;
  final String title;
  final String imgUrl;
  final double textContainerHeight;
  final String widgetUrl;

  const VerticalGridTile(
      {Key key,
      this.onTap,
      this.title,
      this.imgUrl,
      this.onLongPress,
      this.textContainerHeight = 90,
      this.widgetUrl})
      : super(key: key);
  @override
  _VerticalGridTileState createState() => _VerticalGridTileState();
}

class _VerticalGridTileState extends State<VerticalGridTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () async {
        await widget.onLongPress();
      },
      onTap: () async {
        await widget.onTap();
      },
      child: GridTile(
        child: CachedNetworkImage(
          imageUrl: widget.imgUrl,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Center(
            child: Icon(Icons.error),
          ),
          fit: BoxFit.fill,
        ),
        footer: Container(
          color: Colors.black54,
          height: widget.textContainerHeight,
          child: Align(
            alignment: Alignment.center,
            child: Text(widget.title,
                maxLines: 2, style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}

class VerticalGridTilee extends StatefulWidget {
  final Function onTap;
  final Function onLongPress;
  final String title;
  final String imgUrl;
  final double textContainerHeight;

  const VerticalGridTilee(
      {Key key,
      this.onTap,
      this.title,
      this.imgUrl,
      this.onLongPress,
      this.textContainerHeight = 90})
      : super(key: key);
  @override
  _VerticalGridTileeState createState() => _VerticalGridTileeState();
}

class _VerticalGridTileeState extends State<VerticalGridTilee> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () async {
        await widget.onLongPress();
      },
      onTap: () async {
        setState(() {
          isLoading = !isLoading;
        });
        await widget.onTap();
        setState(() {
          isLoading = !isLoading;
        });
      },
      child: GridTile(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : CachedNetworkImage(
                imageUrl: widget.imgUrl,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Center(
                  child: Icon(Icons.error),
                ),
                fit: BoxFit.fill,
              ),
        footer: Container(
          color: Colors.black54,
          height: widget.textContainerHeight,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              widget.title,
              maxLines: 2,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
