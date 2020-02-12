import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ytsm/models/movie.dart';

class MovieDetails extends StatefulWidget {
  final Movie movie;
  MovieDetails(this.movie);
  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: MediaQuery.of(context).size.height * 0.6,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              widget.movie.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            background: Hero(
              tag: widget.movie.id,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: <Widget>[
                    Image.network(
                      widget.movie.largeCoverImage,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Wrap(
                children: widget.movie.genres
                    .map(
                      (String gener) => Chip(
                        backgroundColor: Colors.green,
                        label: Text(
                          gener,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                spacing: 8,
              ),
            ),
            Title('Description'),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 8.0),
              child: Text(
                widget.movie.descriptionFull,
                style: Theme.of(context).textTheme.headline2,
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
                children: widget.movie.torrents
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
          ]),
        ),
      ],
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
        style: Theme.of(context).textTheme.headline3,
      ),
    );
  }
}
