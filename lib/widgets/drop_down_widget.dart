import 'package:flutter/material.dart';

class DropDownWidget extends StatefulWidget {
  String value;
  List<String> typeList;
  DropDownWidget({this.value,this.typeList});
  @override
  _DropDownWidgetState createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.value,
      icon: Icon(
        Icons.arrow_drop_down,
        color: Colors.white,
      ),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(
        color: Colors.green,
      ),
      underline: Container(
        height: 2,
        color: Colors.green.shade900,
      ),
      onChanged: (newValue) {
        setState(() {
          widget.value = newValue;
        });
      },
      items: widget.typeList.map<DropdownMenuItem<String>>(
        (value) {
          return DropdownMenuItem<String>(
            child: Text(value),
            value: value,
          );
        },
      ).toList(),
    );
  }
}
