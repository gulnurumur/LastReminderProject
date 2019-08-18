import 'package:flutter/material.dart';

class MeasurementPage extends StatefulWidget {
  @override
  _MeasurementState createState() => _MeasurementState();
}

class _MeasurementState extends State<MeasurementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Ölçüm"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          //mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RaisedButton(
              //edge Insets eklenecek araştır.
              onPressed: (){},
              child: Text("Tansiyon",style: TextStyle(fontSize: 20),),
            ),
            RaisedButton(
              onPressed: (){},
              child: Text("Kilo",style: TextStyle(fontSize: 20),),
            ),
            RaisedButton(
              onPressed: (){},
              child: Text("Kan şekeri seviyesi (Yemekten Önce)",style: TextStyle(fontSize: 20),),
            ),
            RaisedButton(
              onPressed: (){},
              child: Text("Kan şekeri seviyesi (Yemekten sonra)",style: TextStyle(fontSize: 20),),
            ),
          ],
        ),
      ),
    );
  }
}