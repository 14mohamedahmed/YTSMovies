import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytsm/providers/theme_provider.dart';

class SettingPage extends StatefulWidget {
  final Key key;
  SettingPage(this.key) : super(key: key);
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return SafeArea(
      top: true,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Light Mode',
                    style: Theme.of(context).textTheme.headline1
                  ),
                  Switch(
                    value: themeProvider.isDark,
                    onChanged: (val){
                      themeProvider.setThemeData = val;
                    },
                    activeColor: Colors.green,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
