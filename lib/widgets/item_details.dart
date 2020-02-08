import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ytsm/models/movie.dart';
import 'package:ytsm/widgets/rate_star.dart';

class ItemDetails extends StatefulWidget {
  final Movie filter;
  ItemDetails(this.filter);

  @override
  _ItemDetailsState createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: 250,
                  width: 150,
                  margin: EdgeInsets.only(left: 8),
                  child: Image.network(widget.filter.largeCoverImage),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Container(
                    width: 200,
                    padding: EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Text(
                            widget.filter.titleLong,
                            style: Theme.of(context).textTheme.display1,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Wrap(
                          children: widget.filter.genres
                              .map(
                                (String gener) => Chip(
                                  backgroundColor: Colors.green,
                                  label: Text(
                                    gener,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                              .toList(),
                          spacing: 8,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            RateStar(widget.filter.rating, size: 45),
                            Text(
                              widget.filter.language,
                              style: Theme.of(context).textTheme.display3,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Title('Description'),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 8.0),
              child: Text(
                widget.filter.descriptionFull,
                style: Theme.of(context).textTheme.display2,
              ),
            ),
            Title('Trailler'),
            Container(
              height: 250,
              // TODO VideoPlayerWidget(),
            ),
            Title('Download Torrent File'),
            // Download Links
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 8.0),
              child: Wrap(
                children: widget.filter.torrents
                    .map(
                      (torrent) => ActionChip(
                        backgroundColor: Colors.green,
                        label: Text(
                          torrent.quality + '.' + torrent.type,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () async {
                          if (await canLaunch(torrent.url)) {
                            await launch(torrent.url);
                          } else {
                            throw 'Could not launch $torrent.url';
                          }
                        },
                      ),
                    )
                    .toList(),
                    spacing: 8,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}

class Title extends StatelessWidget {
  final String title;
  Title(this.title);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, top: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.display3,
      ),
    );
  }
}
