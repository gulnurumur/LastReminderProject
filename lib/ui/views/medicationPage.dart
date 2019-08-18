import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:googlemapsflutter/models/Medication/pill.dart';
import 'package:provider/provider.dart';
import '../../global_bloc.dart';

class MedicationPage extends StatelessWidget {
  final Pill pill;
  MedicationPage(this.pill);

  @override
  Widget build(BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false, //bottom padding boyutlandır.
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.blue,
        ),
        centerTitle: true,
        title: Text(
          "Pill Details",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        elevation: 0.0,
      ),

      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              MainSection(pill: pill),
              SizedBox(
                height: 15,
              ),
              ExtendedSection(pill: pill),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.height * 0.6,
                  right: MediaQuery.of(context).size.height * 0.6,
                  top: 25,
                ),
                child: Container(
                  width: 280,
                  height: 70,
                  child: FlatButton(
                    color: Colors.blue,
                    shape: StadiumBorder(),
                    onPressed: () {
                      openAlertBox(context, _globalBloc);
                    },
                    child: Center(
                      child: Text(
                        "Delete Reminder",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  openAlertBox(BuildContext context, GlobalBloc _globalBloc) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
            ),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(18),
                    child: Center(
                      child: Text(
                        "Delete this reminder?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          _globalBloc.removePill(pill);
                          Navigator.popUntil(context, ModalRoute.withName('/'));
                        },
                        child: InkWell(
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2.743,
                            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30.0),
                              ),
                            ),
                            child: Text(
                              "Yes",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: InkWell(
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2.743,
                            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                            decoration: BoxDecoration(
                              color: Colors.red[700],
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(30.0)),
                            ),
                            child: Text(
                              "No",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class MainSection extends StatelessWidget {
  final Pill pill;

  MainSection({
    Key key,
    @required this.pill,
  }) : super(key: key);

  Hero makeIcon(double size) {
    if (pill.pillType == "Tablet") {
      return Hero(
        tag: pill.pillName + pill.pillType,
        child: Icon(
          Icons.battery_std,
          color: Colors.white,
          size: size,
        ),
      );
    } else if (pill.pillType == "Kapsul") {
      return Hero(
        tag: pill.pillName + pill.pillType,
        child: Icon(
          Icons.battery_alert,
          color: Colors.white,
          size: size,
        ),
      );
    } else if (pill.pillType == "Surup") {
      return Hero(
        tag: pill.pillName + pill.pillType,
        child: Icon(
          Icons.ac_unit,
          color: Colors.amber,
          size: size,
        ),
      );
    } else {
      return Hero(
        tag: pill.pillName + pill.pillType,
        child: Icon(
          Icons.accessibility,
          color: Colors.black,
          size: size,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          makeIcon(100),
          SizedBox(
            width: 15,
          ),
          Column(
            children: <Widget>[
              Hero(
                tag: pill.pillName,
                child: Material(
                  color: Colors.transparent,
                  child: MainInfoTab(
                    fieldTitle: "Pill name:",
                    fieldInfo: pill.pillName,
                  ),
                ),
              ),
              MainInfoTab(
                fieldTitle: "Dosage",
                fieldInfo: pill.dosage == 0
                    ? "Not specified"
                    : pill.dosage.toString() + "mg",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MainInfoTab extends StatelessWidget {
  final String fieldTitle;
  final String fieldInfo;

  MainInfoTab({
    Key key,
    @required this.fieldTitle,
    @required this.fieldInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.35,
      height: 100,
      child: ListView(
        padding: EdgeInsets.only(top: 15),
        shrinkWrap: true,
        children: <Widget>[
          Text(
            fieldTitle,
            style: TextStyle(
              fontSize: 17,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            fieldInfo,
            style: TextStyle(
              fontSize: 24,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class ExtendedSection extends StatelessWidget {
  final Pill pill;

  ExtendedSection({
    Key key,
    @required this.pill,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          ExtendedInfoTab(
            fieldTitle: "Pill Type:",
            fieldInfo:
                pill.pillType == "None" ? "Not specified" : pill.pillType,
          ),
          ExtendedInfoTab(
            fieldTitle: "Interval:",
            fieldInfo: "Every" +
                pill.interval.toString() +
                "hours | " +
                "${pill.interval == 24 ? "One time a day" : (24 / pill.interval).floor().toString() + "time a day"}",
          ),
          ExtendedInfoTab(
              fieldTitle: "Start time:",
              fieldInfo: pill.startTime[0] +
                  pill.startTime[1] +
                  ":" +
                  pill.startTime[2] +
                  pill.startTime[3]),
        ],
      ),
    );
  }
}

class ExtendedInfoTab extends StatelessWidget {
  final String fieldTitle;
  final String fieldInfo;

  ExtendedInfoTab({
    Key key,
    @required this.fieldTitle,
    @required this.fieldInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 18.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                fieldTitle,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              fieldInfo,
              style: TextStyle(
                fontSize: 18,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
