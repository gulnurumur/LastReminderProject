import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool _value = false;

  void _onChanged (bool value){
    setState(() {
      _value =value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Ayarlar"),
      ),
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Column(
          children: <Widget>[
            new Switch(
              value: _value ,
              onChanged: (bool value){_onChanged(value);},
            ),
          ],
        ),
      ),
      
    );
  }
}