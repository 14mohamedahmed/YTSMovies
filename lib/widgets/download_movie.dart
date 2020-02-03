import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DownloadMovie extends StatelessWidget {
  final String quality;
  final String type;
  final String url;
  DownloadMovie({
    this.quality,
    this.type,
    this.url,
  });
  _lunchUrl() async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      shape: Border.all(color: Colors.green),
      onPressed: _lunchUrl,
      icon: Icon(
        Icons.file_download,
        color: Colors.green,
      ),
      label: Text(
        quality + '.' + type,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }
}
